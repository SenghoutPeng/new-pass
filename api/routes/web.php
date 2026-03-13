<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return ['Laravel' => app()->version(), 'Server' => request()->server('SERVER_ADDR')];
});
