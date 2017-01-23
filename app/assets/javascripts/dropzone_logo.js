// FILE UPLOAD

$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;
  $("#vitrine_logo_dropzone").dropzone({
    maxFilesize: 2, // Set the maximum file size to 256 MB
    maxFiles: 1,
    dictDefaultMessage: "Solte suas imagens aqui",
    paramName: "vitrine[logo]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: true, // Don't show remove links on dropzone itself.
    dictRemoveFile: 'Remover',
    acceptedFiles: "image/*",
    url: $('#vitrine_logo_dropzone').data('update-url')
  });


});


