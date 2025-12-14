<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{

    protected $table = 'payment';
    protected $primaryKey = 'payment_id';
    protected $fillable = [
        'user_id',
        'event_id',
        'amount',
        'quantity',
        'payment_status',
    ];
}
