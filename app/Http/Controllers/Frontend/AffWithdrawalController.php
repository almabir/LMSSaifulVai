<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use App\Models\AffiliateCommission;
use App\Models\WithdrawRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\WithdrawMethod;

class AffWithdrawalController extends Controller
{
    /**
     * Display the withdrawal page for affiliates.
     */
    public function index()
    {
        $user = Auth::user();
        if (!$user->is_affiliate) {
            abort(403, 'You are not an authorized affiliate.');
        }

        $methods = WithdrawMethod::where('status', 'active')->get();
        $requests = WithdrawRequest::where('user_id', $user->id)->latest()->paginate(10);

        // Calculate all necessary affiliate balances
        // $total_earned = AffiliateCommission::where('user_id', $user->id)->where('status', 'paid')->sum('commission_amount');
        $total_earned = AffiliateCommission::where('user_id', $user->id)->where('status', 'paid')->sum('commission_amount');
        $total_withdrawn = WithdrawRequest::where('user_id', $user->id)->where('status', 'approved')->sum('withdraw_amount');
        $pending_commission = AffiliateCommission::where('user_id', $user->id)->where('status', 'pending')->sum('commission_amount');
        $current_balance = WithdrawRequest::latest('user_id', $user->id)->first();
        $current_balance = $current_balance->current_amount;
        return view('frontend.student-dashboard.withdraw.index', compact(
            'user', 
            'methods', 
            'requests', 
            'total_earned', 
            'total_withdrawn', 
            'pending_commission',
            'current_balance'
        ));
    }

    /**
     * Store a new withdrawal request from an affiliate.
     */
    public function store(Request $request)
    {
        $user = Auth::user();
        $method = WithdrawMethod::findOrFail($request->method_id);
        $latestRequest = WithdrawRequest::where('user_id', $user->id)->latest()->first();
        $request->validate([
            'amount' => [
                'required',
                'numeric',
                'min:' . $method->min_amount,
                'max:' . $method->max_amount,
                function ($attribute, $value, $fail) use ($latestRequest) {
                    if ($value > $latestRequest->current_amount) {
                        $fail('The requested amount exceeds your available wallet balance.');
                    }
                },
            ],
            'account_info' => 'required|string|max:2000',
        ]);

        WithdrawRequest::create([
            'user_id' => $user->id,
            'method' => $method->name,
            'current_amount' => $latestRequest->current_amount, // The balance at the time of request
            'withdraw_amount' => $request->amount,
            'account_info' => $request->account_info,
            'status' => 'pending',
        ]);

        return redirect()->back()->with(['message' => 'Withdrawal request submitted successfully.', 'alert-type' => 'success']);
    }
}
