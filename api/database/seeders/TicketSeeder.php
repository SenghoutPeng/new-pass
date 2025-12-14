<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Ticket;

class TicketSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Ticket::create([
            'event_id' => 2,
            'payment_id' => 1,
            'user_id' => 1,
            'event_date_id' => 3,
            'ticket_code' => '02-01',
            'total_price' => 20.00,
            'status' => 'bought'
        ]);

        Ticket::create([
            'event_id' => 2,
            'payment_id' => 1,
            'user_id' => 1,
            'event_date_id' => 3,
            'ticket_code' => '02-02',
            'total_price' => 20.00,
            'status' => 'bought'
        ]);

        Ticket::create([
            'event_id' => 2,
            'payment_id' => 1,
            'user_id' => 1,
            'event_date_id' => 3,
            'ticket_code' => '02-03',
            'total_price' => 20.00,
            'status' => 'bought'
        ]);
    }
}
