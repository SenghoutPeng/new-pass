<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('event', function (Blueprint $table) {

            $table->unsignedBigInteger('event_id')->primary();
            $table->unsignedBigInteger('org_id')->nullable()->default('NULL');
            $table->foreign('org_id')->references('org_id')->on('organization');
            $table->unsignedBigInteger('admin_id')->nullable()->default('NULL');
            $table->foreign('admin_id')->references('admin_id')->on('admin');
            $table->unsignedBigInteger('event_category_id');
            $table->foreign('event_category_id')->references('event_category_id')->on('event_category');
            $table->string('title', 255);
            $table->text('description');
            $table->string('banner', 255)->nullable()->default('banners/default.png');
            $table->string('location', 255);
            $table->string('status', 255)->default('PENDING');
            $table->string('reviewed_at')->nullable()->default('NULL');
            $table->timestamp('created_at')->default('CURRENT_TIMESTAMP');
            $table->timestamp('updated_at')->default('CURRENT_TIMESTAMP');
        });
    }

    public function down()
    {
        Schema::dropIfExists('event');
    }
};
