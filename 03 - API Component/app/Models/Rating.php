<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Rating extends Model
{
    //
    protected $table = 'rating';
    protected $primaryKey = 'raing_id';
    protected $fillable = [
        'rating',
        'rating_category_id'
    ];


}
