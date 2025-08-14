@extends('admin.master_layout')
@section('title', __('Database Backups'))
@section('admin-content')
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>{{ __('Database Backups') }}</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active"><a href="{{ route('admin.dashboard') }}">{{ __('Dashboard') }}</a></div>
                    <div class="breadcrumb-item">{{ __('Database Backups') }}</div>
                </div>
            </div>

            <div class="section-body">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4>{{ __('Manage Backups') }}</h4>
                                <div class="card-header-action">
                                    <form action="{{ route('admin.database-backup.store') }}" method="POST" class="d-inline">
                                        @csrf
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-plus-circle"></i> {{ __('Create New Backup') }}
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>{{ __('File Name') }}</th>
                                                <th>{{ __('File Size') }}</th>
                                                <th>{{ __('Date Created') }}</th>
                                                <th class="text-right">{{ __('Actions') }}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @forelse($backups as $backup)
                                            <tr>
                                                <td>{{ $backup['file_name'] }}</td>
                                                <td>{{ $backup['file_size'] }}</td>
                                                <td>{{ $backup['last_modified'] }}</td>
                                                <td class="text-right">
                                                    <form action="{{ route('admin.database-backup.download') }}" method="POST" class="d-inline">
                                                        @csrf
                                                        <input type="hidden" name="file_name" value="{{ $backup['file_name'] }}">
                                                        <button type="submit" class="btn btn-sm btn-success">
                                                            <i class="fas fa-download"></i> {{ __('Download') }}
                                                        </button>
                                                    </form>
                                                    <form action="{{ route('admin.database-backup.destroy') }}" method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this backup?');">
                                                        @csrf
                                                        @method('DELETE')
                                                        <input type="hidden" name="file_name" value="{{ $backup['file_name'] }}">
                                                        <button type="submit" class="btn btn-sm btn-danger">
                                                            <i class="fas fa-trash"></i> {{ __('Delete') }}
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                            @empty
                                            <tr>
                                                <td colspan="4" class="text-center">{{ __('No backups found.') }}</td>
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
