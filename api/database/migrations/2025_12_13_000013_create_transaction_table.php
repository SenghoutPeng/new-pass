<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('transaction', function (Blueprint $table) {

            $table->unsignedBigInteger('transaction_id')->primary();
            $table->decimal('amount', 10, 2);
            $table->unsignedBigInteger('user_id')->nullable()->default('NULL');
            $table->foreign('user_id')->references('user_id')->on('user');
            $table->unsignedBigInteger('org_id')->nullable()->default('NULL');
            $table->foreign('org_id')->references('org_id')->on('organization');
            $table->integer('event_id');
            $table->integer('payment_id');
            $table->timestamp('transaction_date')->default('CURRENT_TIMESTAMP');
            $table->string('commission_amount');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('transaction');
    }
};
