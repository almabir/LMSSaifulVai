<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use App\Models\WithdrawRequest;

class AffiliateWithdrawalController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = WithdrawRequest::with('user:id,name')->whereHas('user', function ($q) {
            $q->where('is_affiliate', true);
        });

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        $requests = $query->latest()->paginate(15);

        return view('admin.affiliate.withdraw.index', compact('requests'));
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $request = WithdrawRequest::with('user')->findOrFail($id);
        return view('admin.affiliate.withdraw.show', compact('request'));
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:approved,rejected',
        ]);

        $withdrawRequest = WithdrawRequest::findOrFail($id);

        if ($withdrawRequest->status !== 'pending') {
            return redirect()->back()->with(['message' => 'This request has already been processed.', 'alert-type' => 'error']);
        }

        if ($request->status == 'approved') {
            // $user = User::findOrFail($withdrawRequest->user_id);
            // $latestRequest = WithdrawRequest::where('user_id', $user->id)->latest()->first();
            // Check if user has sufficient balance in their main wallet
            if ($withdrawRequest->current_amount < $withdrawRequest->withdraw_amount) {
                return redirect()->back()->with(['message' => 'User does not have sufficient balance for this withdrawal.', 'alert-type' => 'error']);
            }

            // Decrement the amount from the user's main wallet
            $withdrawRequest->decrement('current_amount', $withdrawRequest->withdraw_amount);

            $withdrawRequest->status = 'approved';
            $withdrawRequest->approved_date = now();
            
        } else { // 'rejected'
            $withdrawRequest->status = 'rejected';
        }

        $withdrawRequest->save();

        return redirect()->route('admin.affiliate.withdrawal.index')->with(['message' => 'Withdrawal request has been updated successfully.', 'alert-type' => 'success']);
    }
}
