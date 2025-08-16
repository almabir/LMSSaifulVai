@extends('frontend.student-dashboard.layouts.master')
@section('meta_title', $course->title . ' || ' . $setting->app_name)

@section('contents')

    <section class="wsus__course_video">
        <div class="col-12">
            <div class="wsus__course_header">
                <a href="{{ route('student.dashboard') }}"><i class="fas fa-angle-left"></i>
                    {{ __('Go back to dashboard') }}</a>
                <p>{{ __('Your Progress') }}: {{ $courseLectureCompletedByUser }} {{ __('of') }}
                    {{ $courseLectureCount }} ({{ number_format($courseCompletedPercent) }}%)</p>

                <div class="wsus__course_header_btn">
                    <i class="fas fa-stream"></i>
                </div>
            </div>
        </div>

        <div class="wsus__course_video_player">

            {{-- Player --}}
            <div class="video-payer">
                <div class="player-placeholder">
                    <div class="preloader-two player">
                        <div class="loader-icon-two player"><img src="{{ asset(Cache::get('setting')->preloader) }}"
                                alt="Preloader">
                        </div>
                    </div>
                </div>
                {{-- This is where content from getFileInfo will be loaded --}}
                <div id="video-player-info">
                    {{-- Initial content will be loaded here by JavaScript --}}
                </div>
            </div>

            {{-- Bottom Panel --}}
            @include('frontend.pages.learning-player.bottom-panel')

        </div>


        <div class="wsus__course_sidebar">
            <div class="wsus__course_sidebar_btn">
                <i class="fas fa-times"></i>
            </div>
            <h2 class="video_heading">{{ __('Course Content') }}</h2>
            <div class="accordion" id="accordionExample">
                @foreach ($course->chapters as $chapter)
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapse-{{ $chapter->id }}" aria-expanded="false"
                                aria-controls="collapse-{{ $chapter->id }}">
                                <b>{{ $chapter->title }}</b>
                                <span></span>
                            </button>
                        </h2>
                        <div id="collapse-{{ $chapter->id }}"
                            class="accordion-collapse collapse {{ $currentProgress?->chapter_id == $chapter->id ? 'show' : '' }}"
                            data-bs-parent="#accordionExample">
                            <div class="accordion-body course-content">
                                @foreach ($chapter->chapterItems as $chapterItem)
                                    {{-- IMPORTANT: data-lesson-id should always be chapterItem->id --}}
                                    {{-- The 'type' is also from chapterItem --}}
                                    @php
                                        $itemId = $chapterItem->id;
                                        $itemType = $chapterItem->type;
                                        $itemTitle = '';
                                        $itemDuration = '--.--';
                                        $itemIcon = asset('frontend/img/video_icon_black_2.png'); // Default icon
                                        $isWatched = false;

                                        if ($itemType == 'lesson' || $itemType == 'document' || $itemType == 'live') {
                                            $itemTitle = $chapterItem->lesson->title ?? '';
                                            $itemDuration = $chapterItem->lesson->duration ? minutesToHours($chapterItem->lesson->duration) : '--.--';
                                            $isWatched = in_array($itemId, $alreadyWatchedLectures);
                                            if ($itemType == 'live') {
                                                $itemIcon = asset('frontend/img/live.png');
                                            } elseif ($itemType == 'document') {
                                                $itemIcon = asset('frontend/img/' . $chapterItem->lesson->file_type . '.png');
                                            }
                                        } elseif ($itemType == 'quiz') {
                                            $itemTitle = $chapterItem->quiz->title ?? '';
                                            $isWatched = in_array($itemId, $alreadyCompletedQuiz);
                                            $itemIcon = asset('frontend/img/quiz_icon.png'); // Assuming a quiz icon
                                        }
                                    @endphp

                                    <div class="form-check {{ $itemId == $currentProgress?->lesson_id ? 'item-active' : '' }}">
                                        <input @checked($isWatched)
                                            class="form-check-input lesson-completed-checkbox" type="checkbox"
                                            data-lesson-id="{{ $itemId }}" value="1"
                                            data-type="{{ $itemType }}">
                                        <label class="form-check-label lesson-item"
                                            data-lesson-id="{{ $itemId }}"
                                            data-chapter-id="{{ $chapter->id }}" data-course-id="{{ $course->id }}"
                                            data-type="{{ $itemType }}">
                                            {{ $itemTitle }}
                                            <span>
                                                <img src="{{ $itemIcon }}" alt="icon" class="img-fluid">
                                                {{ $itemDuration }}
                                            </span>
                                        </label>
                                    </div>
                                @endforeach
                            </div>
                        </div>
                    </div>
                @endforeach

            </div>
        </div>
    </section>
@endsection
@push('scripts')
    <script>
        var preloader_path = "{{ asset(Cache::get('setting')->preloader) }}";
        // Define base_url globally if it's used in learning-player.js
        var base_url = "{{ url('/') }}"; 
        // Define quizUrlTemplate globally so learning-player.js can access it
        var quizUrlTemplate = "{{ route('student.quiz.index', ['id' => 'PLACEHOLDER']) }}";
        // Define liveSessionUrlTemplate globally
        var liveSessionUrlTemplate = "{{ route('student.learning.live', ['slug' => $course->slug, 'lesson_id' => 'PLACEHOLDER']) }}";
    </script>
    <script src="{{ asset('frontend/js/default/learning-player.js') }}?v={{$setting?->version}}"></script>
    <script src="{{ asset('frontend/js/default/quiz-page.js') }}?v={{$setting?->version}}"></script>
    <script src="{{ asset('frontend/js/default/qna.js') }}?v={{$setting?->version}}"></script>
    {{-- <script src="{{ asset('frontend/js/default/qna.js') }}?v={{$setting?->version}}"></script> --}} {{-- Duplicate --}}
    <script src="{{ asset('frontend/js/pdf.min.js') }}"></script>
    <script src="{{ asset('frontend/js/jszip.min.js') }}"></script>
    <script src="{{ asset('frontend/js/docx-preview.min.js') }}"></script>
    <script>
        "use strict";
        $(document).ready(function() {
            // reset quiz timer
            resetCountdown(); // Ensure this function is defined in quiz-page.js

            // Initial content load logic
            // This needs to be robust and wait for learning-player.js to be ready.
            // The best way is to trigger a custom event or ensure the click handler is attached.
            
            // Wait for learning-player.js to attach its handlers, then trigger the click
            // A small timeout can help ensure event handlers are ready
            setTimeout(function() {
                var lessonId = "{{ request('lesson') }}";
                var type = "{{ request('type') }}";
                var currentProgressLessonId = "{{ $currentProgress?->lesson_id }}";
                var currentProgressType = "{{ $currentProgress?->type }}";

                var targetLessonSelector = $(`.lesson-item[data-lesson-id="${lessonId}"][data-type="${type}"]`);
                var currentLessonSelector = $(`.lesson-item[data-lesson-id="${currentProgressLessonId}"][data-type="${currentProgressType}"]`);

                if (targetLessonSelector.length) {
                    targetLessonSelector.trigger('click');
                } else if (currentLessonSelector.length) {
                    currentLessonSelector.trigger('click');
                } else {
                    // Fallback: click the very first available lesson item
                    $('.lesson-item:first').trigger('click');
                }
            }, 500); // Give a small delay for scripts to load and attach handlers
        });
    </script>
    <script src="{{ asset('frontend/js/custom-tinymce.js') }}"></script>
@endpush
