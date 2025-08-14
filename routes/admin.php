<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\RolesController;
use App\Http\Controllers\Admin\SettingController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Global\CloudStorageController;
use App\Http\Controllers\Admin\Auth\NewPasswordController;
use App\Http\Controllers\Admin\Auth\PasswordResetLinkController;
use App\Http\Controllers\Admin\Auth\AuthenticatedSessionController;
use App\Http\Controllers\Admin\ProfileController as AdminProfileController;
use App\Http\Controllers\Admin\DatabaseBackupController;
use App\Http\Controllers\Admin\AffiliateRequestController;
use App\Http\Controllers\Admin\AffiliateController;
use App\Http\Controllers\Admin\AffiliateCommissionController;
use App\Http\Controllers\Admin\WithdrawalController;
use App\Http\Controllers\Admin\AffiliateWithdrawalController;
use App\Http\Controllers\Admin\AffiliateWithdrawMethodController;

Route::group(['as' => 'admin.', 'prefix' => 'admin', 'middleware' => ['auth:admin']], function () {

    // ... your other admin routes ...

    // // Affiliate Withdrawal Management
    // Route::group(['as' => 'affiliate.withdrawal.', 'prefix' => 'affiliate-withdrawals', 'middleware' => ['can:affiliate.withdrawal.view']], function () {
    //     Route::get('/', [AffiliateWithdrawalController::class, 'index'])->name('index');
    //     Route::get('/{id}', [AffiliateWithdrawalController::class, 'show'])->name('show');
    //     Route::put('/{id}/update', [AffiliateWithdrawalController::class, 'update'])->name('update')->middleware('can:affiliate.withdrawal.update');
    // });
    // Affiliate Withdrawal Management
    Route::group(['as' => 'affiliate.withdrawal.', 'prefix' => 'affiliate-withdrawals'], function () {
        Route::get('/', [AffiliateWithdrawalController::class, 'index'])->name('index');
        Route::get('/{id}', [AffiliateWithdrawalController::class, 'show'])->name('show');
        Route::put('/{id}/update', [AffiliateWithdrawalController::class, 'update'])->name('update');
    });
});

Route::group(['as' => 'admin.', 'prefix' => 'admin', 'middleware' => ['auth:admin']], function () {
    
    // ... your other admin routes ...
    
    // Affiliate Withdrawal Method Management
    // CORRECTED: Simplified the resource route definition.
    Route::resource('affiliate-withdraw-methods', AffiliateWithdrawMethodController::class);

});

Route::group(['as' => 'student.', 'prefix' => 'student', 'middleware' => ['auth:student']], function () {

    // ... your other admin routes ...

    // Withdrawal Management
    // A permission group will be added later for this
    Route::get('affiliate/withdrawal-requests', [WithdrawalController::class, 'index'])->name('affiliate.withdrawal.index');
    Route::put('affiliate/withdrawal-requests/{id}/update', [WithdrawalController::class, 'update'])->name('affiliate.withdrawal.update');

});
// You should place this within a group that has the admin prefix and middleware
Route::group(['as' => 'admin.', 'prefix' => 'admin', 'middleware' => ['auth:admin']], function () {

    // ... your other admin routes ...
    // Affiliate Dashboard & Management
    // Route::group(['middleware' => ['can:affiliate.dashboard.view']], function () {
        Route::get('affiliate-dashboard', [AffiliateController::class, 'index'])->name('affiliate.dashboard');
        Route::put('affiliate-commissions/{id}/status', [AffiliateController::class, 'updateCommissionStatus'])->name('affiliate.commission.status.update')->middleware('can:affiliate.commission.update');
    // });
    // Affiliate Request Management
    // Route::group(['middleware' => ['can:affiliate.requests.view']], function () {
        Route::get('affiliate-requests', [AffiliateRequestController::class, 'index'])->name('affiliate-requests.index');
        Route::put('affiliate-requests/{id}', [AffiliateRequestController::class, 'update'])->name('affiliate-requests.update')->middleware('can:affiliate.requests.update');
    // });
    // Affiliate Commission Management
    // Route::group(['middleware' => ['can:affiliate.commissions.view']], function () {
        // Route::get('affiliate-commissions', [AffiliateCommissionController::class, 'index'])->name('affiliate.commissions.index');
        // Route::put('affiliate-commissions/{id}/status', [AffiliateCommissionController::class, 'updateStatus'])->name('affiliate.commissions.update')->middleware('can:affiliate.commissions.update');
    // });

});
// ... your existing admin route group ...
Route::group(['as' => 'admin.', 'prefix' => 'admin'], function () {
    // Database Backup Routes
    Route::group(['middleware' => ['auth:admin', 'can:database.backup.management'], 'as' => 'database-backup.', 'prefix' => 'database-backups'], function () {
        Route::get('/', [DatabaseBackupController::class, 'index'])->name('index');
        Route::post('/store', [DatabaseBackupController::class, 'store'])->name('store');
        Route::post('/download', [DatabaseBackupController::class, 'download'])->name('download');
        Route::delete('/delete', [DatabaseBackupController::class, 'destroy'])->name('destroy');
    });

});

Route::group(['as' => 'admin.', 'prefix' => 'admin'], function () {

    // Route::group(['middleware' => 'can:database.backup.management'], function () {
    // Route::get('database-backups', [DatabaseBackupController::class, 'index'])->name('backup.index');
    // Route::post('database-backups/create', [DatabaseBackupController::class, 'create'])->name('backup.create');
    // Route::post('database-backups/download', [DatabaseBackupController::class, 'download'])->name('backup.download');
    // Route::delete('database-backups/delete', [DatabaseBackupController::class, 'destroy'])->name('backup.destroy');
    // });
    /* Start admin auth route */
    Route::get('login', [AuthenticatedSessionController::class, 'create'])->name('login');
    Route::post('store-login', [AuthenticatedSessionController::class, 'store'])->name('store-login');
    Route::post('logout', [AuthenticatedSessionController::class, 'destroy'])->name('logout');
    Route::get('forgot-password', [PasswordResetLinkController::class, 'create'])->name('password.request');
    Route::post('/forget-password', [PasswordResetLinkController::class, 'custom_forget_password'])->name('forget-password');
    Route::get('reset-password/{token}', [NewPasswordController::class, 'custom_reset_password_page'])->name('password.reset');
    Route::post('/reset-password-store/{token}', [NewPasswordController::class, 'custom_reset_password_store'])->name('password.reset-store');
    /* End admin auth route */

    Route::middleware(['auth:admin'])->group(function () {
        Route::get('/', [DashboardController::class, 'dashboard']);
        Route::get('dashboard', [DashboardController::class, 'dashboard'])->name('dashboard');

        Route::controller(AdminProfileController::class)->group(function () {
            Route::get('edit-profile', 'edit_profile')->name('edit-profile');
            Route::put('profile-update', 'profile_update')->name('profile-update');
            Route::put('update-password', 'update_password')->name('update-password');
        });

        Route::get('role/assign', [RolesController::class, 'assignRoleView'])->name('role.assign');
        Route::post('role/assign/{id}', [RolesController::class, 'getAdminRoles'])->name('role.assign.admin');
        Route::put('role/assign', [RolesController::class, 'assignRoleUpdate'])->name('role.assign.update');
        Route::resource('/role', RolesController::class);
        Route::resource('/role', RolesController::class);
    });
    Route::resource('admin', AdminController::class)->except('show');
    Route::put('admin-status/{id}', [AdminController::class, 'changeStatus'])->name('admin.status');
    // Settings routes
    Route::get('settings', [SettingController::class, 'settings'])->name('settings');
    Route::post('cloud/store', [CloudStorageController::class, 'store'])->name('cloud.store');
});
