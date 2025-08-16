@extends('frontend.instructor-dashboard.layouts.master')

@section('dashboard-contents')
    <div class="dashboard__content-wrap">
        <div class="dashboard__content-title d-flex justify-content-between">
            <h4 class="title">{{ __('My Image Gallery') }}</h4>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card p-4">
                    <h5 class="mb-4">{{ __('Upload New Image') }}</h5>
                    <form id="image-upload-form" enctype="multipart/form-data">
                        @csrf
                        <div class="mb-3">
                            <label for="image-file" class="form-label">{{ __('Select Image File') }}</label>
                            <input class="form-control" type="file" id="image-file" name="image" accept="image/*" required>
                        </div>
                        <button type="submit" class="btn btn-primary" id="upload-button">
                            <span id="upload-spinner" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                            {{ __('Upload Image') }}
                        </button>
                    </form>
                    <div id="upload-message" class="mt-3"></div>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-12">
                <h4 class="title mb-4">{{ __('Your Uploaded Images') }}</h4>
                <div id="image-gallery-container" class="row row-cols-1 row-cols-md-3 g-4">
                    @forelse($images as $image)
                        <div class="col" id="image-card-{{ $image->id }}">
                            <div class="card h-100 shadow-sm">
                                {{-- IMPORTANT: Using asset() helper for public path --}}
                                <img src="{{ asset($image->file_path) }}" class="card-img-top object-fit-cover" alt="{{ $image->file_name }}" style="height: 200px;">
                                <div class="card-body d-flex flex-column">
                                    <h6 class="card-title text-truncate">{{ $image->file_name }}</h6>
                                    <p class="card-text text-muted small mt-auto">{{ __('Uploaded:') }} {{ $image->created_at->diffForHumans() }}</p>
                                    <div class="d-flex gap-2 mt-2">
                                        {{-- IMPORTANT: Using asset() helper for public path in data-link --}}
                                        <button class="btn btn-sm btn-success copy-link-btn flex-grow-1" data-link="{{ asset($image->file_path) }}">
                                            {{ __('Copy Link') }}
                                        </button>
                                        <button class="btn btn-sm btn-danger delete-image-btn" data-id="{{ $image->id }}">
                                            {{ __('Delete') }}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    @empty
                        <div class="col-12 text-center text-muted">
                            <p>{{ __('No images uploaded yet.') }}</p>
                        </div>
                    @endforelse
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
<script>
    $(document).ready(function() {
        // Handle Image Upload Form Submission
        $('#image-upload-form').on('submit', function(e) {
            e.preventDefault();

            let formData = new FormData(this);
            let uploadButton = $('#upload-button');
            let uploadSpinner = $('#upload-spinner');
            let uploadMessage = $('#upload-message');

            uploadButton.prop('disabled', true);
            uploadSpinner.removeClass('d-none');
            uploadMessage.empty();

            $.ajax({
                url: '{{ route('student.image-gallery.store') }}',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success: function(response) {
                    if (response.status === 'success') {
                        uploadMessage.html('<div class="alert alert-success">' + response.message + '</div>');
                        $('#image-file').val(''); // Clear the file input
                        
                        // Dynamically add the new card
                        let newImageCard = `
                            <div class="col" id="image-card-${response.id}">
                                <div class="card h-100 shadow-sm">
                                    <img src="${response.imageUrl}" class="card-img-top object-fit-cover" alt="${response.fileName}" style="height: 200px;">
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title text-truncate">${response.fileName}</h6>
                                        <p class="card-text text-muted small mt-auto">{{ __('Uploaded:') }} Just now</p>
                                        <div class="d-flex gap-2 mt-2">
                                            <button class="btn btn-sm btn-success copy-link-btn flex-grow-1" data-link="${response.imageUrl}">
                                                {{ __('Copy Link') }}
                                            </button>
                                            <button class="btn btn-sm btn-danger delete-image-btn" data-id="${response.id}">
                                                {{ __('Delete') }}
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `;
                        $('#image-gallery-container').prepend(newImageCard);
                        // Remove "No images uploaded yet" message if present
                        $('#image-gallery-container .text-center.text-muted').remove();

                    } else {
                        uploadMessage.html('<div class="alert alert-danger">' + response.message + '</div>');
                    }
                },
                error: function(xhr) {
                    let errors = xhr.responseJSON.errors;
                    let errorMessage = '';
                    $.each(errors, function(key, value) {
                        errorMessage += '<li>' + value + '</li>';
                    });
                    uploadMessage.html('<div class="alert alert-danger"><ul>' + errorMessage + '</ul></div>');
                },
                complete: function() {
                    uploadButton.prop('disabled', false);
                    uploadSpinner.addClass('d-none');
                }
            });
        });

        // Handle Copy Link Button Click
        $('body').on('click', '.copy-link-btn', function() {
            let link = $(this).data('link');
            let tempInput = $('<input>');
            $('body').append(tempInput);
            tempInput.val(link).select();
            document.execCommand('copy');
            tempInput.remove();
            toastr.success('Link copied to clipboard!');
        });

        // Handle Delete Image Button Click
        $('body').on('click', '.delete-image-btn', function() {
            if (!confirm('{{ __('Are you sure you want to delete this image?') }}')) {
                return;
            }

            let imageId = $(this).data('id');
            let card = $('#image-card-' + imageId);

            $.ajax({
                url: '{{ route('student.image-gallery.destroy', '') }}/' + imageId,
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                beforeSend: function() {
                    card.css('opacity', '0.5'); // Dim the card during deletion
                },
                success: function(response) {
                    if (response.status === 'success') {
                        toastr.success(response.message);
                        card.remove(); // Remove the image card from the DOM
                        // If no images left, show "No images uploaded yet" message
                        if ($('#image-gallery-container .col').length === 0) {
                            $('#image-gallery-container').html('<div class="col-12 text-center text-muted"><p>{{ __('No images uploaded yet.') }}</p></div>');
                        }
                    } else {
                        toastr.error(response.message);
                        card.css('opacity', '1'); // Restore opacity on error
                    }
                },
                error: function(xhr) {
                    toastr.error('{{ __('An error occurred during deletion.') }}');
                    card.css('opacity', '1'); // Restore opacity on error
                }
                // No 'complete' callback here, as the card is removed on success
            });
        });
    });
</script>
@endpush
