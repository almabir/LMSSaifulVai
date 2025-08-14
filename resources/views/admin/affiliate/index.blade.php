@extends('admin.master_layout')


@section('title')
    <title>{{ __('Affiliate Requests') }}</title>
@endsection
@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Affiliate Requests') }}</h1>
        </div>

        <div class="section-body">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>{{ __('All Requests') }}</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>{{ __('User') }}</th>
                                            <th>{{ __('Reason') }}</th>
                                            <th>{{ __('Status') }}</th>
                                            <th>{{ __('Date Submitted') }}</th>
                                            <th class="text-right">{{ __('Action') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @forelse($requests as $request)
                                        <tr>
                                            <td>
                                                {{ $request->user->name }} <br>
                                                <small>{{ $request->user->email }}</small>
                                            </td>
                                            <td>{{ $request->reason ?? 'N/A' }}</td>
                                            <td>
                                                @if($request->status == 'approved')
                                                <span class="badge badge-success">{{ __('Approved') }}</span>
                                                @elseif($request->status == 'rejected')
                                                <span class="badge badge-danger">{{ __('Rejected') }}</span>
                                                @else
                                                <span class="badge badge-warning">{{ __('Pending') }}</span>
                                                @endif
                                            </td>
                                            <td>{{ $request->created_at->format('d M, Y') }}</td>
                                            <td class="text-right">
                                                @if($request->status == 'pending')
                                                <form action="{{ route('admin.affiliate-requests.update', $request->id) }}" method="POST" class="d-inline">
                                                    @csrf
                                                    @method('PUT')
                                                    <input type="hidden" name="status" value="approved">
                                                    <button type="submit" class="btn btn-sm btn-success">{{ __('Approve') }}</button>
                                                </form>
                                                <form action="{{ route('admin.affiliate-requests.update', $request->id) }}" method="POST" class="d-inline">
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
                                            <td colspan="5" class="text-center">{{ __('No requests found.') }}</td>
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
