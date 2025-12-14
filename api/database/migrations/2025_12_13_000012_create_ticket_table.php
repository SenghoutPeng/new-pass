<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('ticket', function (Blueprint $table) {

            $table->unsignedBigInteger('ticket_id')->primary();
            $table->unsignedBigInteger('event_id');
            $table->foreign('event_id')->references('event_id')->on('event');
            $table->timestamp('purchase_date')->default('CURRENT_TIMESTAMP');
            $table->integer('payment_id')->nullable()->default('NULL');
            $table->string('ticket_code', 255);
            $table->decimal('total_price', 8, 2);
            $table->unsignedBigInteger('user_id')->nullable()->default('NULL');
            $table->foreign('user_id')->references('user_id')->on('user');
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
