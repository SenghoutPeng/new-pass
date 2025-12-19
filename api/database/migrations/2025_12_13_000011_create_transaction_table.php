<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('transaction', function (Blueprint $table) {

            $table->id('transaction_id');
            $table->decimal('amount', 10, 2);
            $table->foreignId('user_id')->nullable()->constrained('user', 'user_id');
            $table->foreignId('org_id')->nullable()->constrained('organization', 'org_id');
            $table->foreignId('event_id')->constrained('event', 'event_id');
            $table->foreignId('payment_id')->constrained('payment', 'payment_id');
            $table->timestamp('transaction_date')->useCurrent();
            $table->double('commission_amount');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('transaction');
    }
};
