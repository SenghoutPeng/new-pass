<?php

namespace App\Models;

use App\Models\Admin;
use App\Models\Rating;
use App\Models\Ticket;
use App\Models\Payment;
use App\Models\EventDate;
use App\Models\CheckinLog;
use App\Models\Transaction;
use App\Models\Organization;
use App\Models\EventCategory;
use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $table = 'event';
    protected $primaryKey = 'event_id';
    protected $fillable = [
        'title', 'description', 'location',
        'event_category_id', 'proposed_date', 'org_id', 'banner', 'admin_id'
    ];

    public function organization()
    {
        return $this->belongsTo(Organization::class, 'org_id', 'org_id');
    }

    public function admin()
    {
        return $this->belongsTo(Admin::class, 'admin_id', 'admin_id');
    }

    public function eventCategory()
    {
        return $this->belongsTo(EventCategory::class, 'event_category_id', 'event_category_id');
    }

    public function eventDates()
    {
        return $this->hasMany(EventDate::class, 'event_id', 'event_id');
    }

    public function tickets()
    {
        return $this->hasMany(Ticket::class, 'event_id', 'event_id');
    }

    public function payments()
    {
        return $this->hasMany(Payment::class, 'event_id', 'event_id');
    }

    public function transactions()
    {
        return $this->hasMany(Transaction::class, 'event_id', 'event_id');
    }

    public function ratings()
    {
        return $this->hasMany(Rating::class, 'event_id', 'event_id');
    }

    public function checkinLogs()
    {
        return $this->hasMany(CheckinLog::class, 'event_id', 'event_id');
    }


}
