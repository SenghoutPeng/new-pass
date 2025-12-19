<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Storage;
use App\Models\Transaction;
use App\Models\User;
use App\Models\Event;
use App\Models\EventDate;
use App\Models\Ticket;
use App\Models\Payment;
use App\Models\Organization;
use App\Models\Admin;

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
            'new_balance' => $user->balance,
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

        if (!$user->status) {
            return response()->json(['message' => 'Your account is disabled. Please contact support.'], 403);
        }

        // Fetch event with organization (only active organizations)
        $event = Event::with('organization')
            ->whereHas('organization', function ($query) {
                $query->where('status', true);
            })
            ->where('event_id', $request->event_id)
            ->first();

        $eventDate = EventDate::where('event_date_id', $request->event_date_id)->first();

        if (!$event || !$eventDate) {
            return response()->json(['error' => 'Event or Event Date not found'], 404);
        }

        if ($event->status == 'pending') {
            return response()->json(['message' => 'Event has not been approved'], 403);
        }

        if ($eventDate->total_ticket < $request->quantity) {
            return response()->json(['error' => 'Not enough tickets available'], 400);
        }

        $totalPrice = $eventDate->ticket_price * $request->quantity;

        if ($user->balance < $totalPrice) {
            return response()->json(['error' => 'Insufficient balance'], 400);
        }

        // Deduct user balance
        $user->decrement('balance', $totalPrice);

        // Create payment
        $payment = Payment::create([
            'user_id' => $user->user_id,
            'event_id' => $event->event_id,
            'amount' => $totalPrice,
            'quantity' => $request->quantity,
            'payment_status' => 'Completed',
            'payment_date' => now(),
        ]);

        // Create tickets with check-in codes
        $checkInCodes = [];
        for ($i = 0; $i < $request->quantity; $i++) {
            $sequenceNumber = str_pad($i + 1, 2, '0', STR_PAD_LEFT);
            $code = "{$payment->payment_id}-{$sequenceNumber}";
            $checkInCodes[] = $code;

            Ticket::create([
                'user_id' => $user->user_id,
                'event_id' => $event->event_id,
                'event_date_id' => $eventDate->event_date_id,
                'payment_id' => $payment->payment_id,
                'purchase_date' => now(),
                'ticket_code' => $code,
                'total_price' => $eventDate->ticket_price,
                'status' => 'bought'
            ]);
        }

        // Get organization_id
        $organizationId = $event->org_id;

        $commission = $totalPrice * 0.05;

        // Create Transaction record
        Transaction::create([
            'amount' => $totalPrice,
            'user_id' => $user->user_id,
            'org_id' => $organizationId,
            'event_id' => $event->event_id,
            'payment_id' => $payment->payment_id,
            'commission_amount' => $commission,
        ]);

        // Update organization balance
        Organization::where('org_id', $organizationId)
            ->increment('balance', $totalPrice - $commission);

        // Update total_ticket for the specific event date
        $eventDate->decrement('total_ticket', $request->quantity);

        // Update admin balance
        Admin::where('admin_id', $event->admin_id)
            ->increment('balance', $commission);

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

        // Fetch all tickets with event and rating info
        $tickets = Ticket::where('ticket.user_id', $userId)
            ->join('event', 'ticket.event_id', '=', 'event.event_id')
            ->leftJoin('rating as user_rating', function ($join) use ($userId) {
                $join->on('user_rating.event_id', '=', 'ticket.event_id')
                    ->where('user_rating.user_id', '=', $userId);
            })
            ->select(
                'event.event_id',
                'event.title',
                'ticket.ticket_id',
                'ticket.ticket_code',
                'ticket.total_price',
                'ticket.purchase_date',
                'user_rating.rating_id'
            )
            ->orderBy('ticket.purchase_date', 'desc')
            ->get();

        // Group tickets by event in PHP
        $eventsWithTickets = $tickets->groupBy('event_id')->map(function ($eventTickets) {
            $firstTicket = $eventTickets->first();

            return [
                'event_id' => $firstTicket->event_id,
                'title' => $firstTicket->title,
                'total_price_paid' => $eventTickets->sum('total_price'),
                'total_tickets_purchased' => $eventTickets->count(),
                'checkin_codes' => $eventTickets->sortBy('ticket_id')->pluck('ticket_code')->unique()->implode(','),
                'last_purchase_date' => $eventTickets->max('purchase_date'),
                'first_purchase_date' => $eventTickets->min('purchase_date'),
                'has_rated' => $eventTickets->contains(function($ticket) {
                    return $ticket->rating_id !== null;
                })
            ];
        })->values();

        activity()
            ->causedBy($user)
            ->log('User viewed own tickets');

        return response()->json([
            'tickets' => $eventsWithTickets
        ], 200);
    }




    public function profile()
    {
        // Get the currently logged-in user
        $user = Auth::guard()->user();

        // Get the logged in user's information
        $userInfo = User::where('user_id', $user->user_id)->first();

        if ($userInfo) {
            $userInfo->profile_image = $userInfo->profile_image
                ? asset('storage/' . $userInfo->profile_image)
                : asset('storage/User/default.png');
        }

        $totalSpending = Ticket::where('user_id', $user->user_id)
            ->sum('total_price');

        $totalPurchases = Ticket::where('user_id', $user->user_id)
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
            $filename = 'user_' . $userId . '_' . time() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('profile_images', $filename, 'public');
            $updateData['profile_image'] = $path;

            // Optional: Delete old profile image if it exists
            if ($user->profile_image) {
                Storage::disk('public')->delete($user->profile_image);
            }
        }

        if (!empty($updateData)) {
            $user->update($updateData);

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
