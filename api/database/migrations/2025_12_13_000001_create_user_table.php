<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('user', function (Blueprint $table) {

            $table->unsignedBigInteger('user_id')->primary();
            $table->string('username', 255);
            $table->string('email', 255);
            $table->string('password', 255);
            $table->decimal('balance', 10, 2)->default('0.00');
            $table->string('profile_image', 255)->nullable()->default('User/default.png');
            $table->integer('status')->default('1');
            $table->timestamp('created_at')->nullable()->default('NULL');
            $table->timestamp('updated_at')->nullable()->default('NULL');
        });
    }

    public function down()
    {
        Schema::dropIfExists('user');
    }
};
