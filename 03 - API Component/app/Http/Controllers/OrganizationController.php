<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

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
        $event = DB::table('event')->where('event_id', $request->event_id)->first();
        $eventDate = DB::table('event_date')->where('event_date_id', $request->event_date_id)->first();

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

            DB::table('ticket')->insert([
                'event_id' => $event->event_id,
                'event_date_id' => $eventDate->event_date_id,
                'ticket_code' => $code,
                'total_price' => $eventDate->ticket_price,
                'status' => 'researved'
            ]);
        }

           // Update total_ticket for the specific event date, not the event itself
           DB::table('event_date')->where('event_date_id', $eventDate->event_date_id)->update([
            'total_ticket' => $eventDate->total_ticket - $request->quantity
        ]);
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

        $events = DB::table('event')
            ->where('org_id', $organization->org_id)
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

        $query = DB::table('payment')
            ->join('user', 'payment.user_id', '=', 'user.user_id')
            ->join('event', 'payment.event_id', '=', 'event.event_id')
            ->where('event.org_id', $organizationId);

        if ($eventId) {
            $query->where('event.event_id', $eventId);
        }

        $buyerList = $query
            ->select(
                'user.username',
                'user.user_id',
                DB::raw('SUM(payment.quantity) as quantity'),
                DB::raw('SUM(payment.amount) as amount'),
                DB::raw('MAX(payment.payment_date) as payment_date'),
                'event.title'
            )
            ->groupBy('user.user_id', 'user.username', 'event.title')
            ->orderBy('user.username')
            ->get();

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


        if($request->has('event_id'))
        {
            $selectedEventId = $request->event_id;
            $eventCheck = DB::table('event')
                ->where('event_id', $selectedEventId)
                ->where('org_id', $organizationId)
                ->select('title')
                ->first();
            if (!$eventCheck) {
                return response()->json(['error' => 'Event not found or does not belong to your organization.'], 404);
            }
            $selectedEventTitle = $eventCheck->title;
        }
        $transactionQuery = DB::table('transaction')
        ->join('user', 'user.user_id', '=', 'transaction.user_id')
        ->join('event', 'event.event_id', '=', 'transaction.event_id')
        ->join('payment', 'payment.payment_id', '=', 'transaction.payment_id')
        ->where('event.org_id', $organizationId)
        ->select(
            'transaction.created_at as date',
            'user.username as user',
            'event.title as event',
            'payment.amount'
        );
        if ($selectedEventId) {
            $transactionQuery->where('transaction.event_id', $selectedEventId);
        }

        $transactionList = $transactionQuery->orderByDesc('transaction.created_at')->get();

        $organizationEvents = DB::table('event')
            ->where('org_id', $organizationId)
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
        $ticket = DB::table('ticket')
            ->where('ticket_code', $request->ticket_code)
            ->first();

        if (!$ticket) {
            return response()->json(['message' => 'Invalid ticket code.'], 404);
        }

        // Get event date & time
        $eventDate = DB::table('event_date')
            ->where('event_date_id', $ticket->event_date_id)
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
        $alreadyCheckedIn = DB::table('checkin_log')
            ->where('ticket_code', $ticket->ticket_code)
            ->exists();

        if ($alreadyCheckedIn) {
            return response()->json(['message' => 'Ticket already checked in.'], 409);
        }

        // Insert check-in log
        DB::table('checkin_log')->insert([
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
        // Get the logged in organization's id
        $organizationId = $organization->org_id;
        // Get the logged in organization's info
        $organizationInfo = DB::table('organization')->where('org_id',$organizationId)->first();
        // Count the number of events created by the organization
        $eventCount = DB::table('event')->where('org_id', $organizationId)->count();

    if ($organizationInfo) {
        $organizationInfo->profile_image = $organizationInfo->profile_image
            ? asset('storage/' . $organizationInfo->profile_image)
            : asset('storage/Organization/default.png');
    }

        // Return a proper JSON response (as key-value)
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

        $org = DB::table('organization')->where('org_id', $orgId)->first();

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
        DB::table('organization')->where('org_id', $orgId)->update([
            'org_name'      => $request->org_name,
            'email'         => $request->email,
            'contact_name'  => $request->contact_name,
            'contact_email' => $request->contact_email,
            'contact_phone' => $request->contact_phone,
            'profile_image' => $profileImagePath,
            'updated_at'    => now(),
        ]);

        return response()->json([
            'message' => 'Profile updated successfully.',
            'organization_information' => DB::table('organization')->where('org_id', $orgId)->first()
        ]);
    }
}
