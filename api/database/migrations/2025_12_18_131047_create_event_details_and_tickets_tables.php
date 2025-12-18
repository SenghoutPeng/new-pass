<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('event_date', function (Blueprint $table) {
            $table->id('event_date_id');
            $table->foreignId('event_id')->constrained('event', 'event_id')->onDelete('cascade');
            $table->date('event_date');
            $table->time('event_time');
            $table->decimal('ticket_price', 10, 2);
            $table->integer('total_ticket');
            $table->timestamps();
        });

        Schema::create('payment', function (Blueprint $table) {
            $table->id('payment_id');
            $table->foreignId('user_id')->constrained('user', 'user_id');
            $table->foreignId('event_id')->constrained('event', 'event_id');
            $table->decimal('amount', 8, 2);
            $table->integer('quantity');
            $table->enum('payment_status', ['Completed', 'Rejected']);
            $table->timestamp('payment_date');
        });

        Schema::create('ticket', function (Blueprint $table) {
            $table->id('ticket_id');
            $table->foreignId('event_id')->constrained('event', 'event_id');
            $table->foreignId('payment_id')->nullable()->constrained('payment', 'payment_id');
            $table->timestamp('purchase_date');
            $table->string('ticket_code')->unique();
            $table->decimal('total_price', 8, 2);
            $table->foreignId('user_id')->nullable()->constrained('user', 'user_id');
            $table->foreignId('event_date_id')->nullable()->constrained('event_date', 'event_date_id')->onDelete('cascade');
            $table->string('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ticket');
        Schema::dropIfExists('payment');
        Schema::dropIfExists('event_date');
    }
};
