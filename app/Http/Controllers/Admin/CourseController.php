<?php
// This an extra code of controller
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Course;
use App\Models\User;
use App\Rules\ValidateDiscountRule;
use Illuminate\Http\Request;

class CourseController extends Controller
{
    /**
     * Store a newly created or updated resource in storage.
     */
    public function store(Request $request)
    {
        $rules = [
            'instructor' => ['required', 'exists:users,id'],
            'title' => ['required', 'max:255'],
            'slug' => ['required', 'string', 'max:255', 'unique:courses,slug,' . $request->id],
            'seo_description' => ['nullable', 'string', 'max:255'],
            'thumbnail' => ['required', 'max:255'],
            'price' => ['required', 'numeric', 'min:0'],
            'discount_price' => ['nullable', 'numeric', new ValidateDiscountRule()],
            'affiliate_commission_percentage' => ['nullable', 'numeric', 'min:0', 'max:100'],
            'description' => ['required', 'string'],
        ];

        $request->validate($rules);

        $course = Course::updateOrCreate(
            ['id' => $request->id],
            [
                'instructor_id' => $request->instructor,
                'title' => $request->title,
                'slug' => $request->slug,
                'seo_description' => $request->seo_description,
                'thumbnail' => $request->thumbnail,
                'demo_video_storage' => $request->demo_video_storage,
                'demo_video_source' => $request->demo_video_storage == 'upload' ? $request->upload_path : $request->external_path,
                'price' => $request->price,
                'discount' => $request->discount_price,
                'affiliate_commission_percentage' => $request->affiliate_commission_percentage ?? 0,
                'description' => $request->description,
            ]
        );

        return response()->json([
            'status' => 'success',
            'message' => __('Course saved successfully'),
            'redirect' => route('admin.courses.edit', ['id' => $course->id, 'step' => $request->next_step])
        ]);
    }
}
