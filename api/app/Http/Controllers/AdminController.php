<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\EventDate;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Models\Event;
use App\Models\User;
use Illuminate\Support\Facades\Storage;
use App\Models\Organization;
use App\Models\Ticket;
use App\Models\Payment;
use App\Models\Transaction;
use App\Models\EventCategory;
use Spatie\Activitylog\Models\Activity;
use App\Models\Admin;

class AdminController extends Controller
{

    public function getAllOrganizations()
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $totalOrganizations = Organization::count();
        $newOrganizations = Organization::whereMonth('created_at', Carbon::now()->month)
            ->whereYear('created_at', Carbon::now()->year)
            ->count();

        $organizationList = Organization::all();

        $totalBalance = Organization::sum('balance');

        $organizationList = $organizationList->map(function ($org) {
            if ($org->profile_image && $org->profile_image !== '') {
                $org->profile_image = url('storage/' . $org->profile_image);
            } else {
                $org->profile_image = url('storage/Organization/default.png');
            }
            return $org;
        });

        return response()->json([
            'total_organizations' => $totalOrganizations,
            'new_organizations_this_month' => $newOrganizations,
            'total_balance' => $totalBalance,
            'organizations' => $organizationList,
        ]);
    }




    public function getAllUsers()
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $totalUsers = User::count();
        $newUsers = User::whereMonth('created_at', Carbon::now()->month)
            ->whereYear('created_at', Carbon::now()->year)
            ->count();
        $totalBalance = User::sum('balance');
        $userList = User::all();

        $userList = $userList->map(function ($user) {
            if (empty($user->profile_image)) {
                $user->profile_image = url('storage/User/default.png');
            } else {
                $user->profile_image = url('storage/' . $user->profile_image);
            }
            return $user;
        });

        return response()->json([
            'total_users' => $totalUsers,
            'new_users_this_month' => $newUsers,
            'total_balance' => $totalBalance,
            'users' => $userList
        ]);
    }




    public function transaction(Request $request)
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $keyword = $request->keyword;
        $filterBy30Days = $request->has('last_30_days');

        $totalEvents = Event::count();
        $totalOrganizations = Organization::count();
        $totalTicketSold = Ticket::count();

        // Fetch transactions with relationships
        $transactionQuery = Transaction::with(['organization', 'event', 'payment']);

        if (!empty($keyword)) {
            $transactionQuery->where(function($query) use ($keyword) {
                $query->whereHas('organization', function($q) use ($keyword) {
                    $q->where('org_name', 'like', '%' . $keyword . '%');
                })->orWhereHas('event', function($q) use ($keyword) {
                    $q->where('title', 'like', '%' . $keyword . '%');
                });
            });
        }

        if ($filterBy30Days) {
            $date30DaysAgo = now()->subDays(30);
            $transactionQuery->where('created_at', '>=', $date30DaysAgo);
        }

        $transactions = $transactionQuery->orderByDesc('created_at')->get();

        // Group by date, organization, event and sum quantities
        $transactionList = $transactions->groupBy(function($transaction) {
            return $transaction->created_at->format('Y-m-d') . '|' .
                   $transaction->organization->org_name . '|' .
                   $transaction->event->title . '|' .
                   $transaction->commission_amount;
        })->map(function($group) {
            $first = $group->first();
            return [
                'created_at' => $first->created_at->format('Y-m-d'),
                'org_name' => $first->organization->org_name,
                'title' => $first->event->title,
                'ticketsold' => $group->sum(function($t) { return $t->payment->quantity; }),
                'commission_amount' => $first->commission_amount
            ];
        })->sortByDesc('created_at')->values();

        return response()->json([
            'total_event' => $totalEvents,
            'total_organization' => $totalOrganizations,
            'ticket_sold' => $totalTicketSold,
            'transactions' => $transactionList
        ]);
    }




    public function dashboard()
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        // Counts for total users, total organizations, total ticket sold
        $totalUsers = User::count();
        $totalOrganizations = Organization::count();
        $ticketSold = Ticket::where('status', 'bought')->count();

        // Get the revenue by calculating the sum of all amount paid in the payment table
        $totalRevenue = Payment::where('payment_status', 'Completed')->sum('amount');

        // Get top events by tickets sold
        $tickets = Ticket::with(['event.organization'])
            ->where('status', 'bought')
            ->get();

        $topEventsByTicket = $tickets->groupBy('event_id')->map(function($eventTickets) {
            $first = $eventTickets->first();
            return [
                'org_name' => $first->event->organization->org_name,
                'title' => $first->event->title,
                'total_tickets_sold' => $eventTickets->count(),
                'revenue' => $eventTickets->sum('total_price')
            ];
        })->sortByDesc('total_tickets_sold')->values();

        return response()->json([
            'total_users' => $totalUsers,
            'total_organizations' => $totalOrganizations,
            'ticket_sold' => $ticketSold,
            'total_revenue' => $totalRevenue,
            'top_events_by_ticket_sold' => $topEventsByTicket
        ]);
    }





    public function activityLog()
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $activity_log = Activity::select('created_at', 'description', 'subject_type', 'event', 'causer_id', 'causer_type')
            ->orderBy('created_at', 'desc')
            ->get();

        $all_activity_logs = [];
        foreach ($activity_log as $log) {
            $name = '';
            if ($log->causer_type === 'App\\Models\\User') {
                $user = User::where('user_id', $log->causer_id)->first();
                $name = $user ? $user->username : '';
            } elseif ($log->causer_type === 'App\\Models\\Organization') {
                $org = Organization::where('org_id', $log->causer_id)->first();
                $name = $org ? $org->org_name : '';
            } elseif ($log->causer_type === 'App\\Models\\Admin') {
                $adminUser = Admin::where('admin_id', $log->causer_id)->first();
                $name = $adminUser ? $adminUser->username : '';
            }

            $all_activity_logs[] = [
                'date' => $log->created_at,
                'detail' => $log->description,
                'activity' => $log->event,
                'causer_name' => $name
            ];
        }

        return response()->json([
            'all_activity_logs' => $all_activity_logs
        ]);
    }




    public function profile()
    {
        $admin = Auth::guard('admin-api')->user();
        $adminId = $admin->admin_id;

        $adminInfo = Admin::where('admin_id', $adminId)->first();
        $adminInfo->profile_image = asset($adminInfo->profile_image);

        return response()->json([
            'admin_information' => $adminInfo
        ]);
    }




    public function updateEvent(Request $request)
    {
        $admin = Auth::guard('admin-api')->user();
        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $event = Event::where('event_id', $request->event_id)->first();
        if (!$event) {
            return response()->json(['error' => 'Event not found'], 404);
        }

        // Validation rules depend on status
        $validate = [
            'title' => ['sometimes', 'string', 'max:255', Rule::unique('event', 'title')->ignore($request->event_id, 'event_id')],
            'description' => 'sometimes|string',
            'location' => 'sometimes|string|max:255',
            'event_category_id' => 'sometimes|exists:event_category,event_category_id',
            'banner' => 'sometimes|nullable|image|mimes:jpeg,png,jpg,gif,svg,webp,avif|max:2048',
        ];

        if (in_array($event->status, ['pending', 'rejected'])) {
            // Admin can edit everything including dates
            $validate['dates'] = 'array|min:1';
            $validate['dates.*.event_date_id'] = 'exists:event_date,event_date_id';
            $validate['dates.*.event_date'] = 'after_or_equal:today';
            $validate['dates.*.event_time'] = 'date_format:H:i:s';
            $validate['dates.*.ticket_price'] = 'numeric|min:0';
            $validate['dates.*.total_ticket'] = 'integer|min:1';
        } elseif ($event->status === 'approved') {
            // Admin can only increase total_ticket
            $validate['dates'] = 'sometimes|array|min:1';
            $validate['dates.*.event_date_id'] = [
                'required', Rule::exists('event_date', 'event_date_id')->where('event_id', $request->event_id)
            ];
            $validate['dates.*.total_ticket'] = 'required|integer|min:1';

            // Validate that total_ticket does not decrease
            foreach ($request->input('dates', []) as $date) {
                if (!empty($date['event_date_id'])) {
                    $current = EventDate::find($date['event_date_id']);
                    if ($current && $date['total_ticket'] < $current->total_ticket) {
                        return response()->json([
                            'error' => "Cannot reduce tickets below current value: {$current->total_ticket}"
                        ], 422);
                    }
                }
            }
        }

        $validated = $request->validate($validate);

        // Update event fields
        $fieldsToUpdate = ['title', 'description', 'location', 'event_category_id'];
        foreach ($fieldsToUpdate as $field) {
            if (array_key_exists($field, $validated)) {
                $event->$field = $validated[$field];
            }
        }

        // Handle banner upload
        if ($request->hasFile('banner')) {
            $file = $request->file('banner');
            $filename = 'event_' . $request->event_id . '_' . time() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('banners', $filename, 'public');
            $event->banner = $path;
        }

        if (in_array($event->status, ['pending', 'rejected'])) {
            $event->status = 'pending';
            $event->admin_id = $admin->admin_id;
            $event->reviewed_at = now();
        }

        $event->save();

        // Update event dates
        if (isset($validated['dates'])) {
            if (in_array($event->status, ['pending', 'rejected'])) {
                $existingDatesCount = EventDate::where('event_id', $request->event_id)->count();
                $newDatesCount = 0;

                // Count Dates wanted to add
                foreach ($validated['dates'] as $dateInfo) {
                    if (empty($dateInfo['event_date_id'])) {
                        $newDatesCount++;
                    }
                }

                // Validate before processing
                if ($existingDatesCount + $newDatesCount > 3) {
                    return response()->json([
                        'error' => 'An event cannot have more than 3 dates.',
                        'details' => [
                            'current_dates' => $existingDatesCount,
                        ]
                    ], 422);
                }

                foreach ($validated['dates'] as $dateInfo) {
                    if (!empty($dateInfo['event_date_id'])) {
                        // Update existing date
                        EventDate::where('event_date_id', $dateInfo['event_date_id'])
                            ->where('event_id', $request->event_id)
                            ->update($dateInfo);
                    } else {
                        // Insert new date
                        EventDate::create(array_merge(
                            ['event_id' => $request->event_id],
                            $dateInfo
                        ));
                    }
                }
            } elseif ($event->status === 'approved') {
                foreach ($validated['dates'] as $dateInfo) {
                    EventDate::where('event_date_id', $dateInfo['event_date_id'])
                        ->where('event_id', $request->event_id)
                        ->update(['total_ticket' => $dateInfo['total_ticket']]);
                }
            }
        }

        activity()
            ->causedBy(Auth::guard('admin-api')->user())
            ->withProperties(['event_id' => $request->event_id, 'event_title' => $event->title])
            ->log('Admin updated event');

        return response()->json([
            'message' => 'Event updated successfully by Admin',
            'event' => $event->fresh()
        ], 200);
    }





    public function toggleUserStatus($userId)
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $user = User::where('user_id', $userId)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $user->status = !$user->status;
        $user->save();

        if (!$user->status) {
            $user->tokens()->delete();
        }

        return response()->json([
            'message' => $user->status ? 'User activated successfully' : 'User deactivated successfully',
            'status' => $user->status
        ]);
    }




    public function updateUserInfo(Request $request, $userId)
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $userToUpdate = User::where('user_id', $userId)->first();

        if (!$userToUpdate) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $rules = [
            'username' => 'required|string|max:255',
            'email' => [
                'required',
                'email',
                Rule::unique('user', 'email')->ignore($userToUpdate->user_id, 'user_id'),
            ],
            'profile_image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp,avif|max:2048',
        ];

        $validatedData = $request->validate($rules);

        if ($request->hasFile('profile_image')) {
            $file = $request->file('profile_image');
            $filename = 'user_' . $userId . '_' . time() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('users', $filename, 'public');

            $validatedData['profile_image'] = $path;

            if ($userToUpdate->profile_image && Storage::disk('public')->exists($userToUpdate->profile_image)) {
                Storage::disk('public')->delete($userToUpdate->profile_image);
            }
        } else {
            unset($validatedData['profile_image']);
        }

        $userToUpdate->update($validatedData);

        activity()
            ->causedBy(Auth::guard('admin-api')->user())
            ->withProperties(['user_id' => $userId])
            ->log('Admin updated user profile');

        $user = User::where('user_id', $userId)->first();

        return response()->json([
            'message' => 'Updated Successfully',
            'user' => $user
        ], 200);
    }




    public function toggleOrganizationStatus($organizationId)
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $organization = Organization::where('org_id', $organizationId)->first();

        if (!$organization) {
            return response()->json(['error' => 'Organization not found'], 404);
        }

        if (!$organization->status) {
            $organization->tokens()->delete();
        }

        $organization->status = !$organization->status;
        $organization->save();

        return response()->json([
            'message' => $organization->status ? 'Organization activated successfully' : 'Organization deactivated successfully',
            'status' => $organization->status
        ]);
    }




    public function updateOrganizationInfo(Request $request, $organizationId)
    {
        $admin = Auth::guard('admin-api')->user();

        if (!$admin) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $validated = $request->validate([
            'org_name'       => 'string|max:255',
            'email'          => 'email|max:255',
            'contact_name'   => 'string|max:255',
            'contact_email'  => 'email|max:255',
            'contact_phone'  => 'string|max:20',
            'profile_image'  => 'image|mimes:jpeg,png,jpg,gif|max:2048'
        ]);

        if ($request->hasFile('profile_image')) {
            $file = $request->file('profile_image');
            $filename = 'org_' . $organizationId . '_' . time() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('organizations', $filename, 'public');
            $validated['profile_image'] = $path;
        }

        Organization::where('org_id', $organizationId)->update($validated);
        $organization = Organization::where('org_id', $organizationId)->first();

        activity()
            ->causedBy(Auth::guard('admin-api')->user())
            ->log('Admin upated organization profile');

        return response()->json([
            'message' => 'Profile updated successfully.',
            'organization_information' => $organization
        ], 200);
    }




    public function getAllEvents(Request $request)
{
    $admin = Auth::guard('admin-api')->user();
    if (!$admin) {
        return response()->json(['error' => 'Unauthorized'], 401);
    }

    $keyword = $request->keyword;
    $filter = $request->filter;

    $totalEvents = Event::count();

    // Base query for events
    $eventQuery = Event::with('eventCategory', 'eventDates');

    if (!empty($keyword)) {
        $eventQuery->where(function($query) use ($keyword) {
            $query->where('title', 'like', '%' . $keyword . '%')
                  ->orWhere('description', 'like', '%' . $keyword . '%');
        });
    }

    if (!empty($filter)) {
        $eventQuery->whereHas('eventCategory', function($query) use ($filter) {
            $query->where('event_category_name', 'like', $filter);
        });
    }

    $events = $eventQuery->orderBy('title')->get();

    $totalApproved = Event::where('status', 'approved')->count();

    // Get completed events (all dates have passed)
    $completedEvents = Event::with('eventDates')
        ->get()
        ->filter(function($event) {
            // Event is completed if ALL dates are in the past
            return $event->eventDates->every(function($date) {
                $eventDateTime = Carbon::parse($date->event_date . ' ' . $date->event_time);
                return $eventDateTime->isPast();
            });
        })
        ->values();

    // Get upcoming events (at least one future date)
    $upcomingEvents = Event::where('status', 'approved')
        ->with('eventDates')
        ->get()
        ->filter(function($event) {
            // Event is upcoming if at least ONE date is in the future
            return $event->eventDates->some(function($date) {
                $eventDateTime = Carbon::parse($date->event_date . ' ' . $date->event_time);
                return $eventDateTime->isFuture();
            });
        })
        ->values();

    $eventCategory = EventCategory::select('event_category_id', 'event_category_name')->get();

    $eventWithDates = [];
    foreach ($events as $event) {
        $eventFormattedDates = [];

        foreach ($event->eventDates as $date) {
            $eventFormattedDates[] = [
                'event_date_id' => $date->event_date_id,
                'event_date' => $date->event_date,
                'event_time' => $date->event_time,
                'ticket_price' => $date->ticket_price,
                'total_ticket' => $date->total_ticket,
            ];
        }

        $firstDay = $event->eventDates->min('event_date');
        $lastDay = $event->eventDates->max('event_date');

        $eventWithDates[] = [
            'event_id' => $event->event_id,
            'title' => $event->title,
            'description' => $event->description,
            'location' => $event->location,
            'event_category_id' => $event->event_category_id,
            'event_category_name' => $event->eventCategory->event_category_name,
            'status' => $event->status,
            'banner' => $event->banner,
            'first_event_day' => $firstDay,
            'last_event_day' => $lastDay,
            'dates' => $eventFormattedDates
        ];
    }

    activity()
        ->causedBy(Auth::guard('admin-api')->user())
        ->log('Admin viewed all events');

    return response()->json([
        'event_category' => $eventCategory,
        'events' => $eventWithDates,
        'total_events' => $totalEvents,
        'total_approved_events' => $totalApproved,
        'official_events' => $completedEvents,
        'upcoming_events' => $upcomingEvents,
    ], 200);


}
public function updateInfo(Request $request)
    {
        $admin = Auth::guard('admin-api')->user();
        $adminId = $admin->admin_id;

        $validated = $request->validate([
            'username' => 'nullable|string|max:255',
            'email' => ['nullable', 'email', 'max:255', Rule::unique('admin')->ignore($adminId, 'admin_id')],
            'profile_image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp,avif|max:2048'
        ]);
        $adminToUpdate = Admin::where('admin_id', $adminId)->first();
        $profileImagePath = $adminToUpdate->profile_image;

        if ($request->hasFile('profile_image')) {
        $file = $request->file('profile_image');
        $filename = time() . '_' . $file->getClientOriginalName();
        $path = $file->storeAs('Admin', $filename, 'public');
        $profileImagePath = 'Admin/' . $filename;
    }

    // Update using the $admin instance directly
    $admin->update([
        'username'      => $request->username ?? $admin->username,
        'email'         => $request->email ?? $admin->email,
        'profile_image' => $profileImagePath,
    ]);


        activity()
            ->causedBy($admin)
            ->withProperties(['admin_id' => $adminId])
            ->log('Admin updated profile info');

        return response()->json([
            'message' => 'Profile updated successfully!',
            'admin_information' => $admin->fresh()
        ], 200);
    }

}
