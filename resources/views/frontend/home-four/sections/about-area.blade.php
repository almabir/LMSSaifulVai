<section class="choose__area-four tg-motion-effects section-py-140">
    <div class="container">
        <div class="row align-items-center justify-content-center">
            <div class="col-lg-6 col-md-10">
                <div class="choose__img-four">
                    <div class="left__side">
                        <img src="{{ manageAssetImage('uploads/homepages/business/about_img.jpg', $aboutSection?->image) }}" alt="img" data-aos="fade-down" data-aos-delay="200">
                        <img src="{{ asset($aboutSection?->image_two) }}" alt="img" data-aos="fade-up" data-aos-delay="200">
                    </div>
                    <div class="right__side" data-aos="fade-left" data-aos-delay="400">
                        <img src="{{ asset($aboutSection?->image_three) }}" alt="img">
                        <a href="{{$aboutSection?->video_url}}" class="popup-video"><i class="fas fa-play"></i></a>
                    </div>
                    <img src="{{ asset('frontend/img/others/h7_choose_shape01.svg') }}" alt="shape" class="shape shape-one tg-motion-effects4">
                    <img src="{{ asset('frontend/img/others/h7_choose_shape02.svg') }}" alt="shape" class="shape shape-two alltuchtopdown">
                    <img src="{{ asset('frontend/img/others/h7_choose_shape03.svg') }}" alt="shape" class="shape shape-three tg-motion-effects7">
                </div>
            </div>
            <div class="col-lg-6">
                <div class="choose__content-four">
                    <div class="section__title mb-20">
                        <span class="sub-title">{{ __('Why Choose Us') }}</span>
                        <h2 class="title bold">{!! clean(processText($aboutSection->translation?->title)) !!}</h2>
                    </div>
                    {!! clean(processText($aboutSection->translation?->description)) !!}
                    <a href="{{ $aboutSection?->button_url }}" class="btn arrow-btn btn-four">{{ $aboutSection->translation?->button_text }} <img src="{{ asset('frontend/img/icons/right_arrow.svg') }}" alt="" class="injectable"></a>
                </div>
            </div>
        </div>
    </div>
</section>