<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('rating', function (Blueprint $table) {

            $table->unsignedBigInteger('rating_id')->primary();
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('user_id')->on('user');
            $table->unsignedBigInteger('rating_category_id');
            $table->foreign('rating_category_id')->references('rating_catory_id')->on('rating_category');
            $table->unsignedBigInteger('event_id');
            $table->foreign('event_id')->references('event_id')->on('event_id');
            $table->timestamp('created_at')->default('CURRENT_TIMESTAMP');
            $table->decimal('rating', 8, 2)->nullable()->default('NULL');
            $table->timestamp('updated_at')->default('CURRENT_TIMESTAMP');
        });
    }

    public function down()
    {
        Schema::dropIfExists('rating');
    }
};
