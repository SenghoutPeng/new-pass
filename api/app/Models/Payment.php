<?php

namespace App\Models;

use App\Models\User;
use App\Models\Event;
use App\Models\Ticket;
use App\Models\Transaction;
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
        'payment_date'
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

    public function tickets()
    {
        return $this->hasMany(Ticket::class, 'payment_id', 'payment_id');
    }

    public function transaction()
    {
        return $this->hasOne(Transaction::class, 'payment_id', 'payment_id');
    }
}
