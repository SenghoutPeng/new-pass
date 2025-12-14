<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Organization extends Authenticatable
{
    use HasApiTokens, HasFactory;
    protected $table = 'organization';
    protected $primaryKey = 'org_id';

    protected $fillable = [
        'org_name',
        'email' ,
        'password' ,
        'org_type',
        'contact_name',
        'contact_phone',
        'contact_email',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];
}
