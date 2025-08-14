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
        // Add image column to the quiz_questions table
        Schema::table('quiz_questions', function (Blueprint $table) {
            $table->string('image')->nullable()->after('title');
        });

        // Add negative marking columns to the quizzes table
        Schema::table('quizzes', function (Blueprint $table) {
            $table->boolean('negative_marking')->default(false)->after('total_mark');
            $table->decimal('negative_marks', 8, 2)->nullable()->after('negative_marking');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('quiz_questions', function (Blueprint $table) {
            $table->dropColumn('image');
        });

        Schema::table('quizzes', function (Blueprint $table) {
            $table->dropColumn('negative_marking');
            $table->dropColumn('negative_marks');
        });
    }
};
