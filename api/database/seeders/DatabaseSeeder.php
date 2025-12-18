<?php

namespace Database\Seeders;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Admin
        DB::table('admin')->insert([
            'admin_id' => 1,
            'username' => 'Admin',
            'email' => 'admin@gmail.com',
            'password' => '$2y$12$8b1tEoFI0BAnTwjBdeaH/.uyjjVQv4nTFJD7EhGHswu0p.As2SIJy',
            'balance' => 30.00,
            'created_at' => '2025-07-13 16:22:40',
            'updated_at' => '2025-07-13 09:36:39',
        ]);

        // 2. Organization
        DB::table('organization')->insert([
            'org_id' => 1,
            'org_name' => 'Organization',
            'status' => 1,
            'email' => 'organization@gmail.com',
            'password' => '$2y$12$ue9TMzt8wo12o/0o0q.5Ieo1pVEgyddpiJHYcn.NuHysOw29LPIfK',
            'contact_name' => 'Organization',
            'contact_phone' => '092345678',
            'contact_email' => 'contact@gmail.com',
            'balance' => 570.00,
            'org_type' => 'Non-Profit',
            'created_at' => '2025-07-13 09:27:29',
            'updated_at' => '2025-07-13 09:27:29',
        ]);

        // 3. User
        DB::table('user')->insert([
            'user_id' => 1,
            'username' => 'User',
            'email' => 'user@gmail.com',
            'password' => '$2y$12$4WHdbuoTHJjwdHx8gDDxTu.Sgpw7FflAhQpTNirzr0apqf0CGc26u',
            'balance' => 999600.00,
            'status' => 1,
            'created_at' => '2025-07-13 09:21:33',
            'updated_at' => '2025-07-13 09:40:52',
        ]);

        // 4. Categories
        DB::table('event_category')->insert([
            ['event_category_id' => 1, 'event_category_name' => 'Concerts'],
            ['event_category_id' => 2, 'event_category_name' => 'Festivals'],
            ['event_category_id' => 3, 'event_category_name' => 'Conferences'],
            ['event_category_id' => 4, 'event_category_name' => 'Sports'],
        ]);

        // 5. Events
        DB::table('event')->insert([
            [
                'event_id' => 14,
                'org_id' => 1,
                'admin_id' => 1,
                'event_category_id' => 4,
                'title' => 'World Cup 2026',
                'description' => 'This is the world biggest football tournment',
                'banner' => 'banners/org_1_1752424312.jpg',
                'location' => 'Cambodia',
                'status' => 'approved',
                'reviewed_at' => '16:37:55',
                'created_at' => '2025-07-13 09:31:52',
            ],
            [
                'event_id' => 15,
                'org_id' => 1,
                'admin_id' => 1,
                'event_category_id' => 1,
                'title' => 'Vannda - Treyvisai 2025',
                'description' => 'This is the world biggest concert',
                'banner' => 'banners/org_1_1752425503.jpg',
                'location' => 'Cambodia',
                'status' => 'approved',
                'reviewed_at' => '16:51:53',
                'created_at' => '2025-07-13 09:51:43',
            ]
        ]);

        // 6. Event Dates
        DB::table('event_date')->insert([
            ['event_date_id' => 25, 'event_id' => 14, 'event_date' => '2026-06-18', 'event_time' => '14:00:00', 'ticket_price' => 200.00, 'total_ticket' => 9997, 'created_at' => now()],
            ['event_date_id' => 26, 'event_id' => 14, 'event_date' => '2026-07-11', 'event_time' => '14:00:00', 'ticket_price' => 400.00, 'total_ticket' => 10000, 'created_at' => now()],
            ['event_date_id' => 27, 'event_id' => 15, 'event_date' => '2025-08-18', 'event_time' => '14:00:00', 'ticket_price' => 20.00, 'total_ticket' => 10000, 'created_at' => now()],
            ['event_date_id' => 28, 'event_id' => 15, 'event_date' => '2026-08-12', 'event_time' => '14:00:00', 'ticket_price' => 40.00, 'total_ticket' => 10000, 'created_at' => now()],
        ]);

        // 7. Payment Records
        DB::table('payment')->insert([
            'payment_id' => 56,
            'user_id' => 1,
            'event_id' => 14,
            'amount' => 600.00,
            'quantity' => 3,
            'payment_status' => 'Completed',
            'payment_date' => '2025-07-13 09:41:25'
        ]);

        // 8. Tickets
        DB::table('ticket')->insert([
            ['ticket_id' => 90, 'event_id' => 14, 'purchase_date' => '2025-07-13 09:41:25', 'payment_id' => 56, 'ticket_code' => '56-01', 'total_price' => 200.00, 'user_id' => 1, 'event_date_id' => 25, 'status' => 'bought'],
            ['ticket_id' => 91, 'event_id' => 14, 'purchase_date' => '2025-07-13 09:41:25', 'payment_id' => 56, 'ticket_code' => '56-02', 'total_price' => 200.00, 'user_id' => 1, 'event_date_id' => 25, 'status' => 'bought'],
            ['ticket_id' => 92, 'event_id' => 14, 'purchase_date' => '2025-07-13 09:41:25', 'payment_id' => 56, 'ticket_code' => '56-03', 'total_price' => 200.00, 'user_id' => 1, 'event_date_id' => 25, 'status' => 'bought'],
        ]);

        // 9. Transactions
        DB::table('transaction')->insert([
            'transaction_id' => 27,
            'amount' => 600.00,
            'user_id' => 1,
            'org_id' => 1,
            'event_id' => 14,
            'payment_id' => 56,
            'transaction_date' => '2025-07-13 16:41:25',
            'commission_amount' => 30,
            'created_at' => '2025-07-13 09:41:25'
        ]);

        // 10. Rating Categories
        DB::table('rating_category')->insert([
            ['rating_category_id' => 1, 'rating_category_name' => 'Experience'],
            ['rating_category_id' => 2, 'rating_category_name' => 'Price'],
            ['rating_category_id' => 3, 'rating_category_name' => 'Quality'],
            ['rating_category_id' => 4, 'rating_category_name' => 'Service'],
        ]);
    }
}
