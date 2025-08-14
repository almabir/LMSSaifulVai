@extends('admin.master_layout')

@section('title')
    <title>{{ __('Withdrawal Request Details') }}</title>
@endsection
@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Request Details') }}</h1>
        </div>

        <div class="section-body">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>{{ __('Request from') }}: {{ $request->user->name }}</h4>
                        </div>
                        <div class="card-body">
                           <div class="row">
                               <div class="col-md-6">
                                   <p><strong>{{ __('Amount') }}:</strong> {{ currency($request->withdraw_amount) }}</p>
                                   <p><strong>{{ __('Method') }}:</strong> {{ $request->method }}</p>
                                   <p><strong>{{ __('Current Status') }}:</strong> <span class="badge badge-{{ $request->status == 'approved' ? 'success' : ($request->status == 'rejected' ? 'danger' : 'warning') }}">{{ ucfirst($request->status) }}</span></p>
                                   <p><strong>{{ __('Request Date') }}:</strong> {{ $request->created_at->format('d M, Y, h:i A') }}</p>
                                   @if($request->approved_date)
                                   <p><strong>{{ __('Processed Date') }}:</strong> {{ \Carbon\Carbon::parse($request->approved_date)->format('d M, Y, h:i A') }}</p>
                                   @endif
                               </div>
                               <div class="col-md-6">
                                   <h5>{{ __('Account Information') }}</h5>
                                   <pre>{{ $request->account_info }}</pre>
                               </div>
                           </div>

                           @if($request->status == 'pending')
                           <hr>
                           <h5>{{ __('Process Request') }}</h5>
                           <div class="mt-3">
                                <form action="{{ route('admin.affiliate.withdrawal.update', $request->id) }}" method="POST" class="d-inline">
                                    @csrf
                                    @method('PUT')
                                    <input type="hidden" name="status" value="approved">
                                    <button type="submit" class="btn btn-success">{{ __('Approve Request') }}</button>
                                </form>
                                <form action="{{ route('admin.affiliate.withdrawal.update', $request->id) }}" method="POST" class="d-inline">
                                    @csrf
                                    @method('PUT')
                                    <input type="hidden" name="status" value="rejected">
                                    <button type="submit" class="btn btn-danger">{{ __('Reject Request') }}</button>
                                </form>
                           </div>
                           @endif
                        </div>
                        <div class="card-footer text-right">
                             <a href="{{ route('admin.affiliate.withdrawal.index') }}" class="btn btn-secondary">{{ __('Back to List') }}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
