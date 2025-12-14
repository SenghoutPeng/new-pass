<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Transaction;

class TransactionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Transaction::create([
            'amount' => 60.00,
            'user_id' => 1,
            'event_id' => 2,
            'org_id' => 1,
            'payment_id' => 1,
            'commission_amount' => 3
        ]);
    }
}
