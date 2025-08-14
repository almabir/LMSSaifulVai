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
        Schema::table('quiz_questions', function (Blueprint $table) {
            // Add the 'explanation' column after the 'title' column.
            // Using TEXT type is ideal for formatted text (HTML).
            $table->text('explanation')->nullable()->after('title');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('quiz_questions', function (Blueprint $table) {
            // This will remove the column if you need to rollback the migration.
            $table->dropColumn('explanation');
        });
    }
};