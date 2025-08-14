<section class="banner-area banner-bg-three tg-motion-effects"
    data-background="{{ manageAssetImage('uploads/homepages/university/hero_bg.jpg', $hero->hero_background) }}">
    <div class="container">
        <div class="row justify-content-between align-items-start">
            <div class="col-xl-5 col-lg-6">
                <div class="banner__content-three">
                    <span class="sub-title" data-aos="fade-right"
                        data-aos-delay="200">{{__('For a better future')}}</span>
                    <h2 class="title" data-aos="fade-right" data-aos-delay="400">{!! clean(processText($hero->translation?->title)) !!}</h2>
                    <p data-aos="fade-right" data-aos-delay="600">{!! clean(processText($hero->translation?->sub_title)) !!}</p>
                    @if ($hero->translation?->action_button_text != null)
                        <div class="banner__btn-wrap" data-aos="fade-right" data-aos-delay="800">
                            <a href="{{ $hero->action_button_url }}"
                                class="btn arrow-btn">{{ $hero->translation?->action_button_text }} <img
                                    src="{{ asset('frontend/img/icons/right_arrow.svg') }}" alt="img"
                                    class="injectable"></a>
                    @endif
                </div>
                <div class="shape">
                    <img src="{{ asset('frontend/img/banner/h3_hero_shape01.svg') }}" alt="shape"
                        data-aos="fade-right" data-aos-delay="1000">
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="banner__images-three">
                <img src="{{ manageAssetImage('uploads/homepages/university/banner_img.png', $hero->banner_image) }}" alt="img" class="main-img">
                <div class="shape big-shape" data-aos="fade-up" data-aos-delay="800">
                    <img src="{{ manageAssetImage('uploads/homepages/university/banner_bg.svg', $hero->banner_background) }}" alt="shape" class="tg-motion-effects1">
                </div>
                <div class="shape__wrap">
                    <img src="{{ asset('frontend/img/banner/h3_hero_shape02.svg') }}" alt="shape"
                        data-aos="fade-down-right" data-aos-delay="400">
                    <img src="{{ asset('frontend/img/banner/h3_hero_shape03.svg') }}" alt="shape"
                        data-aos="fade-down-left" data-aos-delay="400">
                </div>
                <div class="about__enrolled" data-aos="fade-right" data-aos-delay="900">
                    <p class="title"><span>{{ $hero->translation?->total_student }}</span>
                        {{ __('Enrolled Students') }}</p>
                    <img src="{{ asset($hero->enroll_students_image) }}" alt="img">
                </div>
            </div>
        </div>
    </div>
</section>
