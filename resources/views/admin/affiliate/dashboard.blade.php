@extends('admin.master_layout')
@section('title')
    <title>{{ __('Affiliate Dashboard') }}</title>
@endsection

@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Affiliate Dashboard') }}</h1>
        </div>

        <div class="row">
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-primary">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4>{{ __('Total Affiliates') }}</h4>
                        </div>
                        <div class="card-body">
                            {{ $totalAffiliates }}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-success">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4>{{ __('Total Commission Earned') }}</h4>
                        </div>
                        <div class="card-body">
                            {{ currency($totalCommissionEarned) }}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6 col-12">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-warning">
                        <i class="fas fa-money-check-alt"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4>{{ __('Total Commission Paid') }}</h4>
                        </div>
                        <div class="card-body">
                           {{ currency($totalCommissionPaid) }}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="section-body">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>{{ __('Commission History') }}</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>{{ __('Affiliate') }}</th>
                                            <th>{{ __('Course') }}</th>
                                            <th>{{ __('Order ID') }}</th>
                                            <th>{{ __('Commission') }}</th>
                                            <th>{{ __('Date') }}</th>
                                            <th>{{ __('Status') }}</th>
                                            <th class="text-right">{{ __('Action') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @forelse($commissions as $commission)
                                        <tr>
                                            <td>{{ $commission->user->name ?? __('N/A') }}</td>
                                            <td>{{ $commission->course->title ?? __('N/A') }}</td>
                                            <td>#{{ $commission->order->invoice_id ?? __('N/A') }}</td>
                                            <td>{{ currency($commission->commission_amount) }}</td>
                                            {{-- CORRECTED: Added a null check for the date --}}
                                            <td>{{ $commission->created_at ? $commission->created_at->format('d M, Y') : __('N/A') }}</td>
                                            <td>
                                                <span class="badge badge-{{ $commission->status == 'paid' ? 'success' : ($commission->status == 'cancelled' ? 'danger' : 'warning') }}">{{ ucfirst($commission->status) }}</span>
                                            </td>
                                            <td class="text-right">
                                                @if($commission->status == 'pending')
                                                <form action="{{ route('admin.affiliate.commission.status.update', $commission->id) }}" method="POST" class="d-inline">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="paid">
                                                    <button type="submit" class="btn btn-sm btn-primary">{{ __('Mark as Paid') }}</button>
                                                </form>
                                                <form action="{{ route('admin.affiliate.commission.status.update', $commission->id) }}" method="POST" class="d-inline">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="cancelled">
                                                    <button type="submit" class="btn btn-sm btn-danger">{{ __('Cancel') }}</button>
                                                </form>
                                                @else
                                                    -
                                                @endif
                                            </td>
                                        </tr>
                                        @empty
                                        <tr>
                                            <td colspan="7" class="text-center">{{ __('No commissions found.') }}</td>
                                        </tr>
                                        @endforelse
                                    </tbody>
                                </table>
                            </div>
                            <div class="float-right">
                                {{ $commissions->links() }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
