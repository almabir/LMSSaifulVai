<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class QuizQuestion extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'quiz_id',
        'title',
        'grade',
        'explanation',
        'type',
        'image', // <-- ADDED: This allows the image field to be saved
    ];

    /**
     * Get the answers for the quiz question.
     */
    public function answers(): HasMany
    {
        return $this->hasMany(QuizQuestionAnswer::class, 'question_id', 'id');
    }

    /**
     * Boot method to handle model events.
     */
    protected static function boot()
    {
        parent::boot();

        // Hook into the deleting event to delete related data
        static::deleting(function ($quizQuestion) {
            // Delete all related answers
            $quizQuestion->answers()->each(function ($answer) {
                $answer->delete();
            });
        });
    }
}
