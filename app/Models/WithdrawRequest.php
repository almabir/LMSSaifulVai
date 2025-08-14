<?php
// Create this file at: App/Models/WithdrawRequest.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\User;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class WithdrawRequest extends Model
{
    use HasFactory;
    protected $table = 'aff_withdraw_requests';
    protected $fillable = [
        'user_id',
        'method',
        'current_amount',
        'withdraw_amount',
        'account_info',
        'status',
        'approved_date',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}