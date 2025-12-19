<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class EventController extends Controller
{
    public function getAllEvents(Request $request)
    {
        $keyword = '%' . $request->keyword . '%';
        $filter = $request->filter;

        // Start building the base query for events
        $eventQuery = DB::table('event')
            ->select('event.*', 'event_category.event_category_name')
            ->where('event.status', 'approved')
            ->join('event_category', 'event.event_category_id', '=', 'event_category.event_category_id');

        // Apply keyword search if provided
        if (!empty($keyword)) {
            $eventQuery->whereAny(['event.title', 'event.description'], 'like', $keyword);

        }

        // Apply category filter if provided
        if (!empty($filter)) {
            // Ensure the filter applies to the joined category name
            $eventQuery->where('event_category.event_category_name', 'like', $filter);
        }

        // Execute the main event query
        $events = $eventQuery->orderBy('event.title')->get();

        // Get all event IDs from the retrieved events
        $eventIds = $events->pluck('event_id')->toArray();

        $eventDates = DB::table('event_date')
            ->whereIn('event_id', $eventIds)
            ->get();

        // Group dates by event_id
        $datesGrouped = $eventDates->groupBy('event_id');

        $formatted = [];

        foreach ($events as $event) {
            $eventFormattedDates = [];

            foreach ($datesGrouped[$event->event_id] ?? [] as $date) {
                $eventFormattedDates[] = [
                    'event_date_id' => $date->event_date_id,
                    'event_date' => $date->event_date,
                    'event_time' => $date->event_time,
                    'ticket_price' => $date->ticket_price,
                    'total_ticket' => $date->total_ticket,
                ];
            }

            $formatted[] = [
                'event_id' => $event->event_id,
                'title' => $event->title,
                'description' => $event->description,
                'location' => $event->location,
                'event_category_id' => $event->event_category_id,
                'status' => $event->status,
                'banner' => $event->banner,
                'dates' => $eventFormattedDates,
            ];
        }

        return response()->json([
            'events' => $formatted
        ]);
    }



public function getAllOnGoingEvents(Request $request)
{
    $keyword = '%' . $request->keyword . '%';
    $filter = $request->filter;

    // Get the current date and time
    $now = now();

    // Query for events
    $eventQuery = DB::table('event')
        ->select('event.*', 'event_category.event_category_name')
        ->where('event.status', 'approved')
        ->join('event_category', 'event.event_category_id', '=', 'event_category.event_category_id')
        ->join('event_date', 'event.event_id', '=', 'event_date.event_id')
        ->where(function ($query) use ($now) {
            $query->where('event_date.event_date', '>', $now->toDateString())
                ->orWhere(function ($query) use ($now) {
                    $query->where('event_date.event_date', '=', $now->toDateString())
                        ->where('event_date.event_time', '>', $now->toTimeString());
                });
        })
        // Group by event to avoid duplicate events and ensure we get only one event per row
        ->groupBy('event.event_id', 'event.org_id', 'event.admin_id', 'event.event_category_id', 'event.title', 'event.description', 'event.banner', 'event.location', 'event.status', 'event.reviewed_at', 'event.created_at', 'event.updated_at', 'event_category.event_category_name');

    // Apply keyword search if provided
    if (!empty($request->keyword)) {
        $eventQuery->whereAny(['event.title', 'event.description'], 'like', $keyword);
    }

    // Apply category filter if provided
    if (!empty($filter)) {
        $eventQuery->where('event_category.event_category_name', 'like', $filter);
    }

    // Execute the main event query
    $events = $eventQuery->orderBy('event.title')->get();

    // Get all event IDs from the retrieved events
    $eventIds = $events->pluck('event_id')->toArray();

    // Fetch dates for all relevant events in a single query
    $eventDates = DB::table('event_date')
        ->whereIn('event_id', $eventIds)
        ->get();

    // Group dates by event_id for efficient lookup
    $datesGrouped = $eventDates->groupBy('event_id');

    $formatted = [];

    foreach ($events as $event) {
        $eventFormattedDates = [];

        foreach ($datesGrouped[$event->event_id] ?? [] as $date) {
            // Re-filter dates for the current event to only include future dates
            $eventDateTime = \Carbon\Carbon::parse($date->event_date . ' ' . $date->event_time);
            if ($eventDateTime->isFuture()) {
                $eventFormattedDates[] = [
                    'event_date_id' => $date->event_date_id,
                    'event_date' => $date->event_date,
                    'event_time' => $date->event_time,
                    'ticket_price' => $date->ticket_price,
                    'total_ticket' => $date->total_ticket,
                ];
            }
        }

        // Only add the event to the final result if it has at least one future date
        if (!empty($eventFormattedDates)) {
            $formatted[] = [
                'event_id' => $event->event_id,
                'title' => $event->title,
                'description' => $event->description,
                'location' => $event->location,
                'event_category_id' => $event->event_category_id,
                'status' => $event->status,
                'banner' => $event->banner,
                'dates' => $eventFormattedDates,
            ];
        }
    }

    return response()->json([
        'events' => $formatted
    ]);
}



    public function getPopularEvents()
    {
        // Use Carbon for easy date/time comparisons
        $now = now();
        $popularEvents = DB::table('event')
            ->join('ticket','event.event_id','=','ticket.event_id')
            ->where('event.status','approved')
            ->select('event.*', DB::raw('COUNT(ticket.ticket_id) as ticket_count'))
            ->join('event_date', 'event.event_id', '=', 'event_date.event_id')
            ->where(function ($query) use ($now) {
                $query->where('event_date.event_date', '>', $now->toDateString())
                    ->orWhere(function ($query) use ($now) {
                        $query->where('event_date.event_date', '=', $now->toDateString())
                            ->where('event_date.event_time', '>', $now->toTimeString());
                    });
            })
            ->groupBy('event.event_id', 'event.org_id', 'event.admin_id', 'event.event_category_id', 'event.title', 'event.description', 'event.banner', 'event.location', 'event.status', 'event.reviewed_at', 'event.created_at', 'event.updated_at')
            ->orderBy('ticket_count', 'desc')
            ->limit(5)
            ->get();



        $eventIds = $popularEvents->pluck('event_id')->toArray();

        $eventDates = DB::table('event_date')
            ->whereIn('event_id', $eventIds)
            ->get();

        // Group dates by event_id
        $datesGrouped = $eventDates->groupBy('event_id');

        $formatted = [];

        foreach ($popularEvents as $event) {
            $eventFormattedDates = [];

            foreach ($datesGrouped[$event->event_id] ?? [] as $date) {
                $eventFormattedDates[] = [
                    'event_date_id' => $date->event_date_id,
                    'event_date' => $date->event_date,
                    'event_time' => $date->event_time,
                    'ticket_price' => $date->ticket_price,
                    'total_ticket' => $date->total_ticket,
                ];
            }

            $formatted[] = [
                'event_id' => $event->event_id,
                'title' => $event->title,
                'description' => $event->description,
                'location' => $event->location,
                'event_category_id' => $event->event_category_id,
                'status' => $event->status,
                'banner' => $event->banner,
                'dates' => $eventFormattedDates,
            ];
        }

        return response()->json([
            'events' => $formatted
        ]);
    }




    public function deleteEventRequest($eventId)
    {
        $organization = Auth::guard('organization-api')->user();
        $organizationId = $organization->org_id;

        $eventCheck = DB::table('event')
            ->where('event_id', $eventId)
            ->where('org_id', $organizationId)
            ->first();

        if(!$eventCheck)
        {
            return response()->json([
                'error' => 'The event does not exist or does not belong to your organization.'
            ], 404);
        }

        $event = DB::table('event')
            ->where('event_id', $eventId)
            ->where('org_id', $organizationId)
            ->where('status', 'pending');
        $isApproved = $event->first();
        if(!$isApproved)
        {
            return response()->json([
                'error' => 'The event you wanted to delete is already approved, it cannot be deleted'
            ], 403);
        }
        DB::table('event_date')->where('event_id', $eventId)->delete();
        $event->delete();

        return response()->json([
            'message' => 'Event Request deleted successfully!'
        ], 200);
    }





    public function getOneEvent($eventId)
    {
        $eventDetail = DB::table('event')
            ->select('event.*', 'event_category.event_category_name')
            ->join('event_category', 'event.event_category_id', '=', 'event_category.event_category_id')
            ->join('organization', 'organization.org_id', '=', 'event.org_id')
            ->where('event.event_id', $eventId)
            ->where('organization.status', true)
            ->first();

        if (!$eventDetail) {
            return response()->json(['message' => 'Event not found'], 404);
        }


        $eventDates = DB::table('event_date')
        ->where('event_id', $eventId)
        ->whereDate('event_date', '>=', now()->toDateString())
        ->orderBy('event_date', 'asc')
        ->get();

        $allEventDates = [];
        foreach ($eventDates as $date) {
            $allEventDates[] = [
                'event_date_id' => $date->event_date_id,
                'event_date' => $date->event_date,
                'event_time' => $date->event_time,
                'ticket_price' => $date->ticket_price,
                'total_ticket' => $date->total_ticket,
            ];
        }
        $eventDetail->dates = $allEventDates;

        if (!empty($allEventDates)) {
            $firstDay = DB::table('event_date')
                        ->where('event_id', $eventId)
                        ->min('event_date');

            $lastDay = DB::table('event_date')
                        ->where('event_id', $eventId)
                        ->max('event_date');

            $eventDetail->first_event_day = $firstDay;
            $eventDetail->last_event_day = $lastDay;
        } else {
            $eventDetail->first_event_day = null;
            $eventDetail->last_event_day = null;
        }
        activity()
            ->causedBy(Auth::check() ? Auth::user() : null)
            ->withProperties(['event_id' => $eventId, 'event_title' => $eventDetail->title])
            ->log('User viewed single event');

        return response()->json([
            'event_detail' => $eventDetail
        ], 200);
    }




    public function createEvent(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255|unique:event,title',
            'description' => 'required|string',
            'location' => 'required|string|max:255',
            'event_category_id' => 'required|exists:event_category,event_category_id',
            'banner' => 'required|image|mimes:jpeg,png,jpg,gif,svg,webp,avif|max:2048',
            'dates' => 'required|array|min:1|max:3',
            'dates.*.event_date' => 'required|date|after:today',
            'dates.*.event_time' => 'required|date_format:H:i:s',
            'dates.*.ticket_price' => 'required|numeric|min:0',
            'dates.*.total_ticket' => 'required|integer|min:1'
        ]);

        $organization = Auth::guard('organization-api')->user();
        $banner = $request->file('banner');

        $orgId = $organization->org_id;

        $filename = 'org_' . $orgId . '_' . time() . '.' . $banner->getClientOriginalExtension();

        $bannerPath = $banner->storeAs('banners', $filename, 'public');



        $eventId = DB::table('event')->insertGetId([
            'org_id' => $organization->org_id,
            'admin_id' => 1,
            'title' => $validated['title'],
            'description' => $validated['description'],
            'location' => $validated['location'],
            'event_category_id' => $validated['event_category_id'],
            'banner' => $bannerPath,
            'status' => 'pending',
            'created_at' => now(),
            'updated_at' => now()
        ], 'event_id');

        foreach ($validated['dates'] as $dateInfo) {
            DB::table('event_date')->insert([
                'event_id' => $eventId,
                'event_date' => $dateInfo['event_date'],
                'event_time' => $dateInfo['event_time'],
                'ticket_price' => $dateInfo['ticket_price'],
                'total_ticket' => $dateInfo['total_ticket'],
                'created_at' => now(),
                'updated_at' => now()
            ]);
        }

        return response()->json(['message' => 'Event Created Successfully'], 201);
    }




    public function getAllEventRequests()
    {
        $eventRequests = DB::table('event')
            ->join('organization', 'organization.org_id', '=', 'event.org_id')
            ->whereIn('event.status', ['pending','rejected'])
            ->where('organization.status', true)
            ->select('organization.org_name', 'event.title', 'event.created_at', 'event.status', 'event.event_id')

            ->get();
        activity()
            ->causedBy(Auth::guard('admin-api')->user()) // Assuming admin
            ->log('Admin viewed all event requests');
        return response()->json([
            'event_requests' => $eventRequests
        ], 200);
    }




    public function getOneEventRequest(Request $request)
    {
        $event_id = $request->event_id;

        $eventRequest = DB::table('event')
            ->where('event_id', $event_id)
            ->select('event_id','title', 'description', 'location','created_at', DB::raw("CONCAT('" . url('/') . "/storage/', event.banner) as banner_url"))
            ->first();

        if (!$eventRequest) {
            return response()->json(['message' => 'Event request not found'], 404);
        }

        $eventDates = DB::table('event_date')->where('event_id', $event_id)->get();

        $eventRequest->dates = [];
        foreach ($eventDates as $date) {
            $eventRequest->dates[] = [
                'event_date' => $date->event_date,
                'event_time' => $date->event_time,
                'ticket_price' =>  $date->ticket_price,
                'total_ticket' => $date->total_ticket,
            ];
        }

        return response()->json([
            'event_request_detail' => $eventRequest
        ]);
    }




    public function getOneEventViewAll(Request $request)
    {
        $event_id = $request->event_id;

        $eventRequest = DB::table('event')
            ->join('organization', 'event.org_id', '=', 'organization.org_id')  // join organization table
            ->where('event.event_id', $event_id)
            ->select(
                'event.event_id',
                'event.title',
                'event.description',
                'event.location',
                'event.created_at',  // submission date
                'organization.org_name', // organizer name
                DB::raw("CONCAT('" . url('/') . "/storage/', event.banner) as banner_url")
            )
            ->first();

        if (!$eventRequest) {
            return response()->json(['message' => 'Event request not found'], 404);
        }

        $eventDates = DB::table('event_date')->where('event_id', $event_id)->get();

        $eventRequest->dates = [];
        foreach ($eventDates as $date) {
            $eventRequest->dates[] = [
                'event_date' => $date->event_date,
                'event_time' => $date->event_time,
                'ticket_price' =>  $date->ticket_price,
                'total_ticket' => $date->total_ticket,
            ];
        }

        return response()->json([
            'event_request_detail' => $eventRequest
        ]);
    }




    public function approveEventRequest(Request $request)
    {
        $validated = $request->validate([
            'status' => 'required|in:approved,rejected',
            'id' => 'required|exists:event,event_id'
        ]);
        $admin = Auth::guard('admin-api')->user();
        $update = DB::table('event')
            ->where('event_id', $validated['id'])
            ->update([
                'admin_id' => $admin->admin_id,
                'status' => $validated['status'],
                'reviewed_at' => now()
            ]);

        return response()->json([
            'message' => 'Event ' . $validated['status']
        ]);
    }

}
