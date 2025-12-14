<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('activity_log', function (Blueprint $table) {

            $table->unsignedBigInteger('id')->primary();
            $table->string('log_name', 255)->nullable()->default('NULL');
            $table->text('description');
            $table->string('subject_type', 255)->nullable()->default('NULL');
            $table->string('event', 255)->nullable()->default('NULL');
            $table->unsignedBigInteger('subject_id')->nullable()->default('NULL');
            $table->string('causer_type', 255)->nullable()->default('NULL');
            $table->unsignedBigInteger('causer_id')->nullable()->default('NULL');
            $table->string('properties')->nullable()->default('NULL');
            $table->string('batch_uuid')->nullable()->default('NULL');
            $table->timestamp('created_at')->nullable()->default('NULL');
            $table->timestamp('updated_at')->nullable()->default('NULL');
        });
    }

    public function down()
    {
        Schema::dropIfExists('activity_log');
    }
};
