<?php

namespace App\Models;

use App\Models\User;
use App\Models\Event;
use App\Models\Payment;
use App\Models\Organization;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    protected $table = 'transaction';
    protected $primaryKey = 'transaction_id';

    protected $fillable = [
        'amount',
        'user_id',
        'event_id',
        'org_id',
        'payment_id',
        'commission_amount',
    ];
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    public function organization()
    {
        return $this->belongsTo(Organization::class, 'org_id', 'org_id');
    }

    public function event()
    {
        return $this->belongsTo(Event::class, 'event_id', 'event_id');
    }

    public function payment()
    {
        return $this->belongsTo(Payment::class, 'payment_id', 'payment_id');
    }



}
