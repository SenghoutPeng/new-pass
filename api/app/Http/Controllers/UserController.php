<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;
use App\Models\User;
use App\Models\Event;
use App\Models\Ticket;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{

    public function recharge(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|min:0.01',
        ]);

        $user = Auth::user();

        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        $user->increment('balance', $request->amount);
        return response()->json([
            'message' => 'You recharged successfully',
            'new_balance' => $user->balance, // Optionally return the new balance
        ], 200);
    }




    public function buyTicket(Request $request)
        {
            // Validation
            $request->validate([
                'event_id' => 'required|exists:event,event_id',
                'event_date_id' => 'required|exists:event_date,event_date_id',
                'quantity' => 'required|integer|min:1|max:3',
            ]);

            // Get the authenticated user
            $user = Auth::user();

            // If user is not authenticated, return unauthorized
            if (!$user) {
                return response()->json(['message' => 'Unauthenticated.'], 401);
            }

            if(!$user->status)
            {
                return response()->json(['message' => 'Your account is disabled. Please contact support.'], 403);
            }

            // Fetch event and specific event date
            $event = DB::table('event')
                ->join('organization','organization.org_id','=','event.org_id')
                ->where('event_id', $request->event_id)->where('organization.status',true)->first();
            $eventDate = DB::table('event_date')->where('event_date_id', $request->event_date_id)->first();

            if (!$event || !$eventDate) {
                return response()->json(['error' => 'Event or Event Date not found'], 404);
            }

            if ($event->status == 'pending') {
                return response()->json(['message' => 'Event has not been approved'], 403);
            }

            $currentTotalTickets = DB::table('event_date')->where('event_date_id', $eventDate->event_date_id)->value('total_ticket');
            if ($currentTotalTickets < $request->quantity) {
                return response()->json(['error' => 'Not enough tickets available'], 400);
            }

            $totalPrice = $eventDate->ticket_price * $request->quantity;

            $currentUserBalance = DB::table('user')->where('user_id', $user->user_id)->value('balance');
            if ($currentUserBalance < $totalPrice) {
                return response()->json(['error' => 'Insufficient balance'], 400);
            }

            DB::table('user')->where('user_id', $user->user_id)->update([
                'balance' => DB::raw("balance - " . $totalPrice)
            ]);

            // Create payment
            $paymentId = DB::table('payment')->insertGetId([
                'user_id' => $user->user_id,
                'event_id' => $event->event_id,
                'amount' => $totalPrice,
                'quantity' => $request->quantity,
                'payment_status' => 'Completed',
                'payment_date' => now(),
            ], 'payment_id');

            $checkInCodes = [];
            for ($i = 0; $i < $request->quantity; $i++) {
                $sequenceNumber = str_pad($i + 1, 2, '0', STR_PAD_LEFT);
                $code = "{$paymentId}-{$sequenceNumber}";
                $checkInCodes[] = $code;

                DB::table('ticket')->insert([
                    'user_id' => $user->user_id,
                    'event_id' => $event->event_id,
                    'event_date_id' => $eventDate->event_date_id,
                    'payment_id' => $paymentId,
                    'purchase_date' => now(),
                    'ticket_code' => $code,
                    'total_price' => $eventDate->ticket_price,
                    'status' => 'bought'
                ]);
            }

            // Get organization_id
            $organizationId = DB::table('organization')
                ->join('event', 'event.org_id', '=', 'organization.org_id')
                ->where('event.event_id', $event->event_id)
                ->value('organization.org_id');

            $commission = $totalPrice * 0.05;

            // Create Transaction record
            Transaction::create([
                'amount' => $totalPrice,
                'user_id' => $user->user_id,
                'org_id' => $organizationId,
                'event_id' => $event->event_id,
                'payment_id' => $paymentId,
                'commission_amount' => $commission,
            ]);

            // Update organization balance
            DB::table('organization')->where('org_id', $organizationId)->update([
                'balance' => DB::raw("balance + " . ($totalPrice - $commission))
            ]);
                    // Update total_ticket for the specific event date
            DB::table('event_date')->where('event_date_id', $eventDate->event_date_id)->update([
                'total_ticket' => DB::raw("total_ticket - " . $request->quantity)
            ]);

            // Update admin balance
            DB::table('admin')->where('admin_id', $event->admin_id)->update([
                'balance' => DB::raw("balance + " . $commission)
            ]);

            activity()
                ->causedBy(Auth::user())
                ->withProperties([
                    'event_id' => $event->event_id,
                    'event_date_id' => $eventDate->event_date_id,
                    'quantity' => $request->quantity,
                    'total_price' => $totalPrice
                ])
                ->log('User bought ticket');

            return response()->json([
                'message' => 'Ticket(s) purchased successfully',
                'checkin_codes' => $checkInCodes
            ], 200);
        }





        public function getUserTickets()
        {
            $user = Auth::user();
            $userId = $user->user_id;

            $eventsWithTickets = Event::query()
                ->whereHas('tickets', function ($query) use ($userId) {
                    $query->where('user_id', $userId);
                })
                ->withSum(['tickets as total_price_paid' => function($query) use ($userId) {
                    $query->where('user_id', $userId);
                }], 'total_price')
                ->withCount(['tickets as total_tickets_purchased' => function($query) use ($userId) {
                    $query->where('user_id', $userId);
                }])
                ->withMax(['tickets as last_purchase_date' => function($query) use ($userId) {
                    $query->where('user_id', $userId);
                }], 'purchase_date')
                ->withMin(['tickets as first_purchase_date' => function($query) use ($userId) {
                    $query->where('user_id', $userId);
                }], 'purchase_date')
                ->withExists(['ratings as has_rated' => function($query) use ($userId) {
                    $query->where('user_id', $userId);
                }])
                ->addSelect([
                    'checkin_codes' => Ticket::selectRaw("string_agg(ticket_code, ',' ORDER BY ticket_id)")
                        ->whereColumn('event_id', 'event.event_id')
                        ->where('user_id', $userId)
                ])
                ->orderByDesc('last_purchase_date')
                ->get();

            activity()
                ->causedBy($user)
                ->log('User viewed own tickets');

            return response()->json([
                'tickets' => $eventsWithTickets
            ], 200);
        }




        public function profile()
        {
            // Get the currently logged-in user user
            $user = Auth::guard()->user();
            // Get the logged in user's id
            $userId = $user->user_id;
            // Get the logged in user's information
            $userInfo = DB::table('user')->where('user_id', $userId)->first();

            if ($userInfo) {
                $userInfo->profile_image = $userInfo->profile_image
            ? asset('storage/' . $userInfo->profile_image)
            : asset('storage/User/default.png');
            }
            $totalSpending = DB::table('ticket')
            ->where('user_id', $userId)
            ->sum('total_price');

            $totalPurchases = DB::table('ticket')
                            ->where('user_id', $userId)
                            ->count('ticket_id');
            if ($userInfo) {
            $userInfo->total_spending = $totalSpending;
            $userInfo->total_purchases = $totalPurchases;
            }

            return response()->json([
                'user_information' => $userInfo
            ]);
        }




        public function updateInfo(Request $request)
        {
            $user = Auth::user();
            $userId = $user->user_id;

            $validated = $request->validate([
                'username' => 'string|max:255',
                'email' => ['sometimes', 'email', 'max:255', Rule::unique('user')->ignore($userId, 'user_id')],
                'profile_image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp,avif|max:2048'
            ]);

            $updateData = [];

            if (isset($validated['username'])) {
                $updateData['username'] = $validated['username'];
            }
            if (isset($validated['email'])) {
                $updateData['email'] = $validated['email'];
            }

            if ($request->hasFile('profile_image')) {
                $file = $request->file('profile_image');
                $filename = 'user_' . $userId . '_' . time() . '.' . $file->getClientOriginalExtension(); // Changed 'org' to 'user' for clarity
                $path = $file->storeAs('profile_images', $filename, 'public'); // Changed folder name for clarity
                $updateData['profile_image'] = $path;

                // Optional: Delete old profile image if it exists
                if ($user->profile_image) {
                    Storage::disk('public')->delete($user->profile_image);
                }
            }

            if (!empty($updateData)) {
                User::where('user_id', $userId)->update($updateData);

                activity()
                    ->causedBy($user)
                    ->withProperties(['user_id' => $userId])
                    ->log('User updated profile info');

                return response()->json([
                    'message' => 'Profile updated successfully!',
                    'user_information' => $user->fresh()
                ], 200);
            }

            return response()->json([
                'message' => 'No changes submitted.',
            ], 200);
        }
    }
