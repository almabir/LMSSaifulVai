<?php

namespace Modules\Frontend\app\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Modules\Language\app\Models\Language;
use Modules\Frontend\app\Models\CounterSection;
use Modules\Language\app\Enums\TranslationModels;
use Modules\Language\app\Traits\GenerateTranslationTrait;
use Modules\Frontend\app\Models\CounterSectionTranslation;

class CounterSectionController extends Controller {
    use GenerateTranslationTrait;
    /**
     * Display a listing of the resource.
     */
    public function index() {
        checkAdminHasPermissionAndThrowException('section.management');
        $code = request('code') ?? getSessionLanguage();
        if (!Language::where('code', $code)->exists()) {
            abort(404);
        }
        $languages = allLanguages();
        $counter = CounterSection::first();
        return view('frontend::counter-section.index', compact('languages', 'code','counter'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create() {
        return view('frontend::create');
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id) {

        checkAdminHasPermissionAndThrowException('section.management');
        $validated = $request->validate([
            'total_student_count'    => ['nullable', 'numeric', 'max:1000000000', 'min:0'],
            'total_instructor_count' => ['nullable', 'numeric', 'max:1000000000', 'min:0'],
            'total_courses_count'    => ['nullable', 'numeric', 'max:1000000000', 'min:0'],
            'total_awards_count'     => ['nullable', 'numeric', 'max:1000000000', 'min:0'],
            'section_title'                  => ['nullable', 'string', 'max:1000'],
            'description'                  => ['nullable', 'string', 'max:255'],
        ], [
            'total_student_count.max'    => __('Total student count must be less than or equal to 1000000000'),
            'total_student_count.min'    => __('Total student count must be greater than or equal to 0'),
            'total_instructor_count.max' => __('Total instructor count must be less than or equal to 1000000000'),
            'total_instructor_count.min' => __('Total instructor count must be greater than or equal to 0'),
            'total_courses_count.max'    => __('Total courses count must be less than or equal to 1000000000'),
            'total_courses_count.min'    => __('Total courses count must be greater than or equal to 0'),
            'total_awards_count.max'     => __('Total awards count must be less than or equal to 1000000000'),
            'total_awards_count.min'     => __('Total awards count must be greater than or equal to 0'),
            'section_title.max'                  => __('Title must be less than or equal to 255'),
            'description.nullable' => __('The description is not valid.'),
            'description.string' => __('The description is not valid.'),
            'description.max' => __('The description is too long.'),
        ]);

        $counterSection = CounterSection::updateOrCreate(
            ['id' => 1],
            [
                'total_student_count' => $request->total_student_count,
                'total_instructor_count' => $request->total_instructor_count,
                'total_courses_count' => $request->total_courses_count,
                'total_awards_count' => $request->total_awards_count,
            ]
        );

        $translation = CounterSectionTranslation::where('counter_section_id', $counterSection->id)->exists();

        if (!$translation) {
            $this->generateTranslations(
                TranslationModels::CounterSection,
                $counterSection,
                'counter_section_id',
                $request,
            );
        }

        $this->updateTranslations(
            $counterSection,
            $request,
            $request->all(),
        );
        return redirect()->back()->with(['messege' => __('Updated successfully'), 'alert-type' => 'success']);
    }

}
