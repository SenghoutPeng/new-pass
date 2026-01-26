<?php

namespace App\Models;

use App\Models\Event;
use App\Models\Transaction;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

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
            'profile_image',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];
    public function events()
    {
        return $this->hasMany(Event::class, 'org_id', 'org_id');
    }

    public function transactions()
    {
        return $this->hasMany(Transaction::class, 'org_id', 'org_id');
    }
}
