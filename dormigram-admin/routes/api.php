<?php

use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Route;

Route::group(['prefix' => 'auth'], function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('register', [AuthController::class, 'register']);

    Route::group(['middleware' => 'auth:sanctum'], function () {
        Route::get('validate', [AuthController::class, 'validateToken']);
        Route::get('logout', [AuthController::class, 'logout']);
    });
});

Route::get('summary', [AuthController::class, 'summary'])->middleware('auth:sanctum');
