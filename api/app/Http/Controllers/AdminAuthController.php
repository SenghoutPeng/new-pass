<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Admin;



class AdminAuthController extends Controller
{

    public function login(Request $request)
    {
        $validated = $request->validate([
            'email' => 'required|email|exists:admin',
            'password' => 'required|min:8'
        ]);

    $auth = Admin::where('email',$request->email)->first();
        if (!$auth || !Auth::guard('admin')->attempt($validated)) {
            return response()->json([
                'errors' => [
                    'credentials' => ['Invalid credentials']
                ]
            ], 401);
        }
        $admin = Auth::guard('admin')->user();

        $token = $auth->createToken('mytoken')->plainTextToken;

        activity()
        ->causedBy($admin)
        ->withProperties([
            'email' => $admin->email,
        ])
        ->log('Admin Logged in');

        return response()->json([
            'message' => 'Logged in successfully',
            'admin' => $admin,
            'token' => $token
        ], 200);
    }




    public function logout(Request $request)
    {

        $admin = $request->user();

        if (!$admin) {
            return response()->json(['message' => 'Not authenticated'], 401);
        }

        $token = $admin->currentAccessToken();

        if ($token) {
            $token->delete();

            activity()
            ->causedBy($admin)
            ->withProperties([
                'email' => $admin->email,
            ])
            ->log('Admin signed up');

            return response()->json(['message' => 'Logged out successfully']);
        }

        return response()->json(['message' => 'No active token found'], 400);
    }


}

