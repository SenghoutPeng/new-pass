<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Event;
use App\Models\EventDate;
use Carbon\Carbon;

class EventController extends Controller
{
    public function getAllEvents(Request $request)
    {
        $keyword = $request->keyword;
        $filter = $request->filter;

        // Start building the base query for events
        $eventQuery = Event::with('eventCategory')
            ->where('status', 'approved');

        // Apply keyword search if provided
        if (!empty($keyword)) {
            $eventQuery->where(function ($query) use ($keyword) {
                $query->where('title', 'like', '%' . $keyword . '%')
                    ->orWhere('description', 'like', '%' . $keyword . '%');
            });
        }

        // Apply category filter if provided
        if (!empty($filter)) {
            $eventQuery->whereHas('eventCategory', function ($query) use ($filter) {
                $query->where('event_category_name', 'like', $filter);
            });
        }

        // Execute the main event query
        $events = $eventQuery->orderBy('title')->get();

        // Get all event IDs from the retrieved events
        $eventIds = $events->pluck('event_id')->toArray();

        $eventDates = EventDate::whereIn('event_id', $eventIds)->get();

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
    $keyword = $request->keyword;
    $filter = $request->filter;

    // Query for events
    $eventQuery = Event::with('eventCategory', 'eventDates')
        ->where('status', 'approved');

    // Apply keyword search if provided
    if (!empty($keyword)) {
        $eventQuery->where(function($query) use ($keyword) {
            $query->where('title', 'like', '%' . $keyword . '%')
                  ->orWhere('description', 'like', '%' . $keyword . '%');
        });
    }

    // Apply category filter if provided
    if (!empty($filter)) {
        $eventQuery->whereHas('eventCategory', function($query) use ($filter) {
            $query->where('event_category_name', 'like', $filter);
        });
    }

    // Get all events and filter in PHP for future dates
    $events = $eventQuery->orderBy('title')->get()->filter(function($event) {
        // Check if event has at least one future date
        return $event->eventDates->some(function($date) {
            $eventDateTime = Carbon::parse($date->event_date . ' ' . $date->event_time);
            return $eventDateTime->isFuture();
        });
    });

    $formatted = [];

    foreach ($events as $event) {
        $eventFormattedDates = [];

        foreach ($event->eventDates as $date) {
            // Only include future dates
            $eventDateTime = Carbon::parse($date->event_date . ' ' . $date->event_time);
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

        // Only add if has future dates
        if (!empty($eventFormattedDates)) {
            $formatted[] = [
                'event_id' => $event->event_id,
                'title' => $event->title,
                'description' => $event->description,
                'location' => $event->location,
                'event_category_id' => $event->event_category_id,
                'event_category_name' =>$event->eventCategory->event_category_name,
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
    // Get all approved events with ticket counts
    $popularEvents = Event::withCount('tickets')
        ->where('status', 'approved')
        ->with('eventDates')
        ->orderByDesc('tickets_count')
        ->limit(5)
        ->get()
        ->filter(function($event) {
            // Filter events that have at least one future date
            return $event->eventDates->some(function($date) {
                $eventDateTime = Carbon::parse($date->event_date . ' ' . $date->event_time);
                return $eventDateTime->isFuture();
            });
        });

    $formatted = [];

    foreach ($popularEvents as $event) {
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

        $eventCheck = Event::where('event_id', $eventId)
            ->where('org_id', $organizationId)
            ->first();

        if (!$eventCheck) {
            return response()->json([
                'error' => 'The event does not exist or does not belong to your organization.'
            ], 404);
        }

        $event = Event::where('event_id', $eventId)
            ->where('org_id', $organizationId)
            ->where('status', 'pending')
            ->first();

        if (!$event) {
            return response()->json([
                'error' => 'The event you wanted to delete is already approved, it cannot be deleted'
            ], 403);
        }

        EventDate::where('event_id', $eventId)->delete();
        $event->delete();

        return response()->json([
            'message' => 'Event Request deleted successfully!'
        ], 200);
    }





    public function getOneEvent($eventId)
    {
        $eventDetail = Event::with('eventCategory')
            ->whereHas('organization', function ($query) {
                $query->where('status', true);
            })
            ->where('event_id', $eventId)
            ->first();

        if (!$eventDetail) {
            return response()->json(['message' => 'Event not found'], 404);
        }

        $eventDates = EventDate::where('event_id', $eventId)
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
            $firstDay = EventDate::where('event_id', $eventId)->min('event_date');
            $lastDay = EventDate::where('event_id', $eventId)->max('event_date');

            $eventDetail->first_event_day = $firstDay;
            $eventDetail->last_event_day = $lastDay;
        } else {
            $eventDetail->first_event_day = null;
            $eventDetail->last_event_day = null;
        }

        // Add event_category_name to response
        $eventDetail->event_category_name = $eventDetail->eventCategory->event_category_name;

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

        $event = Event::create([
            'org_id' => $organization->org_id,
            'title' => $validated['title'],
            'description' => $validated['description'],
            'location' => $validated['location'],
            'event_category_id' => $validated['event_category_id'],
            'banner' => $bannerPath,
            'status' => 'pending',
        ]);

        foreach ($validated['dates'] as $dateInfo) {
            EventDate::create([
                'event_id' => $event->event_id,
                'event_date' => $dateInfo['event_date'],
                'event_time' => $dateInfo['event_time'],
                'ticket_price' => $dateInfo['ticket_price'],
                'total_ticket' => $dateInfo['total_ticket'],
            ]);
        }

        return response()->json(['message' => 'Event Created Successfully'], 201);
    }




    public function getAllEventRequests()
    {
        $eventRequests = Event::with('organization')
            ->whereIn('status', ['pending', 'rejected'])
            ->whereHas('organization', function ($query) {
                $query->where('status', true);
            })
            ->select('event_id', 'org_id', 'title', 'created_at', 'status')
            ->get()
            ->map(function ($event) {
                return [
                    'event_id' => $event->event_id,
                    'org_name' => $event->organization->org_name,
                    'title' => $event->title,
                    'created_at' => $event->created_at,
                    'status' => $event->status,
                ];
            });

        activity()
            ->causedBy(Auth::guard('admin-api')->user())
            ->log('Admin viewed all event requests');

        return response()->json([
            'event_requests' => $eventRequests
        ], 200);
    }




   public function getOneEventRequest(Request $request)
    {
        $event_id = $request->event_id;

        $eventRequest = Event::where('event_id', $event_id)
            ->select('event_id', 'title', 'description', 'location', 'created_at', 'banner')
            ->first();

        if (!$eventRequest) {
            return response()->json(['message' => 'Event request not found'], 404);
        }

        // Add banner_url
        $eventRequest->banner_url = url('/') . '/storage/' . $eventRequest->banner;

        $eventDates = EventDate::where('event_id', $event_id)->get();

        // Use 'event_dates' instead of 'dates' to avoid conflict
        $eventRequest->event_dates = $eventDates->map(function($date) {
            return [
                'event_date' => $date->event_date,
                'event_time' => $date->event_time,
                'ticket_price' => $date->ticket_price,
                'total_ticket' => $date->total_ticket,
            ];
        });

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

        Event::where('event_id', $validated['id'])
            ->update([
                'admin_id' => $admin->admin_id,
                'status' => $validated['status'],
                'reviewed_at' => now()
            ]);

        return response()->json([
            'message' => 'Event ' . $validated['status']
        ]);
    }




    public function getOneEventViewAll(Request $request)
    {
        $event_id = $request->event_id;

        $eventRequest = Event::with('organization')
            ->where('event_id', $event_id)
            ->select('event_id', 'org_id', 'title', 'description', 'location', 'created_at', 'banner')
            ->first();

        if (!$eventRequest) {
            return response()->json(['message' => 'Event request not found'], 404);
        }

        // Add banner_url and org_name
        $eventRequest->banner_url = url('/') . '/storage/' . $eventRequest->banner;
        $eventRequest->org_name = $eventRequest->organization->org_name;

        $eventDates = EventDate::where('event_id', $event_id)->get();

        $eventRequest->dates = [];
        foreach ($eventDates as $date) {
            $eventRequest->dates[] = [
                'event_date' => $date->event_date,
                'event_time' => $date->event_time,
                'ticket_price' => $date->ticket_price,
                'total_ticket' => $date->total_ticket,
            ];
        }

        return response()->json([
            'event_request_detail' => $eventRequest
        ]);
    }
}
