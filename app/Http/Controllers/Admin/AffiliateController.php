<?php

namespace App\Http\Controllers\Admin;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\AffiliateCommission;
use App\Http\Controllers\Controller;
use App\Models\WithdrawRequest;

class AffiliateController extends Controller
{
    /**
     * Display the affiliate management dashboard.
     */
    public function index(Request $request)
    {
        // Query for commissions
        $commissionsQuery = AffiliateCommission::with(['user:id,name', 'course:id,title', 'order:id,invoice_id']);

        // Filter by status
        if ($request->filled('status')) {
            $commissionsQuery->where('status', $request->status);
        }

        $commissions = $commissionsQuery->latest()->paginate(15);

        // Stats
        $totalAffiliates = User::where('is_affiliate', true)->count();
        $totalCommissionEarned = AffiliateCommission::sum('commission_amount');
        $totalCommissionPaid = AffiliateCommission::where('status', 'paid')->sum('commission_amount');

        return view('admin.affiliate.dashboard', compact(
            'commissions',
            'totalAffiliates',
            'totalCommissionEarned',
            'totalCommissionPaid'
        ));
    }

    /**
     * Update the status of a commission.
     */
    public function updateCommissionStatus(Request $request, $id)
    {
        $request->validate(['status' => 'required|in:paid,cancelled']);

        $commission = AffiliateCommission::findOrFail($id);
        // Prevent status changes if not pending
        if ($commission->status !== 'pending') {
            return redirect()->back()->with(['message' => 'This commission has already been processed.', 'alert-type' => 'error']);
        }

        if ($request->status == 'paid') {
            // Find the user and add the amount to their wallet
            // $user = User::findOrFail($commission->user_id);
            $user = WithdrawRequest::latest('user_id', $commission->user_id)->first();
            $user->increment('current_amount', $commission->commission_amount);

            // Update the commission status
            $commission->status = 'paid';
            $commission->save();
        } else { // 'cancelled'
            $commission->status = 'cancelled';
            $commission->save();
        }

        return redirect()->back()->with(['message' => 'Commission status updated successfully.', 'alert-type' => 'success']);
    }
}
