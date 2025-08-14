<?php

namespace App\Http\Controllers\Admin;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\AffiliateCommission;
use App\Http\Controllers\Controller;

class AffiliateCommissionController extends Controller
{
    /**
     * Display a listing of all affiliate commissions.
     */
    public function index(Request $request)
    {
        $query = AffiliateCommission::with(['user:id,name', 'course:id,title', 'order:id,invoice_id']);

        // Filter by status
        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // Filter by affiliate
        if ($request->filled('affiliate_id')) {
            $query->where('user_id', $request->affiliate_id);
        }

        $commissions = $query->latest()->paginate(20);
        $affiliates = User::where('is_affiliate', true)->get(['id', 'name']);

        return view('admin.affiliate.commissions', compact('commissions', 'affiliates'));
    }

    /**
     * Update the status of a commission (e.g., mark as paid).
     */
    public function updateStatus(Request $request, $id)
    {
        $request->validate(['status' => 'required|in:paid,cancelled']);

        $commission = AffiliateCommission::findOrFail($id);
        
        // Logic to prevent re-paying a cancelled commission or vice-versa
        if (($commission->status == 'paid' && $request->status == 'cancelled') || ($commission->status == 'cancelled' && $request->status == 'paid')) {
             return redirect()->back()->with(['message' => 'Invalid status change.', 'alert-type' => 'error']);
        }
        
        $commission->status = $request->status;
        $commission->save();

        return redirect()->back()->with(['message' => 'Commission status updated successfully.', 'alert-type' => 'success']);
    }
}
