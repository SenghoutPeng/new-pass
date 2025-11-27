<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

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

        $checkRating = DB::table('rating')
        ->where('user_id', $user->user_id)
        ->where('event_id', $request->event_id)
        ->first();

        if ($checkRating) {
        return response()->json(['message' => 'You have already rated this event.'], 409);
        }

        $eventDate = DB::table('event_date')
            ->where('event_id', $request->event_id)
            ->max('event_date');

        $now = date('Y-m-d');
        if($eventDate >= $now)
        {
            return response()->json([
                'error' => 'You can rate after the event end!'
            ], 403);
        }

        $alreadyCheckedIn = DB::table('checkin_log')
        ->where('user_id', $user->user_id)
        ->exists();

        if (!$alreadyCheckedIn) {
        return response()->json(['error' => 'You cannot rate as you did not attend the event!'], 409);
        }

        foreach ($request->rating as $ratingItem) {
            DB::table('rating')->insert([
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

        // Base query for category ratings with event/org join
        $categoryQuery = DB::table('rating')
            ->join('rating_category', 'rating_category.rating_category_id', '=', 'rating.rating_category_id')
            ->join('event', 'rating.event_id', '=', 'event.event_id')
            ->where('event.org_id', $organizationId);

        if ($eventId) {
            $categoryQuery->where('event.event_id', $eventId);
        }

        $categoryRatings = $categoryQuery
            ->select(
                'rating_category.rating_category_name',
                DB::raw('AVG(rating.rating) as average_rating'),
                DB::raw('COUNT(rating.rating_id) as total_ratings')
            )
            ->groupBy('rating_category.rating_category_name')
            ->get();

        // Calculate overall average and total ratings
        $totalCategories = count($categoryRatings);
        $totalRatings = 0;
        $averageSum = 0;

        foreach ($categoryRatings as $item) {
            $averageSum += floatval($item->average_rating);
            $totalRatings += intval($item->total_ratings);
        }

        $overallAverage = $totalCategories > 0 ? round($averageSum / $totalCategories, 2) : 0;

        // Query recent feedback with optional event filter
        $recentFeedbackQuery = DB::table('rating')
            ->join('user', 'user.user_id', '=', 'rating.user_id')
            ->join('event', 'event.event_id', '=', 'rating.event_id')
            ->join('rating_category', 'rating_category.rating_category_id', '=', 'rating.rating_category_id')
            ->where('event.org_id', $organizationId);

        if ($eventId) {
            $recentFeedbackQuery->where('event.event_id', $eventId);
        }

        $recentFeedback = $recentFeedbackQuery
            ->select(
                'rating.created_at as date',
                'user.user_id as customer_id',
                'user.username',
                'event.event_id',
                'event.title as event_name',
                'rating_category.rating_category_name',
                'rating.rating'
            )
            ->orderByDesc('rating.created_at')
            ->get();

        return response()->json([
            'average_rating' => $overallAverage,
            'total_ratings' => $totalRatings,
            'category_ratings' => $categoryRatings,
            'recent_feedback' => $recentFeedback
        ]);
    }
}
