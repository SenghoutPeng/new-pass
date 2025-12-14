<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('checkin_log', function (Blueprint $table) {
            $table->id('checkin_id');
            $table->foreignId('ticket_id')->constrained('ticket', 'ticket_id')->onDelete('cascade');
            $table->foreignId('user_id')->constrained('user', 'user_id')->onDelete('cascade');
            $table->foreignId('event_id')->constrained('event', 'event_id')->onDelete('cascade');
            $table->string('ticket_code');
            $table->timestamp('checked_in_at')->useCurrent();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('checkin_log');
    }
};
