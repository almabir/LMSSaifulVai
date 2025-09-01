@extends('frontend.layouts.master')
@section('meta_title', $course->title . ' || ' . $setting->app_name)
@push('custom_meta')
    <meta property="description" content="{{ $course->seo_description }}" />
    <meta property="og:title" content="{{ $course->title }}" />
    <meta property="og:description" content="{{ $course->seo_description }}" />
    <meta property="og:image" content="{{ asset($course->thumbnail) }}" />
    <meta property="og:URL" content="{{ url()->current() }}" />
    <meta property="og:type" content="website" />
@endpush
@push('styles')
    <link rel="stylesheet" href="{{ asset('frontend/css/shareon.min.css') }}">
@endpush
@section('contents')
    <!-- breadcrumb-area -->
    <x-frontend.breadcrumb :title="__('Course Details')" :links="[
        ['url' => route('home'), 'text' => __('Home')],
        ['url' => '#', 'text' => __('Course Details')],
    ]" />
    <!-- breadcrumb-area-end -->

    <!-- courses-details-area -->
    <section class="courses__details-area section-py-120">
        <div class="container">
            <div class="row">
                <div class="col-xl-9 col-lg-8">
                    <div class="courses__details-thumb">
                        <img class="w-100" src="{{ asset($course->thumbnail) }}" alt="img">
                        @if ($course->demo_video_source)
                            <a href="{{ $course->demo_video_source }}" class="popup-video"><i class="fas fa-play"></i></a>
                        @endif
                    </div>
                    <div class="courses__details-content">
                        <ul class="courses__item-meta list-wrap">
                            <li class="courses__item-tag">
                                <a
                                    href="{{ route('courses', ['category' => $course->category->id]) }}">{{ $course->category->translation->name }}</a>
                            </li>
                            <li class="avg-rating"><i class="fas fa-star"></i>
                                {{ number_format($course->reviews()->avg('rating'), 1) ?? 0 }} {{ __('Reviews') }}</li>
                        </ul>
                        <h2 class="title">{{ $course->title }}</h2>
                        <div class="courses__details-meta">
                            <ul class="list-wrap">
                                <li class="author-two">
                                    <img src="{{ asset($course->instructor->image) }}" alt="img"
                                        class="instructor-avatar">
                                    {{ __('By') }}
                                    <a
                                        href="{{ route('instructor-details', $course->instructor->id) }}">{{ $course->instructor->name }}</a>
                                </li>
                                <li class="date"><i
                                        class="flaticon-calendar"></i>{{ formatDate($course->created_at, 'd/M/Y') }}</li>
                                <li><i class="flaticon-mortarboard"></i>{{ $course->enrollments->count() }}
                                    {{ __('Students') }}</li>
                            </ul>
                        </div>
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="overview-tab" data-bs-toggle="tab"
                                    data-bs-target="#overview-tab-pane" type="button" role="tab"
                                    aria-controls="overview-tab-pane" aria-selected="true">{{ __('Overview') }}</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="curriculum-tab" data-bs-toggle="tab"
                                    data-bs-target="#curriculum-tab-pane" type="button" role="tab"
                                    aria-controls="curriculum-tab-pane"
                                    aria-selected="false">{{ __('Curriculum') }}</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="instructors-tab" data-bs-toggle="tab"
                                    data-bs-target="#instructors-tab-pane" type="button" role="tab"
                                    aria-controls="instructors-tab-pane"
                                    aria-selected="false">{{ __('Instructors') }}</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="reviews-tab" data-bs-toggle="tab"
                                    data-bs-target="#reviews-tab-pane" type="button" role="tab"
                                    aria-controls="reviews-tab-pane" aria-selected="false">{{ __('reviews') }}</button>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="overview-tab-pane" role="tabpanel"
                                aria-labelledby="overview-tab" tabindex="0">
                                <div class="courses__overview-wrap">
                                    <h3 class="title">{{ __('Course Description') }}</h3>
                                    {!! clean($course->description) !!}

                                </div>
                            </div>
                            <div class="tab-pane fade" id="curriculum-tab-pane" role="tabpanel"
                                aria-labelledby="curriculum-tab" tabindex="0">
                                <div class="courses__curriculum-wrap">
                                    <h3 class="title">{{ __('Course Curriculum') }}</h3>
                                    <div class="accordion" id="accordionExample">
                                        @foreach ($course->chapters as $chapter)
                                            <div class="accordion-item">
                                                <h2 class="accordion-header" id="heading{{ $chapter->id }}">
                                                    <button class="accordion-button collapsed" type="button"
                                                        data-bs-toggle="collapse"
                                                        data-bs-target="#collapse{{ $chapter->id }}"
                                                        aria-expanded="false"
                                                        aria-controls="collapse{{ $chapter->id }}">
                                                        {{ $loop->iteration }}. {{ $chapter->title }}
                                                    </button>
                                                </h2>
                                                <div id="collapse{{ $chapter->id }}" class="accordion-collapse collapse"
                                                    aria-labelledby="heading{{ $chapter->id }}"
                                                    data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <ul class="list-wrap">
                                                            @foreach ($chapter->chapterItems as $chapterItem)
                                                                {{-- Lesson and Quiz items logic --}}
                                                            @endforeach
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        @endforeach
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="instructors-tab-pane" role="tabpanel"
                                aria-labelledby="instructors-tab" tabindex="0">
                                {{-- Instructors tab content --}}
                            </div>
                            <div class="tab-pane fade" id="reviews-tab-pane" role="tabpanel"
                                aria-labelledby="reviews-tab" tabindex="0">
                                {{-- Reviews tab content --}}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-lg-4">
                    <div class="courses__details-sidebar">
                        <div class="courses__cost-wrap">
                            <span>{{ __('This Course Fee') }}:</span>
                            @if ($course->price == 0)
                                <h2 class="title">{{ __('Free') }}</h2>
                            @elseif ($course->discount)
                                <h2 class="title">{{ currency($course->discount) }}
                                    <del>{{ currency($course->price) }}</del>
                                </h2>
                            @else
                                <h2 class="title">{{ currency($course->price) }}</h2>
                            @endif
                        </div>
                        <div class="courses__information-wrap">
                            {{-- Course includes section --}}
                        </div>
                        <div class="courses__details-social">
                            <h5 class="title">{{ __('Share this course') }}:</h5>
                            <div class="shareon">
                                <a class="facebook"></a>
                                <a class="linkedin"></a>
                                <a class="pinterest"></a>
                                <a class="telegram"></a>
                                <a class="twitter"></a>
                            </div>
                        </div>
                        <div class="courses__details-enroll">
                            <div class="tg-button-wrap">
                                @if (in_array($course->id, session('enrollments') ?? []))
                                    <a href="{{ route('student.enrolled-courses') }}"
                                        class="btn btn-two arrow-btn already-enrolled-btn">
                                        <span class="text">{{ __('Enrolled') }}</span>
                                        <i class="flaticon-arrow-right"></i>
                                    </a>
                                @else
                                    <a href="javascript:;" class="btn btn-two arrow-btn add-to-cart"
                                        data-id="{{ $course->id }}">
                                        <span class="text">{{ __('Add To Cart') }}</span>
                                        <i class="flaticon-arrow-right"></i>
                                    </a>
                                @endif
                            </div>
                        </div>

                        {{-- === AFFILIATE LINK SECTION INSERTED HERE === --}}
                        @if(auth()->check() && auth()->user()->is_affiliate)
                            <div class="card mt-4">
                                <div class="card-header">
                                    <h5>{{ __('Affiliate Program') }}</h5>
                                </div>
                                <div class="card-body text-center">
                                    @if($affiliateLink)
                                        <p>{{ __("Share your unique link to earn a commission!") }}</p>
                                        <div class="input-group mb-3">
                                            <input type="text" id="referral-link" class="form-control" value="{{ route('course.show', ['slug' => $course->slug, 'ref' => $affiliateLink->referral_code]) }}" readonly>
                                            <button class="btn btn-outline-secondary" type="button" id="copy-btn" onclick="copyToClipboard()">{{ __('Copy') }}</button>
                                        </div>
                                    @else
                                        <p>{{ __("Generate your unique referral link for this course.") }}</p>
                                        <form action="{{ route('affiliate.link.generate', $course->id) }}" method="POST">
                                            @csrf
                                            <button type="submit" class="btn btn-primary">{{ __('Generate My Link') }}</button>
                                        </form>
                                    @endif
                                </div>
                            </div>
                        @endif
                        {{-- === END OF AFFILIATE LINK SECTION === --}}

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- courses-details-area-end -->
@endsection

@push('scripts')
    <script src="{{ asset('frontend/js/default/course-details.js') }}"></script>
    <script src="{{ asset('frontend/js/shareon.iife.js') }}"></script>
    <script>
        Shareon.init();

        function copyToClipboard() {
            var copyText = document.getElementById("referral-link");
            copyText.select();
            copyText.setSelectionRange(0, 99999); // For mobile devices
            document.execCommand("copy");
            var copyBtn = document.getElementById("copy-btn");
            copyBtn.innerText = 'Copied!';
            setTimeout(function(){
                copyBtn.innerText = 'Copy';
            }, 2000);
        }
    </script>

    @if ($setting->google_tagmanager_status == 'active' && $marketing_setting?->course_details)
        <script>
            $(document).ready(function() {
                dataLayer.push({
                    'event': 'courseDetails',
                    'courses': {
                        'name': '{{ $course->title }}',
                        'price': '{{ currency($course->price) }}',
                        'instructor': '{{ $course->instructor->name }}',
                        'category': '{{ $course->category->translation->name }}',
                        'lessons': '{{ $courseLessonCount }}',
                        'duration': '{{ minutesToHours($course->duration) }}',
                        'url': "{{route('course.show',$course->slug)}}",
                    }
                });
            });
        </script>
    @endif
@endpush
