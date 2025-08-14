@extends('admin.master_layout')

@section('title')
    <title>{{ __('Affiliate Withdrawals') }}</title>
@endsection
@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Affiliate Withdrawals') }}</h1>
        </div>

        <div class="section-body">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>{{ __('All Withdrawal Requests') }}</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>{{ __('Affiliate') }}</th>
                                            <th>{{ __('Amount') }}</th>
                                            <th>{{ __('Method') }}</th>
                                            <th>{{ __('Status') }}</th>
                                            <th>{{ __('Date') }}</th>
                                            <th class="text-right">{{ __('Action') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @forelse($requests as $request)
                                        <tr>
                                            <td>{{ $request->user->name ?? 'N/A' }}</td>
                                            <td>{{ currency($request->withdraw_amount) }}</td>
                                            <td>{{ $request->method }}</td>
                                            <td>
                                                <span class="badge badge-{{ $request->status == 'approved' ? 'success' : ($request->status == 'rejected' ? 'danger' : 'warning') }}">{{ ucfirst($request->status) }}</span>
                                            </td>
                                            <td>{{ $request->created_at->format('d M, Y') }}</td>
                                            <td class="text-right">
                                                <a href="{{ route('admin.affiliate.withdrawal.show', $request->id) }}" class="btn btn-sm btn-primary">{{ __('View Details') }}</a>
                                            </td>
                                        </tr>
                                        @empty
                                        <tr>
                                            <td colspan="6" class="text-center">{{ __('No withdrawal requests found.') }}</td>
                                        </tr>
                                        @endforelse
                                    </tbody>
                                </table>
                            </div>
                            <div class="float-right">
                                {{ $requests->links() }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
