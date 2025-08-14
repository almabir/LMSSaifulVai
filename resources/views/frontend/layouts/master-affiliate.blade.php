<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>{{ __('Become an Affiliate') . ' || ' . ($setting->app_name ?? '') }}</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Custom Meta -->
    @stack('custom_meta')
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="{{ asset($setting->favicon ?? '') }}">
    <!-- CSS here -->
    @include('frontend.layouts.styles')
    <!-- CustomCSS here -->
    @stack('styles')
    @if (customCode()?->css)
        <style>
            {!! customCode()->css !!}
        </style>
    @endif

    {{-- dynamic header scripts --}}
    @include('frontend.layouts.header-scripts')

    @php
        setEnrollmentIdsInSession();
        setInstructorCourseIdsInSession();
    @endphp
    
</head>

<body>
    @if (!empty($setting->google_tagmanager_status) && $setting->google_tagmanager_status == 'active')
        <!-- Google Tag Manager (noscript) -->
        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id={{ $setting->google_tagmanager_id }}"
                height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <!-- End Google Tag Manager (noscript) -->
    @endif

    @if (!empty($setting->preloader_status) && $setting->preloader_status == 1)
        <!--Preloader-->
        <div id="preloader">
            <div id="loader" class="loader">
                <div class="loader-container">
                    <div class="loader-icon"><img src="{{ asset($setting->preloader) }}" alt="Preloader">
                    </div>
                </div>
            </div>
        </div>
        <!--Preloader-end -->
    @endif

    <!-- Scroll-top -->
    <button class="scroll__top scroll-to-target" data-target="html">
        <i class="tg-flaticon-arrowhead-up"></i>
    </button>
    <!-- Scroll-top-end-->

    <!-- header-area -->
    @include('frontend.layouts.header')
    <!-- header-area-end -->

    <!-- main-area -->
    <main class="main-area fix">
        <!-- breadcrumb-area -->
        <x-frontend.breadcrumb
            :title="__('Become an Affiliate')"
            :links="[
                ['url' => route('home'), 'text' => __('Home')],
                ['url' => route('student.affiliate.apply'), 'text' => __('Become an Affiliate')],
            ]"
        />
        <!-- breadcrumb-area-end -->

        <!-- singUp-area -->
        <section class="singUp-area section-py-120">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-6 col-lg-8">
                        <div class="singUp-wrap">
                            <h2 class="title">{{ __('Become an Affiliate') }}</h2>
                            <div class="normal-text mb-3">
                               <p>
                                    {{ __('Join our affiliate program and earn a commission on every course sale you refer. Submit your application below and we will review it shortly.') }}
                               </p>
                            </div>

                            {{-- Check if the user had a previously rejected application --}}
                            @if(isset($existingRequest) && $existingRequest->status == 'rejected')
                                <div class="alert alert-warning">
                                    {{ __('Your previous application was rejected. You may resubmit your application below.') }}
                                </div>
                            @endif

                            <form method="POST" action="{{ route('student.affiliate.store') }}" class="account__form">
                                @csrf

                                <div class="form-grp">
                                    <label for="reason">{{ __('Tell us why you want to be an affiliate (Optional)') }}</label>
                                    <textarea name="reason" id="reason" class="form-control" rows="6" placeholder="Example: I have a blog/YouTube channel about web development and would like to promote your courses to my audience.">{{ old('reason') }}</textarea>
                                </div>

                                <button type="submit" class="btn btn-two arrow-btn mt-3">{{ __('Submit for Review') }}<img
                                        src="{{ asset('frontend/img/icons/right_arrow.svg') }}" alt="img"
                                        class="injectable"></button>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- singUp-area-end -->
    </main>
    <!-- main-area-end -->

    <!-- modal-area -->
    @include('frontend.partials.modal')
    @include('frontend.instructor-dashboard.course.partials.add-new-section-modal')
    <!-- modal-area -->

    <!-- footer-area -->
    @include('frontend.layouts.footer')
    <!-- footer-area-end -->


    <!-- JS here -->
    @include('frontend.layouts.scripts')

    <!-- Language Translation Variables -->
    @include('global.dynamic-js-variables')

    <!-- Page specific js -->
    @if (session('registerUser') && !empty($setting->google_tagmanager_status) && $setting->google_tagmanager_status == 'active' && !empty($marketing_setting?->register))
        @php
            $registerUser = session('registerUser');
            session()->forget('registerUser');
        @endphp
        <script>
            $(function() {
                dataLayer.push({
                    'event': 'newStudent',
                    'student_info': @json($registerUser)
                });
            });
        </script>
    @endif
    @stack('scripts')
    @if (customCode()?->javascript)
        <script>
            "use strict";
            {!! customCode()->javascript !!}
        </script>
    @endif
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
</body>

</html>
