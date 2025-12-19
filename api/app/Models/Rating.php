<?php

namespace App\Models;

use App\Models\User;
use App\Models\Event;
use Illuminate\Database\Eloquent\Model;
use App\Models\RatingCategory;

class Rating extends Model
{
    //
    protected $table = 'rating';
    protected $primaryKey = 'raing_id';
    protected $fillable = [
        'rating',
        'rating_category_id'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    public function event()
    {
        return $this->belongsTo(Event::class, 'event_id', 'event_id');
    }

    public function ratingCategory()
    {
        return $this->belongsTo(RatingCategory::class, 'rating_category_id', 'rating_category_id');
    }


}
