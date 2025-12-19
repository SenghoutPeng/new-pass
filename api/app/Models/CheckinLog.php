<?php

namespace App\Models;

use App\Models\User;
use App\Models\Event;
use App\Models\Ticket;
use Illuminate\Database\Eloquent\Model;

class CheckinLog extends Model
{
    protected $table = 'checkin_log';
    protected $primaryKey = 'checkin_id';

    protected $fillable = [
        'ticket_id',
        'user_id',
        'event_id',
        'ticket_code',
        'checked_in_at'
    ];

    protected $casts = [
        'checked_in_at' => 'datetime',
    ];

    public function ticket()
    {
        return $this->belongsTo(Ticket::class, 'ticket_id', 'ticket_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    public function event()
    {
        return $this->belongsTo(Event::class, 'event_id', 'event_id');
    }
}

