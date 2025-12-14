<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            UserSeeder::class,
            OrganizationSeeder::class,
            AdminSeeder::class,
            EventCategorySeeder::class,
            EventSeeder::class,
            EventDateSeeder::class,
            RatingCategorySeeder::class,
            PaymentSeeder::class,
            TicketSeeder::class,
            TransactionSeeder::class
        ]);
    }
}
