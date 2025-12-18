<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('event_category', function (Blueprint $table) {
            $table->id('event_category_id');
            $table->string('event_category_name');
        });

        Schema::create('event', function (Blueprint $table) {
            $table->id('event_id');
            $table->foreignId('org_id')->nullable()->constrained('organization', 'org_id');
            $table->foreignId('admin_id')->nullable()->constrained('admin', 'admin_id');
            $table->foreignId('event_category_id')->constrained('event_category', 'event_category_id');
            $table->string('title');
            $table->text('description');
            $table->string('banner')->nullable();
            $table->string('location');
            $table->string('status')->default('pending');
            $table->time('reviewed_at')->nullable();
            $table->timestamps();
        });

          Schema::create('rating_category', function (Blueprint $table) {
            $table->id('rating_category_id');
            $table->string('rating_category_name');
            $table->timestamps();
        });

        Schema::create('rating', function (Blueprint $table) {
            $table->id('rating_id'); // primary key
            $table->foreignId('user_id')->constrained('user', 'user_id')->onDelete('cascade');
            $table->foreignId('rating_category_id')->constrained('rating_category', 'rating_category_id');
            $table->foreignId('event_id')->constrained('event', 'event_id')->onDelete('cascade');
            $table->decimal('rating', 8, 2)->nullable();
            $table->timestamps();
        });
    }


    public function down(): void
    {
        Schema::dropIfExists('event');
        Schema::dropIfExists('event_category');
        Schema::dropIfExists('rating_category');
        Schema::dropIfExists('rating');
    }
};
