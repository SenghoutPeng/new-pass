<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use App\Models\Rating;
use App\Models\EventDate;
use App\Models\CheckinLog;
use Carbon\Carbon;

class RatingController extends Controller
{
    public function submitRating(Request $request)
    {
         $user = Auth::user();

         if (!$user) {
            return response()->json(['error' => 'Authentication required to submit a rating.'], 401);
         }

        $request->validate([
            'event_id' => 'required|exists:event,event_id',
            'rating' => 'required|array',
            'rating.*.category_id' => 'required|exists:rating_category,rating_category_id',
            'rating.*.value' => 'required|integer|min:1|max:5',
        ]);

        $checkRating = Rating::where('user_id', $user->user_id)
            ->where('event_id', $request->event_id)
            ->first();

        if ($checkRating) {
            return response()->json(['message' => 'You have already rated this event.'], 409);
        }

        $eventDate = EventDate::where('event_id', $request->event_id)
            ->max('event_date');

        $now = Carbon::today()->format('Y-m-d');

        if ($eventDate >= $now) {
            return response()->json([
                'error' => 'You can rate after the event end!'
            ], 403);
        }

        $alreadyCheckedIn = CheckinLog::where('user_id', $user->user_id)
            ->exists();

        if (!$alreadyCheckedIn) {
            return response()->json(['error' => 'You cannot rate as you did not attend the event!'], 409);
        }

        foreach ($request->rating as $ratingItem) {
            Rating::create([
                'user_id' => $user->user_id,
                'event_id' => $request->event_id,
                'rating_category_id' => $ratingItem['category_id'],
                'rating' => $ratingItem['value'],
            ]);
        }

        activity()
            ->causedBy(Auth::user())
            ->withProperties(['event_id' => $request->event_id])
            ->log('User submitted rating');

        return response()->json(['message' => 'Thank you for your feedback!'], 201);
    }




    public function feedback(Request $request)
    {
        $organization = auth('organization-api')->user();

        if (!$organization) {
            return response()->json(['error' => 'Unauthorized: Organization not logged in.'], 401);
        }

        $organizationId = $organization->org_id;
        $eventId = $request->query('event_id');

        // Fetch ratings with relationships
        $ratingsQuery = Rating::with(['ratingCategory', 'event', 'user'])
            ->whereHas('event', function ($query) use ($organizationId) {
                $query->where('org_id', $organizationId);
            });

        if ($eventId) {
            $ratingsQuery->where('event_id', $eventId);
        }

        $ratings = $ratingsQuery->get();

        // Group by category and calculate averages in PHP
        $categoryRatings = $ratings->groupBy('rating_category_id')->map(function ($categoryGroup) {
            $firstRating = $categoryGroup->first();
            return [
                'rating_category_name' => $firstRating->ratingCategory->rating_category_name,
                'average_rating' => round($categoryGroup->avg('rating'), 2),
                'total_ratings' => $categoryGroup->count()
            ];
        })->values();

        // Calculate overall average and total ratings
        $totalCategories = $categoryRatings->count();
        $totalRatings = 0;
        $averageSum = 0;

        foreach ($categoryRatings as $item) {
            $averageSum += floatval($item['average_rating']);
            $totalRatings += intval($item['total_ratings']);
        }

        $overallAverage = $totalCategories > 0 ? round($averageSum / $totalCategories, 2) : 0;

        // Format recent feedback
        $recentFeedback = $ratings->sortByDesc('created_at')->map(function ($rating) {
            return [
                'date' => $rating->created_at,
                'customer_id' => $rating->user->user_id,
                'username' => $rating->user->username,
                'event_id' => $rating->event->event_id,
                'event_name' => $rating->event->title,
                'rating_category_name' => $rating->ratingCategory->rating_category_name,
                'rating' => $rating->rating
            ];
        })->values();

        return response()->json([
            'average_rating' => $overallAverage,
            'total_ratings' => $totalRatings,
            'category_ratings' => $categoryRatings,
            'recent_feedback' => $recentFeedback
        ]);
    }
}
