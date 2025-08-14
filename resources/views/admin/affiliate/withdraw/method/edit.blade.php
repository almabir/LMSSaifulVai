@extends('admin.master_layout')
@section('title')
    <title>{{ __('Edit Withdrawal Method') }}</title>
@endsection
@section('admin-content')
<div class="main-content">
    <section class="section">
        <div class="section-header">
            <h1>{{ __('Edit Withdrawal Method') }}</h1>
        </div>
        <div class="section-body">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4>{{ __('Edit Method Form') }}</h4>
                        </div>
                        <div class="card-body">
                            <form action="{{ route('admin.affiliate-withdraw-methods.update', $method->id) }}" method="POST">
                                @csrf
                                @method('PUT')
                                <div class="form-group">
                                    <label for="name">{{ __('Method Name') }}</label>
                                    <input type="text" name="name" id="name" class="form-control" value="{{ $method->name }}" required>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="min_amount">{{ __('Minimum Amount') }}</label>
                                            <input type="number" name="min_amount" id="min_amount" class="form-control" value="{{ $method->min_amount }}" step="0.01" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="max_amount">{{ __('Maximum Amount') }}</label>
                                            <input type="number" name="max_amount" id="max_amount" class="form-control" value="{{ $method->max_amount }}" step="0.01" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="description">{{ __('Description / Instructions') }}</label>
                                    <textarea name="description" id="description" class="form-control" rows="5" required>{{ $method->description }}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="status">{{ __('Status') }}</label>
                                    <select name="status" id="status" class="form-control">
                                        <option value="active" @selected($method->status == 'active')>{{ __('Active') }}</option>
                                        <option value="inactive" @selected($method->status == 'inactive')>{{ __('Inactive') }}</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary">{{ __('Update Method') }}</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
@endsection
