<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only('email', 'password');

        if (!Auth::attempt($credentials)) {
            return response()->json([
                'message' => 'Unauthorized'
            ], 401);
        }

        $user = $request->user();
        $tokenResult = $user->createToken('token');
        $token = $tokenResult->plainTextToken;

        return response()->json($token);
    }

    public function register(Request $request)
    {
        $request->validate([
            'last' => 'required|string',
            'first' => 'required|string',
            'patronymic' => 'nullable|string',
            'email' => 'required|string|unique:users',
            'password' => 'required|string',
            'c_password' => 'required|same:password'
        ]);

        $user = new User([
            // 'last_name'  => $request->last,
            // 'first_name' => $request->first,
            // 'patronymic' => $request->patronymic,
            'name' => $request->last . ' ' . $request->first . ' ' . $request->patronymic,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);

        if ($user->save()) {
            $tokenResult = $user->createToken('token');
            $token = $tokenResult->plainTextToken;

            return response()->json($token);
        }

        return response()->json(['error' => 'Provide proper details'], 401);
    }

    public function validateToken(Request $request)
    {
        return response()->json($request->user() !== null);
    }
}
