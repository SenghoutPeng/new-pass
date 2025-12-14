<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    protected $table = 'ticket';
    protected $primaryKey = 'ticket_id';

    protected $fillable = [
        'event_id',
        'payment_id',
        'user_id',
        'event_date_id',
        'ticket_code',
        'total_price',
        'status'
    ];
}
