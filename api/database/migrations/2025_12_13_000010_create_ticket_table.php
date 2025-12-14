<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('ticket', function (Blueprint $table) {

            $table->id('ticket_id');
            $table->foreignId('event_id')->constrained('event', 'event_id');
            $table->timestamp('purchase_date')->useCurrent();
            $table->foreignId('payment_id')->constrained('payment', 'payment_id');
            $table->string('ticket_code', 255);
            $table->decimal('total_price', 8, 2);
            $table->foreignId('user_id')->constrained('user', 'user_id');
            $table->foreignId('event_date_id')->constrained('event_date', 'event_date_id')->onDelete('cascade');
            $table->string('status', 255);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('ticket');
    }
};
