<?php

namespace App\Models;

use App\Models\User;
use App\Models\Event;
use App\Models\Payment;
use App\Models\EventDate;
use App\Models\CheckinLog;
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    //
    protected $table = 'ticket';
    protected $primaryKey = 'ticket_id';

    protected $fillable = [
    'user_id',
    'event_id',
    'event_date_id',
    'payment_id',
    'purchase_date',
    'ticket_code',
    'total_price',
    'status'
];
    public $timestamps = false;
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    public function event()
    {
        return $this->belongsTo(Event::class, 'event_id', 'event_id');
    }

    public function eventDate()
    {
        return $this->belongsTo(EventDate::class, 'event_date_id', 'event_date_id');
    }

    public function payment()
    {
        return $this->belongsTo(Payment::class, 'payment_id', 'payment_id');
    }

    public function checkinLog()
    {
        return $this->hasOne(CheckinLog::class, 'ticket_id', 'ticket_id');
    }
}
