"use strict";
const csrf_token = $("meta[name='csrf-token']").attr("content");

// Define missing text variables (ideally these should come from Blade/Laravel localization)
const resource_text = "Resource File";
const file_type_text = "File Type";
const download_des_text = "Click the button below to download the file.";
const download_btn_text = "Download";
const le_hea = "Live Session Started!";
const le_des = "The live session is currently ongoing and will end at";
const open_w_txt = "Open Live Session";
const cre_mi_txt = "credential is not available or invalid."; // Corrected text
const le_fi_he = "Live Session Ended";
const le_fi_des = "This live session has already ended.";
const le_wi_he = "Live Session Waiting";
const le_wi_des = "The live session will start at";
const open_des_txt = "Click the button below to view the file in a new tab.";
const open_txt = "Open File";
const quiz_st_des_txt = "This is a quiz. You can attempt it to test your knowledge.";
const quiz_st_txt = "Start Quiz";
const no_des_txt = "No description available for this item.";

const placeholder = `<div class="player-placeholder">
    <div class="preloader-two player">
        <div class="loader-icon-two player"><img src="${preloader_path}" alt="Preloader"></div>
    </div>
</div>`;

function extractGoogleDriveVideoId(url) {
    var googleDriveRegex =
        /(?:https?:\/\/)?(?:www\.)?(?:drive\.google\.com\/(?:uc\?id=|file\/d\/|open\?id=)|youtu\.be\/)([\w-]{25,})[?=&#]*/;
    var match = url.match(googleDriveRegex);
    if (match && match[1]) {
        return match[1];
    } else {
        return null;
    }
}

function getYoutubeVideoId(url) {
    const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    const match = url.match(regExp);
    return (match && match[2].length === 11) ? match[2] : null;
}

function getVimeoVideoId(url) {
    const regExp = /(?:vimeo)\.com\/(?:video\/|channels\/(?:\w+\/)?|groups\/(?:[^\/]*)\/videos\/|album\/(?:\d+)\/video\/|)(\d+)(?:[?&].*)?/;
    const match = url.match(regExp);
    return (match && match[1]) ? match[1] : null;
}

function showSidebar() {
    $(".wsus__course_sidebar").addClass("show");
}

function hideSidebar() {
    $(".wsus__course_sidebar").removeClass("show");
}

$(document).ready(function () {
    $(document).on('contextmenu', function(e) {
        e.preventDefault();
        return false;
    });
    $(document).on('keydown', function(e) {
        if (e.which === 123 ||
            (e.ctrlKey && e.shiftKey && (e.which === 'I'.charCodeAt(0) || e.which === 'J'.charCodeAt(0))) ||
            (e.ctrlKey && e.which === 'U'.charCodeAt(0))) {
            e.preventDefault();
            return false;
        }
    });

    //image popup init
    $(document).on("click", ".image-popup", function () {
        $.magnificPopup.open({
            items: {
                src: $(this).attr("src"),
            },
            type: "image",
        });
    });
    document.addEventListener("focusin", (e) => {
        if (
            e.target.closest(
                ".tox-tinymce-aux, .moxman-window, .tam-assetmanager-root"
            ) !== null
        ) {
            e.stopImmediatePropagation();
        }
    });

    // Ensure this click handler is for the sidebar items, not general form checks
    $('body').on("click", ".lesson-item", function () { // Changed from .form-check to body.on for delegation
        $(".form-check").removeClass("item-active");
        $(this).parent('.form-check').addClass("item-active"); // Add active class to parent form-check

        // hide sidebar
        hideSidebar();

        var lessonId = $(this).attr("data-lesson-id");
        var chapterId = $(this).attr("data-chapter-id");
        var courseId = $(this).attr("data-course-id");
        var type = $(this).attr("data-type");

        $.ajax({
            method: "POST",
            url: base_url + "/student/learning/get-file-info",
            data: {
                _token: csrf_token,
                lessonId: lessonId,
                chapterId: chapterId,
                courseId: courseId,
                type: type,
            },
            beforeSend: function () {
                // Destroy existing video.js instance before replacing HTML
                if (videojs.getPlayers()["vid1"]) {
                    videojs.getPlayers()["vid1"].dispose();
                }
                $(".video-payer").html(placeholder);
            },
            success: function (data) {
                // set lesson id on meta
                $("meta[name='lesson-id']").attr("content", data.file_info.id);
                let playerHtml;
                const { file_info } = data;

                if (file_info.type === 'lesson' || file_info.type === 'live') {
                    // Handle video/audio/image/iframe content for lessons and live sessions
                    if (file_info.storage === 'youtube') {
                        playerHtml = `<video id="vid1" class="video-js vjs-default-skin" controls autoplay width="100%" height="400"
                            data-setup='{ "techOrder": ["youtube"], "sources": [{ "type": "video/youtube", "src": "${file_info.file_path}"}] }'>
                            </video>`;
                    } else if (file_info.storage === 'vimeo') {
                        playerHtml = `<video id="vid1" class="video-js vjs-default-skin" controls autoplay width="100%" height="400"
                            data-setup='{ "techOrder": ["vimeo"], "sources": [{ "type": "video/vimeo", "src": "${file_info.file_path}"}] }'>
                            </video>`;
                    } else if (file_info.storage === 'google_drive') {
                        playerHtml = `<iframe class="iframe-video" src="https://drive.google.com/file/d/${extractGoogleDriveVideoId(file_info.file_path)}/preview" width="100%" height="400" allow="autoplay" frameborder="0" allowfullscreen></iframe>`;
                    } else if (file_info.storage === 'iframe') {
                        playerHtml = `<iframe class="iframe-video" src="${file_info.file_path}" width="100%" height="400" frameborder="0" allowfullscreen></iframe>`;
                    } else if (file_info.file_type === 'video' && (file_info.storage === 'upload' || file_info.storage === 'external_link' || file_info.storage === 'aws' || file_info.storage === 'wasabi')) {
                        playerHtml = `<video src="${file_info.file_path}" type="video/mp4" id="vid1" class="video-js vjs-default-skin" controls autoplay width="100%" height="400" data-setup='{}'>
                            </video>`;
                    } else if (file_info.file_type === 'audio') {
                        playerHtml = `<audio controls src="${file_info.file_path}" style="width:100%;"></audio>`;
                    } else if (file_info.file_type === 'image') {
                        playerHtml = `<img src="${file_info.file_path}" alt="Lesson Image" class="img-fluid image-popup" style="max-width:100%; height:auto; cursor:pointer;">`;
                    } else { // Generic file download link for other types
                        playerHtml = `<div class="resource-file text-center p-5">
                                        <img src="${base_url}/uploads/website-images/resource-file.png" alt="Resource File" class="img-fluid mb-3" style="max-width: 150px;">
                                        <h6>${resource_text}</h6>
                                        <p>${file_type_text}: ${file_info.file_type}</p>
                                        <p>${download_des_text}</p>
                                        <form action="${base_url}/student/learning/resource-download/${file_info.id}" method="get" class="download-form">
                                            <button type="submit" class="btn btn-primary">${download_btn_text}</button>
                                        </form>
                                      </div>`;
                    }

                    // Specific live session overlay/buttons if type is 'live'
                    if (file_info.type === 'live') {
                        let liveBtnHtml = '';
                        if (file_info.is_live_now === 'started') {
                            liveBtnHtml = `<h6>${le_hea}</h6>`;
                            liveBtnHtml += `<p>${le_des} <b class="text-highlight">${file_info.end_time}</b></p>`;
                            if ((file_info.live.type === 'jitsi' && file_info.course.instructor.jitsi_credential) || (file_info.live.type === 'zoom' && file_info.course.instructor.zoom_credential)) {
                                liveBtnHtml += `<a href="${liveSessionUrlTemplate.replace('PLACEHOLDER', file_info.id)}" class="btn btn-two me-2">${open_w_txt}</a>`;
                            } else {
                                liveBtnHtml += `<p>${file_info.live.type === 'zoom' ? 'Zoom' : 'Jitsi'} ${cre_mi_txt}</p>`;
                            }
                            if(file_info.live.type === 'zoom' && file_info.live.join_url){
                                liveBtnHtml += `<a target="_blank" href="${file_info.live.join_url}" class="btn">Zoom app</a>`;
                            }
                        } else if (file_info.is_live_now === 'ended') {
                            liveBtnHtml = `<h6>${le_fi_he}</h6>`;
                            liveBtnHtml += `<p>${le_fi_des}</p>`;
                        } else { // not_started
                            liveBtnHtml = `<h6>${le_wi_he}</h6>`;
                            liveBtnHtml += `<p>${le_wi_des} <b class="text-highlight">${file_info.start_time}</b></p>`;
                        }

                        // Overlay for live session status
                        playerHtml = `<div class="live-session-overlay text-center p-5">
                                        <img src="${base_url}/frontend/img/online-learning.png" alt="Live Session" class="img-fluid mb-3" style="max-width: 150px;">
                                        ${liveBtnHtml}
                                      </div>`;
                    }

                } else if (file_info.type === 'quiz') {
                    const finalUrl = quizUrlTemplate.replace('PLACEHOLDER', file_info.id);
                    playerHtml = `<div class="resource-file text-center p-5">
                                    <img src="${base_url}/uploads/website-images/quiz.png" alt="Quiz Icon" class="img-fluid mb-3" style="max-width: 150px;">
                                    <h6 class="mt-2">${file_info.title}</h6>
                                    <p>${quiz_st_des_txt}</p>
                                    <a href="${finalUrl}" class="btn btn-primary mt-3">${quiz_st_txt}</a>
                                  </div>`;
                } else if (file_info.type === 'document') {
                    if (file_info.file_type === 'pdf') {
                        playerHtml = data.view; // PDF Viewer HTML
                    } else if (file_info.file_type === 'docx') {
                        playerHtml = data.view; // DOCX Viewer HTML
                    } else { // Other document types (txt, image, etc.)
                        playerHtml = `<div class="resource-file text-center p-5">
                                        <img src="${base_url}/uploads/website-images/resource-file.png" alt="Document Icon" class="img-fluid mb-3" style="max-width: 150px;">
                                        <h6>${file_info.title}</h6>
                                        <p>${file_type_text}: ${file_info.file_type}</p>
                                        <p>${open_des_txt}</p>
                                        <a href="${file_info.file_path}" target="_blank" class="btn btn-primary">${open_txt}</a>
                                        ${file_info.downloadable ? `<a href="${base_url}/student/learning/resource-download/${lessonId}" class="btn btn-secondary mt-2">${download_btn_text}</a>` : ''}
                                      </div>`;
                    }
                }

                $(".video-payer").html(playerHtml); // Update the player content

                // Initialize video.js player if a video element is present
                if (document.getElementById("vid1")) {
                    videojs("vid1").ready(function () {
                        this.play();
                    });
                }
                
                // set lecture description
                $(".about-lecture").html(
                    file_info.description || no_des_txt
                );

                // load qna's
                fetchQuestions(courseId, lessonId, 1, true);
            },
            error: function (xhr, status, error) {
                // Handle AJAX errors
                console.error("Error fetching file info:", xhr.responseText);
                $(".video-payer").html(`<div class="alert alert-danger text-center p-4">{{ __('Failed to load content. Please try again later.') }}</div>`);
            },
        });
    });

    $(".lesson-completed-checkbox").on("click", function () {
        let lessonId = $(this).attr("data-lesson-id");
        let type = $(this).attr("data-type");
        let checked = $(this).is(":checked") ? 1 : 0;
        let courseId = $(this).closest('.form-check').find('.lesson-item').data('course-id'); // Get courseId
        let chapterId = $(this).closest('.form-check').find('.lesson-item').data('chapter-id'); // Get chapterId

        $.ajax({
            method: "POST",
            url: base_url + "/student/learning/make-lesson-complete",
            data: {
                _token: csrf_token,
                lessonId: lessonId,
                status: checked,
                type: type,
                courseId: courseId, // Pass courseId
                chapterId: chapterId // Pass chapterId
            },
            success: function (data) {
                if (data.status == "success") {
                    toastr.success(data.message);
                    // Optionally update progress display here without full reload
                } else if (data.status == "error") {
                    toastr.error(data.message);
                }
            },
            error: function (xhr, status, error) {
                let errors = xhr.responseJSON.errors;
                $.each(errors, function (key, value) {
                    toastr.error(value);
                });
            },
        });
    });

    // Course video button for small devices
    $(".wsus__course_header_btn").on("click", function () {
        $(".wsus__course_sidebar").addClass("show");
    });

    $(".wsus__course_sidebar_btn").on("click", function () {
        $(".wsus__course_sidebar").removeClass("show");
    });
});