<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Laravel\Sanctum\TransientToken;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function signup(Request $request)
    {
       $validated = $request->validate([
            'username' => 'required|string|max:255',
            'email' => 'required|email|unique:user',
            'password' => 'required|min:8|confirmed',
        ]);

        $user = User::create($validated);
        $token = $user->createToken('user-signup-token')->plainTextToken;

        activity()
        ->causedBy($user)
        ->withProperties([
            'email' => $user->email,
        ])
        ->log('user signed up');

        return response()->json([
            'message' => 'Account created successfully',
            'token' => $token,
            'user' => $user,
        ], 201);

    }




    public function login(Request $request)
    {
        $validated = $request->validate([
            'email' => 'required|email|exists:user,email',
            'password' => 'required|min:8'
        ]);

        $user = User::where('email',$request->email)->first();
        if (!$user || !Auth::attempt($validated)) {
            return response()->json([
                'errors' => [
                    'credentials' => ['Invalid credentials']
                ]
            ], 401);
        }

        if(!$user->status)
        {
            return response()->json(['message' => 'Your account is disabled. Please contact support.'], 403);
        }

        $token = $user->createToken('user-login-token')->plainTextToken;

        activity()
        ->causedBy($user)
        ->withProperties([
            'email' => $user->email,
        ])
        ->log('user logged in');

        return response()->json([
            'message' => 'Logged in successfully',
            'user' => $user,
            'token' => $token
        ], 200);
    }




    public function logout(Request $request)
    {
        $user = $request->user();

        if (!$user) {
            return response()->json(['message' => 'Not authenticated'], 401);
        }

        // Get the current access token instance
        $token = $user->currentAccessToken();


        if ($token && !$token instanceof TransientToken) {

            $token->delete();
        }

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        activity()
            ->causedBy($user)
            ->withProperties([
                'email' => $user->email,
            ])
            ->log('user logged out');

        return response()->json(['message' => 'Logged out successfully']);
    }




    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required|current_password',
            'password' => 'required|min:8|confirmed',

        ]);

        $user = $request->user();

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'Incorrect current password'], 401);
        }

        if ($request->current_password === $request->password) {
            return response()->json(['message' => 'New password must be different'], 400);
        }

        $user->update([
            'password' => Hash::make($request->password),
        ]);

        activity()
        ->causedBy($user)
        ->withProperties([
            'email' => $user->email,
        ])
        ->log('user changed password');

        return response()->json(['message' => 'Password updated successfully'], 200);
    }
}

