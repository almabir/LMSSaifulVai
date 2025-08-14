@extends('admin.master_layout')

@section('title')
    <title>{{ __('Withdrawal Methods') }}</title>
@endsection
@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Withdrawal Methods') }}</h1>
        </div>
        <div class="section-body">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>{{ __('All Methods') }}</h4>
                            <div class="card-header-action">
                                <a href="{{ route('admin.affiliate-withdraw-methods.create') }}" class="btn btn-primary">{{ __('Add New Method') }}</a>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>{{ __('Name') }}</th>
                                            <th>{{ __('Min Amount') }}</th>
                                            <th>{{ __('Max Amount') }}</th>
                                            <th>{{ __('Status') }}</th>
                                            <th class="text-right">{{ __('Action') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @forelse($methods as $method)
                                        <tr>
                                            <td>{{ $method->name }}</td>
                                            <td>{{ currency($method->min_amount) }}</td>
                                            <td>{{ currency($method->max_amount) }}</td>
                                            <td>
                                                @if($method->status == 'active')
                                                <span class="badge badge-success">{{ __('Active') }}</span>
                                                @else
                                                <span class="badge badge-danger">{{ __('Inactive') }}</span>
                                                @endif
                                            </td>
                                            <td class="text-right">
                                                <a href="{{ route('admin.affiliate-withdraw-methods.edit', $method->id) }}" class="btn btn-sm btn-primary">{{ __('Edit') }}</a>
                                                <form action="{{ route('admin.affiliate-withdraw-methods.destroy', $method->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this item?');">
                                                    @csrf
                                                    @method('DELETE')
                                                    <button type="submit" class="btn btn-sm btn-danger">{{ __('Delete') }}</button>
                                                </form>
                                            </td>
                                        </tr>
                                        @empty
                                        <tr>
                                            <td colspan="5" class="text-center">{{ __('No methods found.') }}</td>
                                        </tr>
                                        @endforelse
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
