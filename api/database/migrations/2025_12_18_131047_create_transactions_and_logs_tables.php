<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('transaction', function (Blueprint $table) {
            $table->id('transaction_id');
            $table->decimal('amount', 10, 2);
            $table->foreignId('user_id')->nullable()->constrained('user', 'user_id');
            $table->foreignId('org_id')->nullable()->constrained('organization', 'org_id');
            $table->integer('event_id');
            $table->integer('payment_id');
            $table->double('commission_amount');
            $table->timestamp('transaction_date')->useCurrent();
            $table->timestamps();
        });


        Schema::create('checkin_log', function (Blueprint $table) {
            $table->id('checkin_id');
            $table->foreignId('ticket_id')->unique()->constrained('ticket', 'ticket_id')->onDelete('cascade');
            $table->foreignId('user_id')->constrained('user', 'user_id')->onDelete('cascade');
            $table->foreignId('event_id')->constrained('event', 'event_id')->onDelete('cascade');
            $table->string('ticket_code')->unique();
            $table->timestamp('checked_in_at')->useCurrent();
            $table->timestamps();
        });

         Schema::create('activity_log', function (Blueprint $table) {
            $table->id();
            $table->string('log_name')->nullable();
            $table->text('description');
            $table->string('subject_type')->nullable();
            $table->string('event')->nullable();
            $table->unsignedBigInteger('subject_id')->nullable();
            $table->string('causer_type')->nullable();
            $table->unsignedBigInteger('causer_id')->nullable();
            $table->json('properties')->nullable();
            $table->char('batch_uuid', 36)->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('checkin_log');
        Schema::dropIfExists('transaction');
    }
};
