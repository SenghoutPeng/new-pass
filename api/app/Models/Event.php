<?php

namespace App\Models;

use App\Models\Rating;
use App\Models\EventCategory;
use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $table = 'event';
    protected $primaryKey = 'event_id';
    protected $fillable = [
        'title',
        'description',
        'location',
        'event_category_id',
        'org_id',
        'banner',
        'admin_id'
    ];
}
