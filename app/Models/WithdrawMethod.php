<?php
// Create this file at: App/Models/WithdrawMethod.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class WithdrawMethod extends Model
{
    use HasFactory;
    protected $table = 'aff_withdraw_methods';
    protected $fillable = [
        'name',
        'min_amount',
        'max_amount',
        'description',
        'status',
    ];
}