<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Payment;

class PaymentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Payment::create([
            'user_id' => 1,
            'event_id' => 2,
            'amount' => 60.00,
            'quantity' => 3,
            'payment_status' => 'Completed',
            'payment_date' => now(),
        ]);
    }
}
