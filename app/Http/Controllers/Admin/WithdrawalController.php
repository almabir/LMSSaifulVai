<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use App\Models\WithdrawRequest;

class WithdrawalController extends Controller
{
    /**
     * Display a listing of the withdrawal requests.
     */
    public function index(Request $request)
    {
        $query = WithdrawRequest::with('user:id,name,email');

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        $requests = $query->latest()->paginate(15);

        return view('admin.withdraw.index', compact('requests'));
    }

    /**
     * Update the status of a withdrawal request.
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:approved,rejected',
        ]);

        $withdrawRequest = WithdrawRequest::findOrFail($id);

        // Prevent updating if already processed
        if ($withdrawRequest->status !== 'pending') {
            return redirect()->back()->with(['message' => 'This request has already been processed.', 'alert-type' => 'error']);
        }

        if ($request->status == 'approved') {
            $user = User::findOrFail($withdrawRequest->user_id);

            // Check if user has sufficient balance
            if ($user->wallet_balance < $withdrawRequest->withdraw_amount) {
                return redirect()->back()->with(['message' => 'User does not have sufficient balance for this withdrawal.', 'alert-type' => 'error']);
            }

            // Deduct from user's wallet
            $user->decrement('wallet_balance', $withdrawRequest->withdraw_amount);

            $withdrawRequest->status = 'approved';
            $withdrawRequest->approved_date = now();
        } else {
            $withdrawRequest->status = 'rejected';
        }

        $withdrawRequest->save();

        return redirect()->back()->with(['message' => 'Withdrawal request has been updated successfully.', 'alert-type' => 'success']);
    }
}

