$(document).ready(function () {
    Dropzone.autoDiscover = false;
    $('#prova').dropzone({// PDF dropzone element
        maxFilesize: 2, // Set the maximum file size to 256 MB
        maxFiles: 50,
        dictDefaultMessage: "Solte suas imagens aqui",
        paramName: "images[prova]",
        addRemoveLinks: true, // Don't show remove links on dropzone itself.
        dictRemoveFile: 'Remover',
        uploadMultiple: true,
        method: 'put',
        acceptedFiles: "image/*",
        url: $('#prova').data('update-url')
    });
});
