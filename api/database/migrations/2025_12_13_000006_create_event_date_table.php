<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('event_date', function (Blueprint $table) {

            $table->unsignedBigInteger('event_date_id')->primary();
            $table->foreignId('event_id')->constrained('event', 'event_id')->onDelete('cascade');
            $table->string('event_date');
            $table->string('event_time');
            $table->decimal('ticket_price', 10, 2);
            $table->timestamps();
            $table->integer('total_ticket');
        });
    }

    public function down()
    {
        Schema::dropIfExists('event_date');
    }
};
