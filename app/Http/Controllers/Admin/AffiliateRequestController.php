<?php

namespace App\Http\Controllers\Admin;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\AffiliateRequest;
use App\Http\Controllers\Controller;

class AffiliateRequestController extends Controller
{
    /**
     * Display a listing of the affiliate requests.
     */
    public function index(Request $request)
    {
        $query = AffiliateRequest::with('user:id,name,email');

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        $requests = $query->latest()->paginate(10);
        
        return view('admin.affiliate.index', compact('requests'));
    }

    /**
     * Update the status of an affiliate request.
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:approved,rejected',
        ]);

        $affiliateRequest = AffiliateRequest::findOrFail($id);
        $affiliateRequest->status = $request->status;
        $affiliateRequest->save();

        if ($request->status == 'approved') {
            $user = User::find($affiliateRequest->user_id);
            if ($user) {
                $user->is_affiliate = true;
                $user->save();
            }
        } else {
             $user = User::find($affiliateRequest->user_id);
            if ($user) {
                $user->is_affiliate = false;
                $user->save();
            }
        }

        return redirect()->back()->with([
            'message' => __('Status updated successfully.'), 
            'alert-type' => 'success'
        ]);
    }
}
