<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('index');
});

Route::get('/organization', function () {
    return view('organization.index');
});

Route::get('/admin', function () {
    return view('admin.index');
});


