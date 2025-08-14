<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\WithdrawMethod;

class AffiliateWithdrawMethodController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $methods = WithdrawMethod::latest()->paginate(10);
        return view('admin.affiliate.withdraw.method.index', compact('methods'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('admin.affiliate.withdraw.method.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'min_amount' => 'required|numeric|min:0',
            'max_amount' => 'required|numeric|gte:min_amount',
            'description' => 'required|string',
            'status' => 'required|in:active,inactive',
        ]);

        WithdrawMethod::create($request->all());

        return redirect()->route('admin.affiliate-withdraw-methods.index')->with(['message' => 'Method created successfully.', 'alert-type' => 'success']);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $method = WithdrawMethod::findOrFail($id);
        return view('admin.affiliate.withdraw.method.edit', compact('method'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'min_amount' => 'required|numeric|min:0',
            'max_amount' => 'required|numeric|gte:min_amount',
            'description' => 'required|string',
            'status' => 'required|in:active,inactive',
        ]);

        $method = WithdrawMethod::findOrFail($id);
        $method->update($request->all());

        return redirect()->route('admin.affiliate-withdraw-methods.index')->with(['message' => 'Method updated successfully.', 'alert-type' => 'success']);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $method = WithdrawMethod::findOrFail($id);
        $method->delete();

        return redirect()->route('admin.affiliate-withdraw-methods.index')->with(['message' => 'Method deleted successfully.', 'alert-type' => 'success']);
    }
}
