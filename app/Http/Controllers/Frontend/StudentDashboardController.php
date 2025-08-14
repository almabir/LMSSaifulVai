<?php

namespace App\Http\Controllers\Frontend;


use App\Models\Course;
use Modules\Order\app\Models\Enrollment;
use Modules\Order\app\Models\Order;
use App\Models\QuizResult;
use Illuminate\View\View;
use App\Models\CourseReview;
use Illuminate\Http\Request;
use App\Models\CourseProgress;
use App\Models\CourseChapterItem;
use Illuminate\Support\Facades\Auth;
use App\Models\AffiliateCommission;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Session;
use Barryvdh\DomPDF\Facade\Pdf as PDF;
use Modules\CertificateBuilder\app\Models\CertificateBuilder;
use Modules\CertificateBuilder\app\Models\CertificateBuilderItem;


class StudentDashboardController extends Controller
{
    /**
     * Display the student dashboard.
     */
    public function index(): View
    {
        $user = Auth::user();
        $totalEnrolledCourses = Enrollment::where('user_id', $user->id)->count();
        $totalQuizAttempts = QuizResult::where('user_id', $user->id)->count();
        $totalReviews = CourseReview::where('user_id', $user->id)->count();
        $orders = Order::where('buyer_id', $user->id)->latest()->take(10)->get();

        // Initialize affiliate data
        $affiliateData = [
            'total_sales' => 0,
            'total_commission' => 0,
            'recent_commissions' => collect(),
        ];

        // Fetch affiliate data only if the user is an affiliate
        if ($user->is_affiliate) {
            $affiliateData['total_sales'] = AffiliateCommission::where('user_id', $user->id)->count();
            $affiliateData['total_commission'] = AffiliateCommission::where('user_id', $user->id)->sum('commission_amount');
            $affiliateData['recent_commissions'] = AffiliateCommission::with('course:id,title')
                                                    ->where('user_id', $user->id)
                                                    ->latest()
                                                    ->take(10)
                                                    ->get();
        }

        return view('frontend.student-dashboard.index', compact(
            'totalEnrolledCourses',
            'totalQuizAttempts',
            'totalReviews',
            'orders',
            'affiliateData'
        ));
    }

    /**
     * Display the enrolled courses for the student.
     */
    function enrolledCourses()
    {
        $enrolls = Enrollment::with(['course' => function ($q) {
            $q->withTrashed();
        }])->where('user_id', auth()->id())->orderByDesc('id')->paginate(10);

        return view('frontend.student-dashboard.enrolled-courses.index', compact('enrolls'));
    }

    /**
     * Display the quiz attempts for the student.
     */
    function quizAttempts()
    {
        Session::forget('course_slug');
        $quizAttempts = QuizResult::with(['quiz'])->where('user_id', auth()->id())->orderByDesc('id')->paginate(10);

        return view('frontend.student-dashboard.quiz-attempts.index', compact('quizAttempts'));
    }

    /**
     * Generate and download a course certificate.
     */
    function downloadCertificate(string $id)
    {
        $certificate = CertificateBuilder::first();
        $certificateItems = CertificateBuilderItem::all();
        $course = Course::withTrashed()->find($id);

        $courseLectureCount = CourseChapterItem::whereHas('chapter', function ($q) use ($course) {
            $q->where('course_id', $course->id);
        })->count();

        $courseLectureCompletedByUser = CourseProgress::where('user_id', auth()->id())
            ->where('course_id', $course->id)->where('watched', 1)->latest();

        $completed_date = $courseLectureCompletedByUser->first()?->created_at;

        $courseLectureCompletedByUserCount = CourseProgress::where('user_id', auth()->id())
            ->where('course_id', $course->id)->where('watched', 1)->count();

        $courseCompletedPercent = $courseLectureCount > 0 ? ($courseLectureCompletedByUserCount / $courseLectureCount) * 100 : 0;

        if ($courseCompletedPercent < 100) {
            abort(404, 'Course not completed yet.');
        }

        $html = view('frontend.student-dashboard.certificate.index', compact('certificateItems', 'certificate'))->render();

        $html = str_replace('[student_name]', Auth::user()->name, $html);
        $html = str_replace('[platform_name]', Cache::get('setting')->app_name, $html);
        $html = str_replace('[course]', $course->title, $html);
        $html = str_replace('[date]', formatDate($completed_date), $html);
        $html = str_replace('[instructor_name]', $course->instructor->name, $html);
        
        // Use the PDF facade for a cleaner approach
        $pdf = PDF::loadHtml($html)->setPaper('A4', 'portrait');
        
        return $pdf->stream('certificate.pdf');
    }
}
