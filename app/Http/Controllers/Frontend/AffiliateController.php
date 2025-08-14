<?php

namespace App\Http\Controllers\Frontend;

use App\Models\User;
use Illuminate\Http\Request;
use App\Models\AffiliateRequest;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class AffiliateController extends Controller
{
    /**
     * Show the affiliate application form.
     */
    public function index()
    {
        $user = Auth::user();
        $existingRequest = AffiliateRequest::where('user_id', $user->id)->first();

        // Prevent access if user is already an affiliate or has a pending/approved request
        if ($user->is_affiliate || ($existingRequest && in_array($existingRequest->status, ['pending', 'approved']))) {
            return redirect()->route('student.dashboard')->with([
                'message' => __('You are already an affiliate or your application is under review.'),
                'alert-type' => 'info'
            ]);
        }
        
        return view('frontend.affiliate.apply', compact('existingRequest'));
    }

    /**
     * Store a new affiliate application.
     */
    public function store(Request $request)
    {
        $request->validate([
            'reason' => 'nullable|string|max:2000',
        ]);

        $user = Auth::user();

        // Check again to prevent duplicate submissions
        if ($user->is_affiliate) {
             return redirect()->route('student.dashboard')->with(['message' => __('You are already an affiliate.'),'alert-type' => 'info']);
        }
        
        // Create or update the request
        AffiliateRequest::updateOrCreate(
            ['user_id' => $user->id],
            ['reason' => $request->reason, 'status' => 'pending']
        );

        return redirect()->back()->with([
            'message' => __('Your affiliate application has been submitted successfully. You will be notified once it is reviewed.'),
            'alert-type' => 'success'
        ]);
    }
}
