<section class="about-area-four section-pb-120">
    <div class="container">
        <div class="row align-items-center justify-content-center">
            <div class="col-lg-5 col-md-9">
                <div class="about__images-four">
                    <img src="{{ manageAssetImage('uploads/homepages/university/about_img.jpg', $aboutSection?->image) }}"
                        alt="">
                    @if ($hero?->translation?->total_student)
                        <div class="about__enrolled" data-aos="fade-up" data-aos-delay="400">
                            <p class="title"><span>{{ $hero->translation?->total_student }}</span>
                                {{ __('Enrolled Students') }}</p>
                            <img src="{{ asset($hero->enroll_students_image) }}" alt="img">
                        </div>
                    @endif
                    @if ($aboutSection?->video_url)
                        <div class="about__video" data-aos="fade-left" data-aos-delay="400">
                            <a href="{{ $aboutSection?->video_url }}" class="play-btn popup-video"><i
                                    class="fas fa-play"></i> {{ __('Watch our') }} <br> {{ __('Video') }}</a>
                        </div>
                    @endif
                    @if ($aboutSection?->year_experience)
                        <div class="about__year-wrap">
                            <h2 class="count">{{ $aboutSection?->year_experience }}</h2>
                            <h5 class="title">{{ __('year') }} <br> {{ __('of Institutes') }}</h5>
                        </div>
                    @endif
                    <div class="shape">
                        <img src="{{ asset('frontend/img/others/h3_about_shape01.svg') }}" alt="shape"
                            data-aos="fade-right" data-aos-delay="200" class="alltuchtopdown">
                        <img src="{{ asset('frontend/img/others/h3_about_shape02.svg') }}" alt="shape"
                            data-aos="fade-right" data-aos-delay="200">
                    </div>
                </div>
            </div>
            <div class="col-lg-7">
                <div class="about__content-four">
                    <div class="section__title mb-15">
                        <span class="sub-title">{{ __('About Campus history') }}</span>
                        <h2 class="title">{!! clean(processText($aboutSection?->translation?->title)) !!}</h2>
                    </div>
                    {!! clean(processText($aboutSection?->translation?->description)) !!}
                    <a href="{{ $aboutSection?->button_url }}"
                        class="btn arrow-btn">{{ $aboutSection?->translation?->button_text }} <img
                            src="{{ asset('frontend/img/icons/right_arrow.svg') }}" alt=""
                            class="injectable"></a>
                    <img src="{{ asset('frontend/img/others/h3_about_shape03.svg') }}" alt="shape"
                        class="shape alltuchtopdown">
                </div>
            </div>
        </div>
    </div>
</section>
