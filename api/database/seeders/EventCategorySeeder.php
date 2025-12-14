<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\EventCategory;

class EventCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        EventCategory::create([
            'event_category_name' => 'Concerts'
        ]);

        EventCategory::create([
            'event_category_name' => 'Festivals'
        ]);

        EventCategory::create([
            'event_category_name' => 'Conferences'
        ]);

        EventCategory::create([
            'event_category_name' => 'Sports'
        ]);
    }
}
