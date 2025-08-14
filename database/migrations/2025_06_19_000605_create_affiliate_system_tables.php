<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Add is_affiliate column to users table
        Schema::table('users', function (Blueprint $table) {
            $table->boolean('is_affiliate')->default(false)->after('role');
        });

        // Add commission percentage to courses table
        Schema::table('courses', function (Blueprint $table) {
            $table->decimal('affiliate_commission_percentage', 5, 2)->default(0.00)->after('price');
        });

        // Table for affiliate requests
        Schema::create('affiliate_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->text('reason')->nullable();
            $table->enum('status', ['pending', 'approved', 'rejected'])->default('pending');
            $table->timestamps();
        });

        // Table for unique affiliate links
        Schema::create('affiliate_links', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('course_id')->constrained()->onDelete('cascade');
            $table->string('referral_code')->unique();
            $table->timestamps();
        });

        // Table for commission logs
        Schema::create('affiliate_commissions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade'); // The affiliate who earned the commission
            $table->foreignId('order_id')->constrained()->onDelete('cascade');
            $table->foreignId('course_id')->constrained()->onDelete('cascade');
            $table->decimal('commission_amount', 10, 2);
            $table->enum('status', ['pending', 'paid', 'cancelled'])->default('pending');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('affiliate_commissions');
        Schema::dropIfExists('affiliate_links');
        Schema::dropIfExists('affiliate_requests');

        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('is_affiliate');
        });
        Schema::table('courses', function (Blueprint $table) {
            $table->dropColumn('affiliate_commission_percentage');
        });
    }
};
