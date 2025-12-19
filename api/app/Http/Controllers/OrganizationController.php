<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Models\EventDate;
use App\Models\Ticket;
use App\Models\Payment;
use App\Models\Transaction;
use App\Models\CheckinLog;
use App\Models\Organization;

class OrganizationController extends Controller
{
    public function researveTicket(Request $request)
    {
        $request->validate([
            'event_id' => 'required|exists:event,event_id',
            'event_date_id' => 'required|exists:event_date,event_date_id',
            'quantity' => 'required|integer|min:1',
        ]);

        // Fetch event and specific event date
        $event = Event::where('event_id', $request->event_id)->first();
        $eventDate = EventDate::where('event_date_id', $request->event_date_id)->first();

        if ($event->status == 'pending') {
            return response()->json(['message' => 'Event has not been approved']);
        }

        // Check against total tickets available for the specific event date
        if ($eventDate->total_ticket < $request->quantity) {
            return response()->json(['error' => 'Not enough tickets available'], 400);
        }

        $checkInCodes = [];

        for ($i = 0; $i < $request->quantity; $i++) {
            $code = Str::uuid();
            $checkInCodes[] = $code;

            Ticket::create([
                'event_id' => $event->event_id,
                'event_date_id' => $eventDate->event_date_id,
                'ticket_code' => $code,
                'total_price' => $eventDate->ticket_price,
                'status' => 'researved'
            ]);
        }

        // Update total_ticket for the specific event date
        $eventDate->decrement('total_ticket', $request->quantity);

        return response()->json([
            'message' => 'Ticket(s) reserved successfully',
            'checkin_codes' => $checkInCodes
        ]);
    }




    public function getAllEvent()
    {
        $organization = Auth::guard('organization-api')->user();

        if (!$organization) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        $events = Event::where('org_id', $organization->org_id)
            ->select('event_id as id', 'title as name')
            ->orderBy('title')
            ->get();

        return response()->json(['events' => $events]);
    }




    public function getAllBuyers(Request $request)
    {
        $organization = Auth::guard('organization-api')->user();

        if (!$organization) {
            return response()->json(['error' => 'Unauthorized: Organization not logged in.'], 401);
        }

        $organizationId = $organization->org_id;
        $eventId = $request->query('event_id');

        // Fetch payments with relationships
        $paymentsQuery = Payment::with(['user', 'event'])
            ->whereHas('event', function ($query) use ($organizationId) {
                $query->where('org_id', $organizationId);
            });

        if ($eventId) {
            $paymentsQuery->where('event_id', $eventId);
        }

        $payments = $paymentsQuery->get();

        // Group by user and event, then aggregate in PHP
        $buyerList = $payments->groupBy(function ($payment) {
            return $payment->user_id . '-' . $payment->event_id;
        })->map(function ($userPayments) {
            $firstPayment = $userPayments->first();

            return [
                'username' => $firstPayment->user->username,
                'user_id' => $firstPayment->user->user_id,
                'quantity' => $userPayments->sum('quantity'),
                'amount' => $userPayments->sum('amount'),
                'payment_date' => $userPayments->max('payment_date'),
                'title' => $firstPayment->event->title
            ];
        })->sortBy('username')->values();

        activity()
            ->causedBy($organization)
            ->log('Organization viewed buyer list');

        return response()->json([
            'buyers' => $buyerList
        ]);
    }




    public function transaction(Request $request)
    {
        $organization = Auth::guard('organization-api')->user();
        $organizationId = $organization->org_id;
        $selectedEventId = null;
        $selectedEventTitle = null;

        if ($request->has('event_id')) {
            $selectedEventId = $request->event_id;
            $eventCheck = Event::where('event_id', $selectedEventId)
                ->where('org_id', $organizationId)
                ->select('title')
                ->first();

            if (!$eventCheck) {
                return response()->json(['error' => 'Event not found or does not belong to your organization.'], 404);
            }
            $selectedEventTitle = $eventCheck->title;
        }

        $transactionQuery = Transaction::with(['user', 'event', 'payment'])
            ->whereHas('event', function ($query) use ($organizationId) {
                $query->where('org_id', $organizationId);
            });

        if ($selectedEventId) {
            $transactionQuery->where('event_id', $selectedEventId);
        }

        $transactions = $transactionQuery->orderByDesc('created_at')->get();

        $transactionList = $transactions->map(function ($transaction) {
            return [
                'date' => $transaction->created_at,
                'user' => $transaction->user->username,
                'event' => $transaction->event->title,
                'amount' => $transaction->payment->amount
            ];
        });

        $organizationEvents = Event::where('org_id', $organizationId)
            ->select('event_id', 'title')
            ->orderBy('title')
            ->get();

        activity()
            ->causedBy($organization)
            ->withProperties(['event_id_filter' => $selectedEventId])
            ->log('Organization viewed transactions');

        return response()->json([
            'transactions' => $transactionList,
            'target_event_id' => $selectedEventId,
            'target_event_title' => $selectedEventTitle,
            'organization_events' => $organizationEvents,
        ]);
    }




    public function checkIn(Request $request)
    {
        // Validate ticket_code exists in ticket table
        $request->validate([
            'ticket_code' => 'required|exists:ticket,ticket_code',
        ]);

        // Find the ticket
        $ticket = Ticket::where('ticket_code', $request->ticket_code)->first();

        if (!$ticket) {
            return response()->json(['message' => 'Invalid ticket code.'], 404);
        }

        // Get event date & time
        $eventDate = EventDate::where('event_date_id', $ticket->event_date_id)
            ->select('event_date', 'event_time')
            ->first();

        if (!$eventDate) {
            return response()->json(['message' => 'Event date not found.'], 404);
        }

        // Combine event date and time
        $eventDateTime = Carbon::parse($eventDate->event_date . ' ' . $eventDate->event_time);
        $now = Carbon::now();

        // Allow check-in only if event is today and event time has not passed
        if (!$eventDateTime->isToday() || $eventDateTime->lessThan($now)) {
            return response()->json([
                'message' => 'Check-in is not allowed. The event is not today or the time has passed.'
            ], 403);
        }

        // Check if already checked in
        $alreadyCheckedIn = CheckinLog::where('ticket_code', $ticket->ticket_code)->exists();

        if ($alreadyCheckedIn) {
            return response()->json(['message' => 'Ticket already checked in.'], 409);
        }

        // Insert check-in log
        CheckinLog::create([
            'ticket_id' => $ticket->ticket_id,
            'ticket_code' => $ticket->ticket_code,
            'user_id' => $ticket->user_id,
            'event_id' => $ticket->event_id,
            'checked_in_at' => now(),
        ]);

        return response()->json([
            'message' => 'Check-in successful.',
            'event_id' => $ticket->event_id,
            'user_id' => $ticket->user_id,
        ]);
    }




    public function profile()
    {
        // Get the logged in organization
        $organization = Auth::guard('organization-api')->user();

        // Get the logged in organization's info
        $organizationInfo = Organization::where('org_id', $organization->org_id)->first();

        // Count the number of events created by the organization
        $eventCount = Event::where('org_id', $organization->org_id)->count();

        if ($organizationInfo) {
            $organizationInfo->profile_image = $organizationInfo->profile_image
                ? asset('storage/' . $organizationInfo->profile_image)
                : asset('storage/Organization/default.png');
        }

        return response()->json([
            'organization_information' => $organizationInfo,
            'total_events_created' => $eventCount
        ]);
    }




    public function updateProfile(Request $request)
    {
        $user = Auth::guard('organization')->user();
        $orgId = $user->org_id;

        // Validate incoming data
        $validator = Validator::make($request->all(), [
            'org_name'       => 'required|string|max:255',
            'email'          => 'required|email|max:255',
            'contact_name'   => 'nullable|string|max:255',
            'contact_email'  => 'nullable|email|max:255',
            'contact_phone'  => 'nullable|string|max:20',
            'profile_image'  => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed.',
                'errors'  => $validator->errors()
            ], 422);
        }

        $org = Organization::where('org_id', $orgId)->first();

        if (!$org) {
            return response()->json(['message' => 'Organization not found'], 404);
        }

        // If image is uploaded, handle storing it
        $profileImagePath = $org->profile_image;
        if ($request->hasFile('profile_image')) {
            $file = $request->file('profile_image');
            $filename = time() . '_' . $file->getClientOriginalName();
            $path = $file->storeAs('Organization', $filename, 'public');
            $profileImagePath = 'Organization/' . $filename;
        }

        // Update organization
        $org->update([
            'org_name'      => $request->org_name,
            'email'         => $request->email,
            'contact_name'  => $request->contact_name,
            'contact_email' => $request->contact_email,
            'contact_phone' => $request->contact_phone,
            'profile_image' => $profileImagePath,
        ]);

        return response()->json([
            'message' => 'Profile updated successfully.',
            'organization_information' => $org->fresh()
        ]);
    }
}
