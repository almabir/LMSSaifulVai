@extends('frontend.layouts.master-affiliate')

@section('title', __('Become an Affiliate'))
@section('meta_title', __('Become an Affiliate') . ' || ' . ($setting->app_name ?? ''))

@section('content')
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
@endsection
