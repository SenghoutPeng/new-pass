<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('checkin_log', function (Blueprint $table) {

            $table->unsignedBigInteger('checkin_id')->primary();
            $table->unsignedBigInteger('ticket_id');
            $table->foreign('ticket_id')->references('ticket_id')->on('ticket');
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('user_id')->on('user');
            $table->unsignedBigInteger('event_id');
            $table->foreign('ticket_id')->references('event_id')->on('event');
            $table->string('ticket_code', 255);
            $table->timestamp('checked_in_at')->default('CURRENT_TIMESTAMP');
            $table->timestamp('created_at')->nullable()->default('NULL');
            $table->timestamp('updated_at')->nullable()->default('NULL');
        });
    }

    public function down()
    {
        Schema::dropIfExists('checkin_log');
    }
};
