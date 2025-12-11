<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\RatingController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\AdminAuthController;
use App\Http\Controllers\OrganizationController;
use App\Http\Controllers\OrganizationAuthController;



// User routes
Route::middleware('auth:sanctum')->get('/users', function (Request $request) {
    return $request->user();
});
Route::prefix('/')->group(function () {

    // Public actions
    Route::post('/signup', [AuthController::class, 'signup']);
    Route::post('/login', [AuthController::class, 'login']);
    Route::get('/events/{event_id}', [EventController::class, 'getOneEvent']);
    Route::get('/events', [EventController::class, 'getAllEvents']);
    Route::get('/on-going-events', [EventController::class, 'getAllOnGoingEvents']);
    Route::get('/popular-events', [EventController::class, 'getPopularEvents']);
    Route::middleware('auth:sanctum')->group(function () {
        // User actions
        Route::post('/buy-ticket', [UserController::class, 'buyTicket']);
        Route::post('/change-password', [AuthController::class, 'changePassword']);
        Route::post('/rating', [RatingController::class, 'submitRating']);
        Route::get('/get-tickets', [UserController::class, 'getUserTickets']);
        Route::get('/profile', [UserController::class, 'profile']);
        Route::post('/recharge', [UserController::class, 'recharge']);
        Route::post('/update', [UserController::class, 'updateInfo']);
        Route::post('/logout', [AuthController::class, 'logout']);
    });
});


// Organization routes
Route::prefix('organization')->group(function () {

    Route::post('/signup', [OrganizationAuthController::class, 'signup']);
    Route::post('/login', [OrganizationAuthController::class, 'login']);

    Route::middleware('auth:organization-api')->group(function () {
        // Organization actions
        Route::post('/check-in', [OrganizationController::class, 'checkIn']);
        Route::post('/event-request', [EventController::class, 'createEvent']);
        Route::post('/logout', [OrganizationAuthController::class, 'logout']);
        Route::post('/change-password', [OrganizationAuthController::class, 'changePassword']);
        Route::delete('/delete/event/{event_id}', [EventController::class, 'deleteEventRequest']);
        // Organization data retrival
        Route::get('/dashboard', [OrganizationController::class, 'getAllBuyers']);
        Route::get('/feedback', [RatingController::class, 'feedback']);
        Route::get('/profile', [OrganizationController::class, 'profile']);
        Route::get('/transaction', [OrganizationController::class, 'transaction']);
        Route::get('/events', [OrganizationController::class, 'getAllEvent']);
        Route::post('/update', [OrganizationController::class, 'updateProfile']);
    });
});

// Admin routes
Route::prefix('admin')->group(function () {

    Route::post('/signup', [AdminAuthController::class, 'signup']);
    Route::post('/login', [AdminAuthController::class, 'login']);
    Route::middleware('auth:admin-api')->group(function () {
        // Admin actions
        Route::post('/approve-event', [EventController::class, 'approveEventRequest']);
        Route::post('/logout', [AdminAuthController::class, 'logout']);
        Route::post('/change-password', [AdminAuthController::class, 'changePassword']);
        Route::post('/update/event', [AdminController::class, 'updateEvent']);
        Route::patch('/toggle/user/{user_id}', [AdminController::class, 'toggleUserStatus']);
        Route::patch('/toggle/organization/{org_id}', [AdminController::class, 'toggleOrganizationStatus']);
        Route::put('/update/user/{user_id}', [AdminController::class, 'updateUserInfo']);
        Route::put('/update/organization/{org_id}', [AdminController::class, 'updateOrganizationInfo']);

        // Admin data retrieval
        Route::get('/activity-log', [AdminController::class, 'activityLog']);
        Route::get('/dashboard', [AdminController::class, 'dashboard']);
        Route::get('/event-requests', [EventController::class, 'getAllEventRequests']);
        Route::get('/detail-event-request/{event_id}', [EventController::class, 'getOneEventRequest']);
        Route::get('/transaction', [AdminController::class, 'transaction']);
        Route::get('/events', [AdminController::class, 'getAllEvents']);
        Route::get('/profile', [AdminController::class, 'profile']);
        Route::get('/users', [AdminController::class, 'getAllUsers']);
        Route::get('/organizations', [AdminController::class, 'getAllOrganizations']);

     });
});


