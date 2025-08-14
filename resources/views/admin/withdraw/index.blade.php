@extends('admin.master_layout')

@section('title')
    <title>{{ __('Withdrawal Requests') }}</title>
@endsection
@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Withdrawal Requests') }}</h1>
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
                                            <th>{{ __('User') }}</th>
                                            <th>{{ __('Amount') }}</th>
                                            <th>{{ __('Method') }}</th>
                                            <th>{{ __('Account Details') }}</th>
                                            <th>{{ __('Date') }}</th>
                                            <th>{{ __('Status') }}</th>
                                            <th class="text-right">{{ __('Action') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @forelse($requests as $request)
                                        <tr>
                                            <td>
                                                {{ $request->user->name ?? 'N/A' }} <br>
                                                <small>{{ $request->user->email ?? 'N/A' }}</small>
                                            </td>
                                            <td>{{ currency($request->withdraw_amount) }}</td>
                                            <td>{{ $request->method }}</td>
                                            <td><textarea class="form-control" rows="3" readonly>{{ $request->account_info }}</textarea></td>
                                            <td>{{ $request->created_at->format('d M, Y') }}</td>
                                            <td>
                                                @if($request->status == 'approved')
                                                <span class="badge badge-success">{{ __('Approved') }}</span>
                                                @elseif($request->status == 'rejected')
                                                <span class="badge badge-danger">{{ __('Rejected') }}</span>
                                                @else
                                                <span class="badge badge-warning">{{ __('Pending') }}</span>
                                                @endif
                                            </td>
                                            <td class="text-right">
                                                @if($request->status == 'pending')
                                                <form action="{{ route('admin.withdrawal.update', $request->id) }}" method="POST" class="d-inline">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="approved">
                                                    <button type="submit" class="btn btn-sm btn-success">{{ __('Approve') }}</button>
                                                </form>
                                                <form action="{{ route('admin.withdrawal.update', $request->id) }}" method="POST" class="d-inline">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="rejected">
                                                    <button type="submit" class="btn btn-sm btn-danger">{{ __('Reject') }}</button>
                                                </form>
                                                @else
                                                    -
                                                @endif
                                            </td>
                                        </tr>
                                        @empty
                                        <tr>
                                            <td colspan="7" class="text-center">{{ __('No withdrawal requests found.') }}</td>
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
