<?php

namespace App\Http\Controllers\Frontend;

use App\Models\Course;
use Illuminate\Support\Str;
use App\Models\AffiliateLink;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class AffiliateLinkController extends Controller
{
    /**
     * Generate a unique affiliate link for the given course.
     *
     * @param  int  $courseId
     * @return \Illuminate\Http\RedirectResponse
     */
    public function generate($courseId)
    {
        $user = Auth::user();
        $course = Course::findOrFail($courseId);

        // Ensure the user is an approved affiliate
        if (!$user->is_affiliate) {
            return redirect()->back()->with(['message' => __('You are not an approved affiliate.'), 'alert-type' => 'error']);
        }

        // Check if a link already exists for this user and course
        $existingLink = AffiliateLink::where('user_id', $user->id)
                                     ->where('course_id', $course->id)
                                     ->first();

        if ($existingLink) {
            return redirect()->back()->with(['message' => __('You have already generated a link for this course.'), 'alert-type' => 'info']);
        }

        // Generate a new unique referral code
        $referralCode = Str::random(10);
        while (AffiliateLink::where('referral_code', $referralCode)->exists()) {
            $referralCode = Str::random(10);
        }

        // Create the affiliate link
        AffiliateLink::create([
            'user_id' => $user->id,
            'course_id' => $course->id,
            'referral_code' => $referralCode,
        ]);

        return redirect()->back()->with(['message' => __('Your unique affiliate link has been generated successfully!'), 'alert-type' => 'success']);
    }
}
