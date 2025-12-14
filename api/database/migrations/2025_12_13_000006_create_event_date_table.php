<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
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
    }

    public function down()
    {
        Schema::dropIfExists('event_date');
    }
};
