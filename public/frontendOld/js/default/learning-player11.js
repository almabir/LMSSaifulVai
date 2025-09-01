// Ensure base_url is defined globally in index.blade.php
$(document).ready(function () {
    // Load file info for the first lesson
    loadFileInfo($('.chapter-item:first'));

    // Handle chapter item click
    $('.chapter-item').on('click', function () {
        $('.chapter-item').removeClass('active');
        $(this).addClass('active');
        loadFileInfo($(this));
    });

    function loadFileInfo(element) {
        if (!element.length) {
            $('#lesson-content').html('<p>No lesson selected.</p>');
            return;
        }

        const lessonId = element.data('id');
        const chapterId = element.data('chapter-id');
        const courseId = element.data('course-id');
        const type = element.data('type');

        $.ajax({
            url: window.base_url + 'learning/get-file-info',
            method: 'POST',
            data: {
                lessonId: lessonId,
                chapterId: chapterId,
                courseId: courseId,
                type: type,
                _token: $('meta[name="csrf-token"]').attr('content')
            },
            success: function (response) {
                if (response.status === 'success') {
                    const fileInfo = response.file_info;
                    let content = '';

                    if (fileInfo.type === 'quiz') {
                        content = `<h3>${fileInfo.title}</h3><p>${fileInfo.description}</p>`;
                    } else if (fileInfo.type === 'live') {
                        content = `<h3>${fileInfo.title}</h3><p>${fileInfo.description}</p><a href="${fileInfo.live.join_url}" target="_blank">Join Live</a>`;
                    } else if (fileInfo.type === 'document') {
                        content = fileInfo.view;
                    } else {
                        content = `<h3>${fileInfo.title}</h3><video id="lesson-video" class="video-js vjs-default-skin" controls preload="auto" width="640" height="360">
                            <source src="${fileInfo.file_path}" type="video/mp4">
                        </video>`;
                    }

                    $('#lesson-content').html(content);

                    if (fileInfo.type === 'lesson') {
                        const player = videojs('lesson-video');
                        player.on('ended', function () {
                            markLessonComplete(lessonId, chapterId, courseId, fileInfo.type, 1);
                        });
                    }
                } else {
                    $('#lesson-content').html('<p>Error: ' + response.message + '</p>');
                }
            },
            error: function (xhr) {
                $('#lesson-content').html('<p>Error loading lesson.</p>');
                console.error(xhr);
            }
        });
    }

    function markLessonComplete(lessonId, chapterId, courseId, type, status) {
        $.ajax({
            url: window.base_url + 'learning/make-lesson-complete',
            method: 'POST',
            data: {
                lessonId: lessonId,
                chapterId: chapterId,
                courseId: courseId,
                type: type,
                status: status,
                _token: $('meta[name="csrf-token"]').attr('content')
            },
            success: function (response) {
                if (response.status === 'success') {
                    console.log(response.message);
                }
            },
            error: function (xhr) {
                console.error(xhr);
            }
        });
    }
});
