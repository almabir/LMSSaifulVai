<div class="brand-area-three section-pb-120">
    <div class="container">
        <div class="swiper-container brand-swiper-active">
            <div class="swiper-wrapper">
                @foreach ($brands as $brand)
                    <div class="swiper-slide">
                        <div class="brand__item-two">
                            <img src="{{ asset($brand->image) }}" alt="img">
                        </div>
                    </div>
                @endforeach
            </div>
        </div>
    </div>
</div>
