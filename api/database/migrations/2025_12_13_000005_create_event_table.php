<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('event', function (Blueprint $table) {

            $table->id('event_id');
            $table->foreignId('org_id')->nullable()->constrained('organization', 'org_id');
            $table->foreignId('admin_id')->nullable()->constrained('admin', 'admin_id');
            $table->foreignId('event_category_id')->constrained('event_category', 'event_category_id');
            $table->string('title', 255);
            $table->text('description');
            $table->string('banner', 255)->default('storage/banners/default.png');
            $table->string('location', 255);
            $table->string('status', 255)->default('pending');
            $table->time('reviewed_at')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('event');
    }
};
