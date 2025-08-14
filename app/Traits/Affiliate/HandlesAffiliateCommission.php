<?php

namespace App\Traits\Affiliate;

use App\Models\Course;
use App\Models\AffiliateLink;
use App\Models\AffiliateCommission;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Log;
use Modules\Order\app\Models\Order; // <-- CORRECTED: Was missing this import

trait HandlesAffiliateCommission
{
    /**
     * Process affiliate commission for a given order.
     *
     * @param  \Modules\Order\app\Models\Order  $order
     * @return void
     */
    protected function processAffiliateCommission(Order $order)
    {
        // Check if a referral cookie exists
        if (Cookie::has('referral_code')) {
            $referralCode = Cookie::get('referral_code');
            $affiliateLink = AffiliateLink::where('referral_code', $referralCode)->first();

            // Ensure the link is valid and the buyer is not the affiliate themselves
            if ($affiliateLink && $affiliateLink->user_id !== $order->buyer_id) {
                
                // Loop through each item in the order
                foreach ($order->items as $orderItem) {
                    // Check if the referred course matches the course in the order
                    if ($orderItem->course_id == $affiliateLink->course_id) {
                        
                        $course = Course::find($orderItem->course_id);

                        if ($course && $course->affiliate_commission_percentage > 0) {
                            // Calculate the commission based on the course price and percentage
                            $commissionAmount = ($orderItem->price * $course->affiliate_commission_percentage) / 100;
                            
                            // Log the commission record in the database
                            AffiliateCommission::create([
                                'user_id' => $affiliateLink->user_id,
                                'order_id' => $order->id,
                                'course_id' => $orderItem->course_id,
                                'commission_amount' => $commissionAmount,
                                'status' => 'pending', // Will be 'paid' after a payout process
                            ]);

                            Log::info("Affiliate commission processed for order #{$order->id} and affiliate ID {$affiliateLink->user_id}");
                        }
                    }
                }
            }

            // Forget the cookie after processing to prevent it from being used again
            Cookie::queue(Cookie::forget('referral_code'));
        }
    }
}
