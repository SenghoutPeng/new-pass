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
            $table->unsignedBigInteger('event_id');
            $table->foreign('event_id')->references('event_id')->on('event');
            $table->string('event_date');
            $table->string('event_time');
            $table->decimal('ticket_price', 10, 2);
            $table->timestamp('created_at')->nullable()->default('CURRENT_TIMESTAMP');
            $table->timestamp('updated_at')->nullable()->default('CURRENT_TIMESTAMP');
            $table->integer('total_ticket');
        });
    }

    public function down()
    {
        Schema::dropIfExists('event_date');
    }
};
