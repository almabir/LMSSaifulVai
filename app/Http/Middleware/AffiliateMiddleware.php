<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class AffiliateMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Check if the 'ref' query parameter exists in the URL
        if ($request->has('ref')) {
            // Store the referral code in a cookie that lasts for 30 days.
            // This cookie will be automatically sent with subsequent requests by the user.
            return $next($request)->cookie('referral_code', $request->query('ref'), 60 * 24 * 30);
        }

        // If no 'ref' parameter is found, continue the request as normal.
        return $next($request);
    }
}
