<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('admin', function (Blueprint $table) {

            $table->unsignedBigInteger('admin_id')->primary();
            $table->string('username', 50);
            $table->string('email', 100);
            $table->string('password', 255);
            $table->decimal('balance', 10, 2)->default('0.00');
            $table->timestamp('created_at')->default('CURRENT_TIMESTAMP');
            $table->timestamp('updated_at');
            $table->string('profile_image', 255)->nullable()->default('Admin/default.png');
        });
    }

    public function down()
    {
        Schema::dropIfExists('admin');
    }
};
