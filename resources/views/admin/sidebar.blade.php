<div class="main-sidebar">
    <aside id="sidebar-wrapper">
        <div class="sidebar-brand">
            <a href="{{ route('admin.dashboard') }}"><img class="admin_logo" src="{{ asset($setting->logo) ?? '' }}"
                    alt="{{ $setting->app_name ?? '' }}"></a>
        </div>

        <div class="sidebar-brand sidebar-brand-sm">
            <a href="{{ route('admin.dashboard') }}"><img src="{{ asset($setting->favicon) ?? '' }}"
                    alt="{{ $setting->app_name ?? '' }}"></a>
        </div>

        <ul class="sidebar-menu">
            @if(checkAdminHasPermission('dashboard.view'))
                <li class="{{ request()->is('admin/dashboard') ? 'active' : '' }}">
                    <a class="nav-link" href="{{ route('admin.dashboard') }}"><i class="fas fa-home"></i>
                        <span>{{ __('Dashboard') }}</span>
                    </a>
                </li>
            @endif

            @if(checkAdminHasPermission('course.management') || checkAdminHasPermission('course.certificate.management') || checkAdminHasPermission('badge.management') || checkAdminHasPermission('blog.view'))
                <li class="menu-header">{{ __('Manage Contents') }}</li>

                @if (Module::isEnabled('Course') && checkAdminHasPermission('course.management'))
                    @include('course::sidebar')
                @endif

                @if (Module::isEnabled('CertificateBuilder') && checkAdminHasPermission('course.certificate.management'))
                    @include('certificatebuilder::sidebar')
                @endif

                @if (Module::isEnabled('Badges') && checkAdminHasPermission('badge.management'))
                    @include('badges::sidebar')
                @endif

                @if (Module::isEnabled('Blog'))
                    @include('blog::sidebar')
                @endif
            @endif

            @if(checkAdminHasPermission('order.management') || checkAdminHasPermission('coupon.management') || checkAdminHasPermission('withdraw.management'))
                <li class="menu-header">{{ __('Manage Orders') }}</li>

                @if (Module::isEnabled('Order') && checkAdminHasPermission('order.management'))
                    @include('order::sidebar')
                @endif

                @if (Module::isEnabled('Coupon') && checkAdminHasPermission('coupon.management'))
                    @include('coupon::sidebar')
                @endif

                @if (Module::isEnabled('PaymentWithdraw') && checkAdminHasPermission('withdraw.management'))
                    @include('paymentwithdraw::admin.sidebar')
                @endif
            @endif

            @if(checkAdminHasPermission('instructor.request.list') || checkAdminHasPermission('customer.view') || checkAdminHasPermission('location.view'))
                <li class="menu-header">{{ __('Manage Users') }}</li>
                @if (
                    (Module::isEnabled('InstructorRequest') && checkAdminHasPermission('instructor.request.list')) ||
                        checkAdminHasPermission('instructor.request.setting'))
                    @include('instructorrequest::sidebar')
                @endif

                @if (Module::isEnabled('Customer') && checkAdminHasPermission('customer.view'))
                    @include('customer::sidebar')
                @endif

                @if (Module::isEnabled('Location') && checkAdminHasPermission('location.view'))
                    @include('location::sidebar')
                @endif
            @endif

            @if(checkAdminHasPermission('appearance.management') || checkAdminHasPermission('section.management') || checkAdminHasPermission('footer.management') || checkAdminHasPermission('brand.managemen'))
                <li class="menu-header">{{ __('Site Contents') }}</li>
                @if (Module::isEnabled('SiteAppearance') && checkAdminHasPermission('appearance.management'))
                    @include('siteappearance::sidebar')
                @endif

                @if (Module::isEnabled('Frontend') && checkAdminHasPermission('section.management'))
                    @include('frontend::sidebar')
                @endif

                @if (Module::isEnabled('Brand') && checkAdminHasPermission('brand.management'))
                    @include('brand::sidebar')
                @endif

                @if (Module::isEnabled('FooterSetting') && checkAdminHasPermission('footer.management'))
                    @include('footersetting::sidebar')
                @endif
            @endif


            @if(checkAdminHasPermission('menu.view') || checkAdminHasPermission('page.management') || checkAdminHasPermission('social.link.management') || checkAdminHasPermission('faq.view'))
                <li class="menu-header">{{ __('Manage Website') }}</li>

                @if (Module::isEnabled('MenuBuilder') && checkAdminHasPermission('menu.view'))
                    @include('menubuilder::sidebar')
                @endif
                
                @if (Module::isEnabled('PageBuilder') && checkAdminHasPermission('page.management'))
                    @include('pagebuilder::sidebar')
                @endif

                @if (Module::isEnabled('SocialLink') && checkAdminHasPermission('social.link.management'))
                    @include('sociallink::sidebar')
                @endif

                @if (Module::isEnabled('Faq') && checkAdminHasPermission('faq.view'))
                    @include('faq::sidebar')
                @endif
            @endif

            @if(checkAdminHasPermission('setting.view') || checkAdminHasPermission('basic.payment.view') || checkAdminHasPermission('payment.view') || checkAdminHasPermission('currency.view') || checkAdminHasPermission('role.view') || checkAdminHasPermission('admin.view'))
                <li class="menu-header">{{ __('Settings') }}</li>
                <li class="{{ request()->is('admin/settings*') ? 'active' : '' }}">
                    <a class="nav-link" href="{{ route('admin.settings') }}"><i class="fas fa-cog"></i>
                        <span>{{ __('Settings') }}</span>
                    </a>
                </li>
            @endif

            @if(checkAdminHasPermission('newsletter.view') || checkAdminHasPermission('testimonial.view') || checkAdminHasPermission('contect.message.view'))
                <li class="menu-header">{{ __('Utility') }}</li>

                @if (Module::isEnabled('NewsLetter') && checkAdminHasPermission('newsletter.view'))
                    @include('newsletter::sidebar')
                @endif

                @if (Module::isEnabled('Testimonial') && checkAdminHasPermission('testimonial.view'))
                    @include('testimonial::sidebar')
                @endif

                @if (Module::isEnabled('ContactMessage') && checkAdminHasPermission('contect.message.view'))
                    @include('contactmessage::sidebar')
                @endif
            @endif
            
                         
            @if(checkAdminHasPermission('database.backup.management'))
                <li class="menu-header">{{ __('System') }}</li>
                <li class="{{ request()->is('admin/database-backups*') ? 'active' : '' }}">
                    {{-- CORRECTED: The route name now matches the route definition --}}
                    <a href="{{ route('admin.database-backup.index') }}" class="nav-link">
                        <i class="fas fa-database"></i>
                        <span>{{ __('Database Backups') }}</span>
                    </a>
                </li>
            @endif

            {{-- This snippet should be added to your admin sidebar view --}}

            @if(checkAdminHasPermission('affiliate.requests.view') || checkAdminHasPermission('affiliate.dashboard.view'))
                <li class="menu-header">{{ __('Affiliate System') }}</li>
            @endif

            @if(checkAdminHasPermission('affiliate.requests.view'))
                <li class="{{ request()->is('admin/affiliate-requests*') ? 'active' : '' }}">
                    <a href="{{ route('admin.affiliate-requests.index') }}" class="nav-link">
                        <i class="fas fa-user-plus"></i>
                        <span>{{ __('Affiliate Requests') }}</span>
                    </a>
                </li>
            @endif

            @if(checkAdminHasPermission('affiliate.dashboard.view'))
                <li class="{{ request()->is('admin/affiliate-dashboard*') ? 'active' : '' }}">
                    <a href="{{ route('admin.affiliate.dashboard') }}" class="nav-link">
                        <i class="fas fa-chart-line"></i>
                        <span>{{ __('Affiliate Dashboard') }}</span>
                    </a>
                </li>
            @endif


        @if(checkAdminHasPermission('affiliate.withdrawal.view'))
                    {{-- This is the existing menu header --}}
                    <li class="menu-header">{{ __('Affiliate Withdrawal') }}</li> 

        {{-- ADD THIS NEW LINK for the requests page --}}
            @if(checkAdminHasPermission('affiliate.withdrawal.view'))
                <li class="{{ request()->is('admin/affiliate/withdrawal-requests*') ? 'active' : '' }}">
                    <a href="{{ route('admin.affiliate.withdrawal.index') }}" class="nav-link">
                        <i class="fas fa-money-bill-wave"></i>
                        <span>{{ __('Affiliate Withdrawal Requests') }}</span>
                    </a>
                </li>
            @endif
            
        @endif

        @if(checkAdminHasPermission('affiliate-withdraw-methods.index'))
            <li class="{{ request()->is('admin.affiliate-withdraw-methods*') ? 'active' : '' }}">
                <a href="{{ route('admin.affiliate-withdraw-methods.index') }}" class="nav-link">
                    <i class="fas fa-credit-card"></i>
                    <span>{{ __('Withdrawal Methods') }}</span>
                </a>
            </li>
        @endif

        </ul>
    </aside>
</div>
