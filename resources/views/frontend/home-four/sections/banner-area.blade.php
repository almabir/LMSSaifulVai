<section class="slider__area home4_slider__area">
    <div class="swiper-container slider__active">
        <div class="swiper-wrapper">
            <div class="swiper-slide slider__single">
                <div class="slider__bg"
                    data-background="{{ manageAssetImage('uploads/homepages/business/hero_bg.jpg', $hero->hero_background) }}">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-6 col-lg-7">
                                <div class="slider__content">
                                   
                                    <h2 class="title">{!! clean(processText($hero->translation?->title)) !!}</h2>
                                    <p>{!! clean(processText($hero->translation?->sub_title)) !!}</p>
                                    <div class="slider__search">
                                        <form action="{{ route('courses') }}" class="slider__search-form">
                                            <input type="text" name="search"
                                                placeholder="{{ __('Search here') }} . . .">
                                            <button type="submit">{{ __('Find Courses') }}</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
