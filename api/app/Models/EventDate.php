<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EventDate extends Model
{
    protected $table = 'event_date';
    protected $primaryKey = 'event_date_id';
    protected $fillable = [
        'event_time',
        'event_id',
        'event_date',
        'ticket_price',
        'total_ticket'
    ];
}
