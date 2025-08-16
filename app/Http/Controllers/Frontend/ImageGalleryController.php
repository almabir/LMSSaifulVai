<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File; // Import File facade for directory operations
use App\Models\UserImage;
use Illuminate\Support\Facades\Log; // Import Log facade for debugging

class ImageGalleryController extends Controller
{
    /**
     * Display a listing of the user's images.
     */
    public function index()
    {
        $user = Auth::user();
        $images = UserImage::where('user_id', $user->id)->latest()->get();
        return view('frontend.instructor-dashboard.image-gallery.index', compact('images'));
    }

    /**
     * Store a newly created image in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048', // Max 2MB
        ]);

        $user = Auth::user();

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $fileName = time() . '_' . $image->getClientOriginalName();
            
            // Define the destination path within the public directory
            $destinationPath = public_path('uploads/store/user_uploads/' . $user->id);

            // Create the directory if it doesn't exist
            if (!File::isDirectory($destinationPath)) {
                File::makeDirectory($destinationPath, 0755, true, true);
            }

            // Move the uploaded image to the desired public directory
            $image->move($destinationPath, $fileName);

            // Store the path relative to the public directory in the database
            $filePath = 'uploads/store/user_uploads/' . $user->id . '/' . $fileName;

            $userImage = UserImage::create([
                'user_id' => $user->id,
                'file_name' => $fileName,
                'file_path' => $filePath, // This path is relative to the public directory
            ]);

            // Return the full public URL using the asset helper for the AJAX response
            return response()->json(['status' => 'success', 'message' => __('Image uploaded successfully!'), 'id' => $userImage->id, 'fileName' => $fileName, 'imageUrl' => asset($filePath)]);
        }

        return response()->json(['status' => 'error', 'message' => __('Failed to upload image.')], 400);
    }

    /**
     * Remove the specified image from storage.
     */
    public function destroy(string $id)
    {
        $user = Auth::user();
        $image = UserImage::where('id', $id)->where('user_id', $user->id)->firstOrFail();

        // Delete the file from the public directory
        $fullPath = public_path($image->file_path);
        if (File::exists($fullPath)) {
            File::delete($fullPath);
        }

        // Delete the record from the database
        $image->delete();

        return response()->json(['status' => 'success', 'message' => __('Image deleted successfully!')]);
    }
}

