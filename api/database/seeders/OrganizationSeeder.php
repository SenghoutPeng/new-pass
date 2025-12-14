<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Organization;

class OrganizationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Organization::create([
            'org_name' => 'Organization',
            'email' => 'events@organization.com',
            'password' => bcrypt('password'),
            'org_type' => 'For-Profit',
            'contact_name' => 'Organization',
            'contact_phone' => '092345678',
            'contact_email' => 'support@organization.com'
        ]);
    }
}
