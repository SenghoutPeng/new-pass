<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Event;

class EventSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Event::create([
            'title' => "World Cup 2026",
            'description' => "The biggest football tournament ever",
            'location' => 'Cambodia',
            'event_category_id' => 4,
            'org_id' => 1,
            'banner' => 'banners/org_1_1.jpg',
            'admin_id' => 1
        ]);

        Event::create([
            'title' => "Vannda - Treyvisai 2025",
            'description' => "Vannda's grand concert!",
            'location' => 'Cambodia',
            'event_category_id' => 1,
            'org_id' => 1,
            'banner' => 'banners/org_1_2.jpg',
            'admin_id' => 1
        ]);

        // Set Status
        Event::where('title', "Vannda - Treyvisai 2025")->update(['status' => 'approved']);
    }
}
