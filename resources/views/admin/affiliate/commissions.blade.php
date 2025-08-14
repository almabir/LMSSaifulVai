@extends('admin.master_layout')

@section('title')
    <title>{{ __('Affiliate Commissions') }}</title>
@endsection

@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Affiliate Commissions') }}</h1>
        </div>

        <div class="section-body">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>{{ __('All Commissions') }}</h4>
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
                                            <td>{{ $commission->user->name ?? 'N/A' }}</td>
                                            <td>{{ $commission->course->title ?? 'N/A' }}</td>
                                            <td>#{{ $commission->order->invoice_id ?? 'N/A' }}</td>
                                            <td>{{ currency($commission->commission_amount) }}</td>
                                            {{-- CORRECTED: Added a null check for the date --}}
                                            <td>{{ $commission->created_at ? $commission->created_at->format('d M, Y') : __('N/A') }}</td>
                                            <td>
                                                <span class="badge badge-{{ $commission->status == 'paid' ? 'success' : ($commission->status == 'cancelled' ? 'danger' : 'warning') }}">{{ ucfirst($commission->status) }}</span>
                                            </td>
                                            <td class="text-right">
                                                @if($commission->status == 'pending')
                                                <form action="{{ route('admin.affiliate.commissions.update', $commission->id) }}" method="POST" class="d-inline">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="paid">
                                                    <button type="submit" class="btn btn-sm btn-primary">{{ __('Mark as Paid') }}</button>
                                                </form>
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
