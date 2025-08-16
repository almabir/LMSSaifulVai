<?php

namespace App\Http\Controllers\Frontend;

use Carbon\Carbon;
use App\Models\Quiz;
use Firebase\JWT\JWT;
use App\Models\Course;
use App\Models\QuizResult;
use App\Models\Announcement;
use App\Models\CourseReview;
use App\Models\JitsiSetting;
use App\Models\QuizQuestion;
use Illuminate\Http\Request;
use App\Models\CourseProgress;
use App\Rules\CustomRecaptcha;
use App\Models\CourseChapterItem;
use App\Models\CourseChapterLesson;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Storage;
use Modules\Order\app\Models\Enrollment; // IMPORTANT: Ensure this is imported
use Illuminate\Support\Facades\File; // Ensure File facade is imported for public_path checks

class LearningController extends Controller {
    function index(string $slug) {
        // Fetch the course with its chapters, chapter items, lessons, and quizzes
        // Use active() and approved() scopes for clarity, remove withTrashed() if not needed for soft-deleted courses
        $course = Course::active() // Assumes 'active' scope exists and filters by status
                        ->where('is_approved', 'approved') // Assumes 'is_approved' column
                        ->with([
                            'chapters' => function($query) {
                                $query->orderBy('order'); // Order chapters
                            },
                            'chapters.chapterItems' => function($query) {
                                $query->orderBy('order'); // Order chapter items
                            },
                            'chapters.chapterItems.lesson',
                            'chapters.chapterItems.quiz',
                        ])
                        ->where('slug', $slug)
                        ->first(); // Use first() instead of firstOrFail() to handle non-existent slugs gracefully later
        // If course not found, redirect to home or show 404
        if (!$course) {
            return redirect()->route('home')->with('error', __('Course not found.'));
        }

        // --- CRITICAL: Enrollment Check ---
        $user = userAuth(); // Assuming userAuth() reliably returns the authenticated user
        if (!$user) {
            // User is not authenticated, redirect to login or show an error
            return redirect()->route('login')->with('error', __('Please login to access this course.'));
        }

        $isEnrolled = Enrollment::where('user_id', $user->id)
                                ->where('course_id', $course->id)
                                ->where('has_access', 1) // Assuming 'has_access' indicates active enrollment
                                ->exists();

        if (!$isEnrolled) {
            // User is not enrolled or doesn't have access
            return redirect()->route('course.show', $course->slug)->with('error', __('You are not enrolled in this course or do not have access.'));
        }
        // --- END CRITICAL: Enrollment Check ---

        // Store course info in session (if this is a required pattern)
        Session::put('course_slug', $slug);
        Session::put('course_title', $course->title);

        // Fetch current progress
        $currentProgress = CourseProgress::where('user_id', $user->id)
            ->where('course_id', $course->id)
            ->where('current', 1)
            ->orderBy('id', 'desc')
            ->first();

        // Fetch already watched lectures and completed quizzes
        $alreadyWatchedLectures = CourseProgress::where('user_id', $user->id)
            ->where('course_id', $course->id)
            ->where('type', 'lesson')
            ->where('watched', 1)
            ->pluck('lesson_id')
            ->toArray();

        $alreadyCompletedQuiz = CourseProgress::where('user_id', $user->id)
            ->where('course_id', $course->id)
            ->where('type', 'quiz')
            ->where('watched', 1)
            ->pluck('lesson_id') // Assuming lesson_id here refers to chapter_item_id for quizzes
            ->toArray();

        $announcements = Announcement::where('course_id', $course->id)->orderBy('id', 'desc')->get();

        // Calculate course completion percentage
        $totalItems = 0;
        $courseLectureCompletedByUser = 0; // This will count all watched items (lessons, quizzes, docs, live)

        foreach ($course->chapters as $chapter) {
            foreach ($chapter->chapterItems as $item) {
                $totalItems++;
                // Check if this specific item (lesson, quiz, document, live) is marked as watched
                $progressItem = CourseProgress::where('user_id', $user->id)
                                              ->where('course_id', $course->id)
                                              ->where('chapter_id', $chapter->id)
                                              ->where('lesson_id', $item->id) // lesson_id in CourseProgress actually stores chapter_item_id
                                              ->where('type', $item->type)
                                              ->where('watched', 1)
                                              ->first();
                if ($progressItem) {
                    $courseLectureCompletedByUser++;
                }
            }
        }
        
        $courseLectureCount = $totalItems; // Total count of all chapter items
        $courseCompletedPercent = $courseLectureCount > 0 ? ($courseLectureCompletedByUser / $courseLectureCount) * 100 : 0;

        // Initialize currentProgress if it's null and course has content
        if (!$currentProgress && $course->chapters->isNotEmpty()) {
            $firstChapter = $course->chapters->first();
            $firstChapterItem = $firstChapter->chapterItems->first();

            if ($firstChapterItem) {
                $currentProgress = CourseProgress::create([
                    'user_id'    => $user->id,
                    'course_id'  => $course->id,
                    'chapter_id' => $firstChapter->id,
                    'lesson_id'  => $firstChapterItem->id, // lesson_id in CourseProgress should store chapter_item_id
                    'type'       => $firstChapterItem->type,
                    'current'    => 1,
                ]);
            }
        }
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

    // ... (rest of your controller methods) ...

    function getFileInfo(Request $request) {
        // set progress status
        // Ensure lessonId in CourseProgress refers to chapter_item_id
        CourseProgress::where('course_id', $request->courseId)->update(['current' => 0]);
        $progress = CourseProgress::updateOrCreate(
            [
                'user_id'    => userAuth()->id,
                'course_id'  => $request->courseId,
                'chapter_id' => $request->chapterId,
                'lesson_id'  => $request->lessonId, // This should be chapter_item_id
                'type'       => $request->type,
            ],
            [
                'current' => 1,
            ]
        );

        // Fetch the actual chapter item based on the lessonId (which is chapter_item_id)
        $chapterItem = CourseChapterItem::findOrFail($request->lessonId);

        if ($request->type == 'lesson') {
            $lesson = CourseChapterLesson::select(['id', 'file_path', 'storage', 'file_type', 'downloadable', 'description'])
                                        ->where('chapter_item_id', $chapterItem->id) // Link to chapter item
                                        ->firstOrFail();

            $fileInfo = array_merge($lesson->toArray(), ['type' => 'lesson']);
            
            // Handle file paths based on storage type
            if (in_array($fileInfo['storage'], ['wasabi', 'aws'])) {
                $fileInfo['file_path'] = Storage::disk($fileInfo['storage'])->url($fileInfo['file_path']);
            } elseif ($fileInfo['storage'] == 'upload') {
                // For 'upload' type, use asset() if stored in public directory
                $fileInfo['file_path'] = asset($fileInfo['file_path']);
            }
            // For youtube, vimeo, external_link, iframe, file_path is already the URL

            return response()->json([
                'file_info' => $fileInfo,
            ]);
        } elseif ($request->type == 'live') {
            $lesson = CourseChapterLesson::with([
                'course:id,instructor_id,slug',
                'course.instructor:id',
                'course.instructor.zoom_credential:id,instructor_id,client_id,client_secret',
                'course.instructor.jitsi_credential:id,instructor_id,app_id,api_key,permissions',
                'live:id,lesson_id,start_time,type,meeting_id,password,join_url',
            ])->select([
                'id', 'course_id', 'chapter_item_id', 'title', 'description',
                'duration', 'file_path', 'storage', 'file_type', 'downloadable',
            ])->where('chapter_item_id', $chapterItem->id) // Link to chapter item
              ->firstOrFail();

            $fileInfo = array_merge($lesson->toArray(), ['type' => 'live']);

            $now = Carbon::now();
            $startTime = Carbon::parse($fileInfo['live']['start_time']);
            $endTime = $startTime->clone()->addMinutes($fileInfo['duration']);
            $fileInfo['start_time'] = formattedDateTime($startTime);
            $fileInfo['end_time'] = formattedDateTime($endTime);
            $fileInfo['is_live_now'] = $now->between($startTime, $endTime);

            if ($now->lt($startTime)) {
                $fileInfo['is_live_now'] = 'not_started';
            } elseif ($now->between($startTime, $endTime)) {
                $fileInfo['is_live_now'] = 'started';
            } else {
                $fileInfo['is_live_now'] = 'ended';
            }

            return response()->json([
                'file_info' => $fileInfo,
            ]);
        } elseif ($request->type == 'document') {
            $lesson = CourseChapterLesson::select(['id', 'file_path', 'storage', 'file_type', 'downloadable', 'description'])
                                        ->where('chapter_item_id', $chapterItem->id) // Link to chapter item
                                        ->firstOrFail();

            $fileInfo = array_merge($lesson->toArray(), ['type' => 'document']);
            
            // For 'upload' type documents, use asset()
            if ($fileInfo['storage'] == 'upload') {
                $fileInfo['file_path'] = asset($fileInfo['file_path']);
            }
            // For other document types like external_link, iframe, file_path is already the URL

            if ('pdf' == $fileInfo['file_type']) {
                return response()->json([
                    'view'      => view('frontend.pages.learning-player.partials.pdf-viewer', ['file_path' => $fileInfo['file_path']])->render(),
                    'file_info' => $fileInfo,
                ]);
            } elseif ('docx' == $fileInfo['file_type']) {
                return response()->json([
                    'view'      => view('frontend.pages.learning-player.partials.docx-viewer', ['file_path' => $fileInfo['file_path']])->render(),
                    'file_info' => $fileInfo,
                ]);
            } else {
                return response()->json([
                    'file_info' => $fileInfo,
                ]);
            }
        } else { // type == 'quiz'
            $quiz = Quiz::where('chapter_item_id', $chapterItem->id)->firstOrFail(); // Link to chapter item
            $fileInfo = array_merge($quiz->toArray(), ['type' => 'quiz']);

            return response()->json([
                'file_info' => $fileInfo,
            ]);
        }
    }

    function makeLessonComplete(Request $request) {
        $progress = CourseProgress::where(['lesson_id' => $request->lessonId, 'user_id' => userAuth()->id, 'type' => $request->type])->first();
        if ($progress) {
            $progress->watched = $request->status;
            $progress->save();
            return response()->json(['status' => 'success', 'message' => __('Updated successfully.')]);
        } else {
            if ($request->status == 0) {
                return;
            }

            // If a progress record doesn't exist, create one before marking it watched
            $chapterItem = CourseChapterItem::find($request->lessonId); // lessonId here is chapter_item_id
            if ($chapterItem) {
                CourseProgress::create([
                    'user_id'    => userAuth()->id,
                    'course_id'  => $request->courseId,
                    'chapter_id' => $request->chapterId,
                    'lesson_id'  => $request->lessonId, // chapter_item_id
                    'type'       => $request->type,
                    'watched'    => $request->status,
                    'current'    => 0, // Not necessarily current, just watched
                ]);
                return response()->json(['status' => 'success', 'message' => __('Updated successfully.')]);
            }

            return response()->json(['status' => 'error', 'message' => __('You didn\'t watch this lesson or item not found.')]);
        }
    }

    function downloadResource(string $lessonId) {
        $resource = CourseChapterLesson::findOrFail($lessonId);

        // Handle different storage types for download
        if ($resource->storage == 'upload') {
            $fullPath = public_path($resource->file_path);
            if (!File::exists($fullPath)) {
                return redirect()->back()->with(['alert-type' => 'error', 'message' => __('Local file not found or link is broken.')]);
            }
            return response()->download($fullPath);
        } elseif (in_array($resource->storage, ['wasabi', 'aws'])) {
            // For cloud storage, you might want to redirect to the URL or provide a temporary signed URL
            // For now, we'll redirect if it's a direct URL, or provide an error for private files
            try {
                // Attempt to get a temporary URL if the disk supports it (e.g., S3)
                $url = Storage::disk($resource->storage)->url($resource->file_path);
                return redirect($url);
            } catch (\Exception $e) {
                return redirect()->back()->with(['alert-type' => 'error', 'message' => __('Cloud file not accessible for download.')]);
            }
        } else {
            // For external links (youtube, vimeo, external_link, iframe), direct download is not possible.
            // You might want to redirect to the external link or show an error.
            if (filter_var($resource->file_path, FILTER_VALIDATE_URL)) {
                return redirect($resource->file_path);
            }
            return redirect()->back()->with(['alert-type' => 'error', 'message' => __('Resource is not downloadable or link is invalid.')]);
        }
    }

    function quizIndex(string $id) {

        $attempt = QuizResult::where('user_id', userAuth()->id)->where('quiz_id', $id)->count();
        $quiz = Quiz::withCount('questions')->findOrFail($id);
        if ($attempt >= $quiz->attempt) {
            return redirect()->route('student.learning.index', Session::get('course_slug'))->with(['alert-type' => 'error', 'message' => __('You reached maximum attempt')]);
        }

        return view('frontend.pages.learning-player.quiz-index', compact('quiz', 'attempt'));
    }

    function quizStore(Request $request, string $id) {
        $grad = 0;
        $result = [];
        $quiz = Quiz::findOrFail($id);
        // Add validation for correct answer count
        $request->validate([
            'question' => 'required|array',
            'question.*' => 'required', // Each question must have an answer
        ]);

        foreach ($request->question as $key => $questionAns) {
            $question = QuizQuestion::findOrFail($key);
            $correctAnswers = $question->answers->where('correct', 1)->pluck('id')->toArray();

            // Handle multiple choice vs single choice
            if ($question->type === 'multiple') { // Assuming 'multiple' for single-select answers
                if (in_array($questionAns, $correctAnswers)) {
                    $grad += $question->grade;
                    $result[$key] = [
                        "answer"  => $questionAns,
                        "correct" => true,
                    ];
                } else {
                    // Apply negative marking if enabled
                    if ($quiz->negative_marking && $quiz->negative_marks > 0) {
                        $grad -= $quiz->negative_marks;
                    }
                    $result[$key] = [
                        "answer"  => $questionAns,
                        "correct" => false,
                    ];
                }
            }
            // Add logic for 'descriptive' type if needed
        }

        $quizResult = QuizResult::create([
            'user_id'    => userAuth()->id,
            'quiz_id'    => $id,
            'result'     => json_encode($result),
            'user_grade' => $grad,
            'status'     => $grad >= $quiz->pass_mark ? 'pass' : 'failed',
        ]);
        return redirect()->route('student.quiz.result', ['id' => $id, 'result_id' => $quizResult->id]);
    }

    function quizResult(string $id, string $resultId) {
        $attempt = QuizResult::where('user_id', userAuth()->id)->where('quiz_id', $id)->count();
        $quiz = Quiz::withCount('questions')->findOrFail($id);
        $quizResult = QuizResult::findOrFail($resultId);

        return view('frontend.pages.learning-player.quiz-result', compact('quiz', 'attempt', 'quizResult'));
    }

    function addReview(Request $request) {
        $request->validate([
            'course_id'            => ['required', 'exists:courses,id'],
            'rating'               => ['required', 'integer', 'min:1', 'max:5'],
            'review'               => ['required', 'max: 1000', 'string'],
            'g-recaptcha-response' => Cache::get('setting')->recaptcha_status === 'active' ? ['required', new CustomRecaptcha()] : 'nullable',
        ], [
            'rating.required'              => __('rating filed is required'),
            'rating.integer'               => __('rating have to be an integer'),
            'review.required'              => __('review filed is required'),
            'g-recaptcha-response.required' => __('Please complete the recaptcha to submit the form'),
        ]);

        $review = CourseReview::where(['course_id' => $request->course_id, 'user_id' => userAuth()->id])->first();
        if ($review) {
            return redirect()->back()->with(['alert-type' => 'error', 'message' => __('Already added review')]);
        }

        CourseReview::create([
            'course_id' => $request->course_id,
            'user_id'   => userAuth()->id,
            'rating'    => $request->rating,
            'review'    => $request->review,
        ]);

        return redirect()->back()->with(['alert-type' => 'success', 'message' => __('Review added successfully')]);

    }

    function fetchReviews(Request $request, string $courseId) {
        $reviews = CourseReview::where(['course_id' => $courseId, 'status' => 1])->whereHas('course')->whereHas('user')->orderBy('id', 'desc')->paginate(8, ['*'], 'page', $request->page ?? 1);
        return response()->json([
            'view'       => view('frontend.pages.learning-player.partials.review-card', compact('reviews'))->render(),
            'page'       => $request->page,
            'last_page'  => $reviews->lastPage(),
            'data_count' => $reviews->count(),
        ]);
    }

    function liveSession(Request $request, string $slug, string $lesson_id) {
        $lesson = CourseChapterLesson::select('id', 'course_id', 'chapter_item_id', 'title')->with(['course' => function ($q) {
            $q->select('id', 'instructor_id', 'slug');
        }, 'course.instructor' => function ($q) {
            $q->select('id');
        }, 'course.instructor.zoom_credential' => function ($q) {
            $q->select('id', 'instructor_id', 'client_id', 'client_secret');
        }, 'chapterItem' => function ($q) {
            $q->select('id', 'type');
        }, 'live' => function ($q) {
            $q->select('id', 'lesson_id', 'start_time', 'type', 'meeting_id', 'password', 'join_url');
        }])->findOrFail($lesson_id);

        if ($lesson->live->type == 'zoom') {
            return view('frontend.pages.learning-player.partials.live.zoom', compact('lesson'));
        } else {
            $jitsi_credential = JitsiSetting::where('instructor_id',$lesson->course->instructor_id)->first();
            if($jitsi_credential){
                $jwt = $this->generateJwtToken($jitsi_credential);
                $roomName = "{$jitsi_credential->app_id}/{$lesson->live->meeting_id}";
                return view('frontend.pages.learning-player.partials.live.jitsi', [
                    'title' => $lesson->title,
                    'jwt' => trim($jwt),
                    'roomName' => $roomName
                ]);
            }
            return back();
        }
    }

    /**
     * Generate a JaaS JWT token.
     *
     * @return string
     */
    protected function generateJwtToken($jitsi_credential) {
        $user = userAuth();
        $instructor = $jitsi_credential->instructor_id == $user->id;

        $api_key = $jitsi_credential->api_key;
        $app_id =  $jitsi_credential->app_id; // Your AppID (previously tenant)
        $user_email = $user->name;
        $user_name = $user->name;
        $user_is_moderator = $instructor;
        $user_avatar_url = !empty($user->image) ? asset($user->image) : "";
        $user_id = $user->id;
        $live_streaming_enabled = $instructor;
        $recording_enabled = $instructor;
        $outbound_enabled = false;
        $transcription_enabled = false;
        $exp_delay = 7200;
        $nbf_delay = 0;

        // Read your private key from file
        $private_key = file_get_contents(storage_path("app/user_{$jitsi_credential->instructor_id}/rsb_private_key.pk"));

        $payload = [
            'iss'     => 'chat',
            'aud'     => 'jitsi',
            'exp'     => time() + $exp_delay,
            'nbf'     => time() - $nbf_delay,
            'room'    => '*',
            'sub'     => $app_id,
            'context' => [
                'user'     => [
                    'moderator' => $user_is_moderator ? "true" : "false",
                    'email'     => $user_email,
                    'name'      => $user_name,
                    'avatar'    => $user_avatar_url,
                    'id'        => $user_id,
                ],
                'features' => [
                    'recording'     => $recording_enabled ? "true" : "false",
                    'livestreaming' => $live_streaming_enabled ? "true" : "false",
                    'transcription' => $transcription_enabled ? "true" : "false",
                    'outbound-call' => $outbound_enabled ? "true" : "false",
                ],
            ],
        ];

        return JWT::encode($payload, $private_key, "RS256", $api_key);
    }
}
