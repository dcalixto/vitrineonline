$(document).ready(function () {
    Dropzone.autoDiscover = false;
    $('#image').dropzone({// PDF dropzone element
        maxFilesize: 2, // Set the maximum file size to 256 MB
        maxFiles: 10,
        dictDefaultMessage: "Solte suas imagens aqui",
        paramName: "image[foto]",
        addRemoveLinks: true, // Don't show remove links on dropzone itself.
        dictRemoveFile: 'Remover',
        uploadMultiple: true,
        method: 'put',
        acceptedFiles: "image/*",
        url: $('#image').data('update-url')
    });
});
