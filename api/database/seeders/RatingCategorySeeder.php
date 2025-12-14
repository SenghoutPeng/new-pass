<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\RatingCategory;

class RatingCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        RatingCategory::create([
            'rating_category_name' => 'Experience'
        ]);

        RatingCategory::create([
            'rating_category_name' => 'Price'
        ]);

        RatingCategory::create([
            'rating_category_name' => 'Quality'
        ]);

        RatingCategory::create([
            'rating_category_name' => 'Service'
        ]);
    }
}
