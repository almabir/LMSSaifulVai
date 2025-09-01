<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use App\Models\Course;
use App\Models\CourseProgress;
use App\Models\CourseChapter;
use App\Models\CourseChapterItem;
use App\Models\CourseChapterLesson;
use App\Models\Quiz;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Collection;

class LearningController extends Controller
{
    /**
     * Display the learning page for a course.
     *
     * @param string $slug
     * @return \Illuminate\View\View|\Illuminate\Http\RedirectResponse
     */
    public function index(string $slug)
    {
        // Ensure user is authenticated and verified
        if (!Auth::check() || !Auth::user()->email_verified_at) {
            Log::warning("Unauthorized access attempt: UserID=" . (Auth::check() ? Auth::id() : 'Guest') . ", Slug={$slug}");
            return redirect()->route('login')->with([
                'alert-type' => 'error',
                'message' => __('Please log in and verify your email'),
            ]);
        }

        // Fetch the course with related data
        $course = Course::active()
            ->with([
                'chapters',
                'chapters.chapterItems',
                'chapters.chapterItems.lesson',
                'chapters.chapterItems.quiz',
            ])
            ->withTrashed()
            ->where('slug', $slug)
            ->first();

        // Check if course exists
        if (!$course) {
            Log::error("Course not found for slug: {$slug}");
            return redirect()->route('student.dashboard')->with([
                'alert-type' => 'error',
                'message' => __('Course not found'),
            ]);
        }

        // Log course details for debugging
        Log::info("Course accessed: ID={$course->id}, Slug={$slug}, Title={$course->title}, UserID=" . Auth::id());

        // Check if user is enrolled
        $isEnrolled = DB::table('enrollments')
            ->where('user_id', Auth::id())
            ->where('course_id', $course->id)
            ->exists();
        if (!$isEnrolled) {
            Log::warning("User not enrolled: UserID=" . Auth::id() . ", CourseID={$course->id}");
            return redirect()->route('courses')->with([
                'alert-type' => 'error',
                'message' => __('You are not enrolled in this course'),
            ]);
        }

        // Check if chapters exist
        if (!$course->chapters->count()) {
            Log::warning("No chapters found for CourseID={$course->id}");
            return redirect()->route('student.dashboard')->with([
                'alert-type' => 'error',
                'message' => __('No chapters available for this course'),
            ]);
        }

        // Store course details in session
        Session::put('course_slug', $course->slug);
        Session::put('course_title', $course->title);

        // Fetch current progress
        $currentProgress = CourseProgress::where('user_id', Auth::id())
            ->where('course_id', $course->id)
            ->where('is_completed', 0)
            ->orderBy('id', 'desc')
            ->first();
Log::info($currentProgress);
        // If no progress, create one for the first lesson
        if (!$currentProgress) {
            $firstChapter = $course->chapters->first();
            $firstItem = $firstChapter->chapterItems()->first();
            if ($firstItem && ($firstItem->lesson || $firstItem->quiz)) {
                $lessonId = $firstItem->type == 'quiz' ? $firstItem->quiz_id : $firstItem->lesson_id;
                $chapterId = $firstChapter->id;
                CourseProgress::create([
                    'user_id' => Auth::id(),
                    'course_id' => $course->id,
                    'chapter_id' => $chapterId,
                    'lesson_id' => $lessonId,
                    'type' => $firstItem->type,
                    'is_completed' => 0,
                ]);
                Log::info("Created progress for UserID=" . Auth::id() . ", CourseID={$course->id}, ChapterID={$chapterId}, LessonID={$lessonId}, Type={$firstItem->type}");
                $currentProgress = CourseProgress::where('user_id', Auth::id())
                    ->where('course_id', $course->id)
                    ->where('is_completed', 0)
                    ->orderBy('id', 'desc')
                    ->first();
            } else {
                Log::warning("No valid chapter items found for ChapterID={$firstChapter->id}, CourseID={$course->id}");
            }
        }

        // Fetch announcements if model exists
        $announcements = new Collection();
        if (class_exists(\App\Models\CourseAnnouncement::class)) {
            $announcements = \App\Models\CourseAnnouncement::where('course_id', $course->id)
                ->orderBy('id', 'desc')
                ->get();
        } else {
            Log::warning("CourseAnnouncement model not found for CourseID={$course->id}");
        }

        // Calculate progress
        $courseLectureCompletedByUser = CourseProgress::where('user_id', Auth::id())
            ->where('course_id', $course->id)
            ->where('is_completed', 1)
            ->count();
Log::info($courseLectureCompletedByUser);
        $courseLectureCount = CourseChapterItem::whereIn('chapter_id', $course->chapters->pluck('id'))
            ->whereIn('type', ['lesson', 'live', 'document'])
            ->count();

        $courseCompletedPercent = $courseLectureCount ? ($courseLectureCompletedByUser / $courseLectureCount) * 100 : 0;
Log::info($courseCompletedPercent);
        $alreadyWatchedLectures = CourseProgress::where('user_id', Auth::id())
            ->where('course_id', $course->id)
            ->where('is_completed', 1)
            ->whereIn('type', ['lesson', 'live', 'document'])
            ->pluck('lesson_id')
            ->toArray();
Log::info($alreadyWatchedLectures);
        $alreadyCompletedQuiz = CourseProgress::where('user_id', Auth::id())
            ->where('course_id', $course->id)
            ->where('is_completed', 1)
            ->where('type', 'quiz')
            ->pluck('lesson_id')
            ->toArray();
Log::info($alreadyCompletedQuiz);
        return view('frontend.pages.learning-player.index', compact(
            'course',
            'currentProgress',
            'announcements',
            'courseCompletedPercent',
            'courseLectureCount',
            'courseLectureCompletedByUser',
            'alreadyWatchedLectures',
            'alreadyCompletedQuiz'
        ));
    }

    /**
     * Get file information for a lesson or quiz.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getFileInfo(Request $request)
    {
        $request->validate([
            'lessonId' => 'required',
            'chapterId' => 'required',
            'courseId' => 'required',
            'type' => 'required|in:lesson,live,document,quiz',
        ]);

        $course = Course::find($request->courseId);
        if (!$course) {
            Log::error("Course not found: CourseID={$request->courseId}");
            return response()->json(['status' => 'error', 'message' => __('Course not found')]);
        }

        $chapter = CourseChapter::find($request->chapterId);
        if (!$chapter) {
            Log::error("Chapter not found: ChapterID={$request->chapterId}, CourseID={$request->courseId}");
            return response()->json(['status' => 'error', 'message' => __('Chapter not found')]);
        }

        $chapterItem = CourseChapterItem::where('chapter_id', $request->chapterId)
            ->where('type', $request->type)
            ->where(function ($query) use ($request) {
                $query->where('lesson_id', $request->lessonId)
                      ->orWhere('quiz_id', $request->lessonId);
            })
            ->first();

        if (!$chapterItem) {
            Log::error("Chapter item not found: ChapterID={$request->chapterId}, Type={$request->type}, LessonID={$request->lessonId}, CourseID={$request->courseId}");
            return response()->json(['status' => 'error', 'message' => __('Item not found')]);
        }

        $file_info = new \stdClass();
        $file_info->id = $request->lessonId;
        $file_info->type = $request->type;
        $file_info->course = $course;

        if ($request->type == 'quiz') {
            $quiz = Quiz::find($request->lessonId);
            if (!$quiz) {
                Log::error("Quiz not found: QuizID={$request->lessonId}, CourseID={$request->courseId}");
                return response()->json(['status' => 'error', 'message' => __('Quiz not found')]);
            }
            $file_info->title = $quiz->title;
            $file_info->description = $quiz->description ?? '';
        } else {
            $lesson = CourseChapterLesson::find($request->lessonId);
            if (!$lesson) {
                Log::error("Lesson not found: LessonID={$request->lessonId}, CourseID={$request->courseId}");
                return response()->json(['status' => 'error', 'message' => __('Lesson not found')]);
            }
            $file_info->title = $lesson->title;
            $file_info->file_type = $lesson->file_type;
            $file_info->file_path = $lesson->file_path;
            $file_info->storage = $lesson->storage;
            $file_info->description = $lesson->description ?? '';
            if ($request->type == 'live') {
                $file_info->live = (object) [
                    'type' => $lesson->live_type,
                    'join_url' => $lesson->join_url,
                    'start_time' => $lesson->start_time,
                    'end_time' => $lesson->end_time,
                ];
                $file_info->is_live_now = $this->getLiveStatus($lesson);
            }
            if ($request->type == 'document' && $lesson->file_type != 'txt') {
                $file_info->view = view('frontend.pages.learning-player.document', compact('lesson'))->render();
            }
        }

        return response()->json(['status' => 'success', 'file_info' => $file_info]);
    }

    /**
     * Mark a lesson or quiz as complete.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function makeLessonComplete(Request $request)
    {
        $request->validate([
            'lessonId' => 'required',
            'status' => 'required|in:0,1',
            'type' => 'required|in:lesson,live,document,quiz',
            'courseId' => 'required|exists:courses,id',
        ]);

        $progress = CourseProgress::where('user_id', Auth::id())
            ->where('course_id', $request->courseId)
            ->where('lesson_id', $request->lessonId)
            ->where('type', $request->type)
            ->first();

        if ($progress) {
            $progress->update(['is_completed' => $request->status]);
        } else {
            $progress = CourseProgress::create([
                'user_id' => Auth::id(),
                'course_id' => $request->courseId,
                'chapter_id' => $request->chapterId,
                'lesson_id' => $request->lessonId,
                'type' => $request->type,
                'is_completed' => $request->status,
            ]);
        }

        Log::info("Lesson completion updated: UserID=" . Auth::id() . ", CourseID={$request->courseId}, LessonID={$request->lessonId}, Type={$request->type}, Status={$request->status}");

        return response()->json([
            'status' => 'success',
            'message' => $request->status ? __('Marked as completed') : __('Marked as incomplete'),
        ]);
    }

    /**
     * Determine live session status.
     *
     * @param \App\Models\CourseChapterLesson $lesson
     * @return string
     */
    private function getLiveStatus($lesson)
    {
        $now = now();
        if ($lesson->start_time && $lesson->end_time) {
            if ($now->between($lesson->start_time, $lesson->end_time)) {
                return 'started';
            } elseif ($now->lt($lesson->start_time)) {
                return 'waiting';
            }
        }
        return 'ended';
    }
}