<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'username' => "John Doe",
            'email' => "jdoe@example.com",
            'password' => bcrypt('password')
        ]);

        // Add fake balance
        User::where('user_id', 1)->update(['balance' => 420.69]);
    }
}
