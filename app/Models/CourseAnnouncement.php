<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CourseAnnouncement extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'course_id',
        'title',
        'description',
        'created_at',
        'updated_at',
    ];

    /**
     * Get the course that owns the announcement.
     */
    public function course()
    {
        return $this->belongsTo(Course::class);
    }
}