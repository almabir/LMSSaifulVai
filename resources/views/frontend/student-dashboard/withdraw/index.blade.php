@extends('frontend.student-dashboard.layouts.master')

@section('title', __('Affiliate Withdrawals'))

@section('dashboard-contents')
    <div class="dashboard__content-wrap">
        <div class="dashboard__content-title">
            <h4 class="title">{{ __('Affiliate Funds & Withdrawal') }}</h4>
        </div>

        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-primary">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4>{{ __('Available in Wallet') }}</h4>
                        </div>
                        <div class="card-body">
                            {{ currency($current_balance)}}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-success">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4>{{ __('Total Approved Commission') }}</h4>
                        </div>
                        <div class="card-body">
                            {{ currency($total_earned) }}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-info">
                        <i class="fas fa-hourglass-half"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4>{{ __('Pending Commission') }}</h4>
                        </div>
                        <div class="card-body">
                            {{ currency($pending_commission) }}
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-lg-3 col-md-6">
                <div class="card card-statistic-1">
                    <div class="card-icon bg-warning">
                        <i class="fas fa-money-check-alt"></i>
                    </div>
                    <div class="card-wrap">
                        <div class="card-header">
                            <h4>{{ __('Total Withdrawn') }}</h4>
                        </div>
                        <div class="card-body">
                            {{ currency($total_withdrawn) }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="dashboard__content-wrap mt-4">
        <div class="dashboard__content-title">
            <h5 class="title">{{ __('Request a Withdrawal from Wallet') }}</h5>
        </div>
        <div class="card">
            <div class="card-body">
                <form action="{{ route('student.withdraw.store') }}" method="POST">
                    @csrf
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="method_id">{{ __('Withdrawal Method') }} <span class="text-danger">*</span></label>
                                <select name="method_id" id="method_id" class="form-control" required>
                                    <option value="">{{ __('Select a method') }}</option>
                                    @foreach($methods as $method)
                                        <option value="{{ $method->id }}" data-min="{{ $method->min_amount }}" data-max="{{ $method->max_amount }}">{{ $method->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="amount">{{ __('Amount') }} <span class="text-danger">*</span></label>
                                <input type="number" name="amount" id="amount" class="form-control" step="0.01" required>
                                <small class="form-text text-muted" id="amount-range-helper"></small>
                            </div>
                        </div>
                    </div>
                    <div class="form-group mt-3">
                        <label for="account_info">{{ __('Account Information') }} <span class="text-danger">*</span></label>
                        <textarea name="account_info" id="account_info" class="form-control" rows="5" placeholder="Provide your account details (e.g., PayPal email, Bank Account Number, etc.)" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary mt-3">{{ __('Submit Request') }}</button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="dashboard__content-wrap mt-4">
        <div class="dashboard__content-title">
            <h5 class="title">{{ __('Withdrawal History') }}</h5>
        </div>
        <div class="dashboard__review-table table-responsive">
            <table class="table table-borderless">
                <thead>
                    <tr>
                        <th>{{ __('Amount') }}</th>
                        <th>{{ __('Method') }}</th>
                        <th>{{ __('Date') }}</th>
                        <th>{{ __('Status') }}</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($requests as $request)
                        <tr>
                            <td>{{ currency($request->withdraw_amount) }}</td>
                            <td>{{ $request->method }}</td>
                            <td>{{ $request->created_at->format('d M, Y') }}</td>
                            <td>
                                <span class="badge badge-{{ $request->status == 'approved' ? 'success' : ($request->status == 'rejected' ? 'danger' : 'warning') }}" style="color:black;">{{ ucfirst($request->status) }}</span>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center">{{ __('No withdrawal requests found.') }}</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
            <div class="float-right">
                {{ $requests->links() }}
            </div>
        </div>
    </div>
@endsection

@push('scripts')
<script>
    document.getElementById('method_id').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        const min = selectedOption.getAttribute('data-min');
        const max = selectedOption.getAttribute('data-max');
        const amountInput = document.getElementById('amount');
        const helperText = document.getElementById('amount-range-helper');

        if (min && max) {
            amountInput.min = min;
            amountInput.max = max;
            helperText.textContent = `Amount must be between ${min} and ${max}.`;
        } else {
            amountInput.removeAttribute('min');
            amountInput.removeAttribute('max');
            helperText.textContent = '';
        }
    });
</script>
@endpush
