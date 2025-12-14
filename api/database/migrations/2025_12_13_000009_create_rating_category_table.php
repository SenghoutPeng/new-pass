<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('rating_category', function (Blueprint $table) {

            $table->unsignedBigInteger('rating_category_id')->primary();
            $table->string('rating_category_name', 255);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('rating_category');
    }
};
