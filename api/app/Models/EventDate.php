<?php

namespace App\Models;

use App\Models\Event;
use App\Models\Ticket;
use Illuminate\Database\Eloquent\Model;

class EventDate extends Model
{
    protected $table = 'event_date';
    protected $primaryKey = 'event_date_id';
    protected $fillable = [
        'event_time', 'event_id', 'event_date',
        'ticket_price', 'total_ticket'
    ];
    public function event()
    {
        return $this->belongsTo(Event::class, 'event_id', 'event_id');
    }

    public function tickets()
    {
        return $this->hasMany(Ticket::class, 'event_date_id', 'event_date_id');
    }
}
