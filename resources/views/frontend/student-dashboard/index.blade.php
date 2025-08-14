@extends('frontend.student-dashboard.layouts.master')

@section('dashboard-contents')
    {{-- Instructor Status Alerts --}}
    @if (instructorStatus() == 'pending')
        <div class="alert alert-primary d-flex align-items-center" role="alert">
             <i class="fas fa-info-circle flex-shrink-0 me-2"></i>
            <div>
                {{ __('We received your request to become instructor') }}. {{ __('Please wait for admin approval') }}!
            </div>
        </div>
    @elseif (instructorStatus() == 'rejected')
        <div class="alert alert-danger d-flex align-items-center" role="alert">
            <i class="fas fa-times-circle flex-shrink-0 me-2"></i>
            <div>
                {{ __('Your request to become instructor has been rejected. Please resubmit your request with valid information') }}
                <a href="{{ route('become-instructor') }}">{{ __('here') }}</a>
            </div>
        </div>
    @endif

    {{-- Affiliate Status Alerts --}}
    @php
        $affiliateRequest = \App\Models\AffiliateRequest::where('user_id', auth()->id())->first();
    @endphp

    @if($affiliateRequest && $affiliateRequest->status == 'pending')
        <div class="alert alert-info d-flex align-items-center" role="alert">
            <i class="fas fa-info-circle flex-shrink-0 me-2"></i>
            <div>
                {{ __('Your affiliate application is under review. You will be notified once it has been processed.') }}
            </div>
        </div>
    @elseif($affiliateRequest && $affiliateRequest->status == 'rejected')
        <div class="alert alert-danger d-flex align-items-center" role="alert">
            <i class="fas fa-times-circle flex-shrink-0 me-2"></i>
            <div>
                {{ __('Your affiliate application has been rejected.') }}
                <a href="{{ route('student.affiliate.apply') }}">{{ __('Resubmit your application') }}</a>.
            </div>
        </div>
    @endif
    
    <div class="dashboard__content-wrap dashboard__content-wrap-two mb-60">
        <div class="dashboard__content-title">
            <h4 class="title">{{ __('Dashboard') }}</h4>
        </div>

        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="dashboard__counter-item">
                    <div class="icon">
                        <i class="flaticon-mortarboard"></i>
                    </div>
                    <div class="content">
                        <span class="count odometer" data-count="{{ $totalEnrolledCourses }}"></span>
                        <p>{{ __('ENROLLED COURSES') }}</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="dashboard__counter-item">
                    <div class="icon">
                        <i class="flaticon-mortarboard"></i>
                    </div>
                    <div class="content">
                        <span class="count odometer" data-count="{{ $totalQuizAttempts }}"></span>
                        <p>{{ __('QUIZ ATTEMPTS') }}</p>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-4 col-sm-6">
                <div class="dashboard__counter-item">
                    <div class="icon">
                        <i class="flaticon-mortarboard"></i>
                    </div>
                    <div class="content">
                        <span class="count odometer" data-count="{{ $totalReviews }}"></span>
                        <p>{{ __('YOUR TOTAL REVIEWS') }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    {{-- Affiliate Information Section --}}
    @if(auth()->user()->is_affiliate)
    <div class="dashboard__content-wrap dashboard__content-wrap-two mb-60">
        <div class="dashboard__content-title">
            <h4 class="title">{{ __('Affiliate Dashboard') }}</h4>
        </div>
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="dashboard__counter-item">
                    <div class="icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="content">
                        <span class="count odometer" data-count="{{ $affiliateData['total_sales'] }}"></span>
                        <p>{{ __('TOTAL REFERRED SALES') }}</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="dashboard__counter-item">
                    <div class="icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="content">
                        <span class="count odometer" data-count="{{ $affiliateData['total_commission'] }}"></span>
                        <p>{{ __('TOTAL COMMISSION') }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="dashboard__content-wrap  mb-60">
        <div class="dashboard__content-title">
            <h4 class="title">{{ __('Recent Commission History') }}</h4>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="dashboard__review-table table-responsive">
                    <table class="table table-borderless">
                        <thead>
                            <tr>
                                <th>{{ __('Course') }}</th>
                                <th>{{ __('Commission') }}</th>
                                <th>{{ __('Date') }}</th>
                                <th>{{ __('Status') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($affiliateData['recent_commissions'] as $commission)
                                <tr>
                                    <td>{{ $commission->course->title ?? __('N/A') }}</td>
                                    <td>{{ session('currency_icon') ?? '$' }}{{ number_format($commission->commission_amount, 2) }}</td>
                                    {{-- CORRECTED: Added a check to prevent error on null date --}}
                                    <td>{{ $commission->created_at ? $commission->created_at->format('d M, Y') : __('N/A') }}</td>
                                    <td><span class="badge bg-{{ $commission->status == 'paid' ? 'success' : 'warning' }}">{{ ucfirst($commission->status) }}</span></td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="text-center">{{ __('No commissions yet.') }}</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    @endif
    {{-- End Affiliate Section --}}

    <div class="dashboard__content-wrap">
        <div class="dashboard__content-title">
            <h4 class="title">{{ __('Order History') }}</h4>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="dashboard__review-table table-responsive">
                    <table class="table table-borderless">
                        <thead>
                            <tr>
                                <th>{{ __('No') }}</th>
                                <th>{{ __('Invoice') }}</th>
                                <th>{{ __('Paid') }}</th>
                                <th>{{ __('Gateway') }}</th>
                                <th>{{ __('Status') }}</th>
                                <th>{{ __('Payment') }}</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse ($orders as $index => $order)
                                <tr>
                                    <td>{{ ++$index }}</td>
                                    <td>#{{ $order->invoice_id }}</td>
                                    <td>{{ $order->paid_amount }} {{ $order->payable_currency }}</td>
                                    <td>
                                        {{ $order->payment_method }}
                                    </td>
                                    <td>
                                        @if ($order->status == 'completed')
                                            <div class="badge bg-success">{{ __('Completed') }}</div>
                                        @elseif($order->status == 'processing')
                                            <div class="badge bg-warning">{{ __('Processing') }}</div>
                                        @elseif($order->status == 'declined')
                                            <div class="badge bg-danger">{{ __('Declined') }}</div>
                                        @else
                                            <div class="badge bg-warning">{{ __('Pending') }}</div>
                                        @endif
                                    </td>

                                    <td>
                                        @if ($order->payment_status == 'paid')
                                            <div class="badge bg-success">{{ __('Paid') }}</div>
                                        @elseif ($order->payment_status == 'cancelled')
                                            <div class="badge bg-danger">{{ __('Cancelled') }}</div>
                                        @else
                                            <div class="badge bg-danger">{{ __('Pending') }}</div>
                                        @endif
                                    </td>

                                    <td>
                                        <a href="{{ route('student.order.show', $order->id) }}" class=""><i
                                                class="fa fa-eye"></i></a>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="10" class="text-center">{{ __('No orders found!') }}</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
@endsection
