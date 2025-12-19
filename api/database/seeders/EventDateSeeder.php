<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\EventDate;

class EventDateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        EventDate::create([
            'event_time' => '14:00:00',
            'event_id' => 1,
            'event_date' => '2026-06-16',
            'ticket_price' => 200.00,
            'total_ticket' => 1000,
        ]);

        EventDate::create([
            'event_time' => '10:00:00',
            'event_id' => 1,
            'event_date' => '2026-06-17',
            'ticket_price' => 400.00,
            'total_ticket' => 1000,
        ]);

        EventDate::create([
            'event_time' => '18:00:00',
            'event_id' => 2,
            'event_date' => '2025-08-18',
            'ticket_price' => 20.00,
            'total_ticket' => 997,
        ]);

        EventDate::create([
            'event_time' => '20:00:00',
            'event_id' => 2,
            'event_date' => '2026-08-19',
            'ticket_price' => 40.00,
            'total_ticket' => 1000,
        ]);
    }
}
