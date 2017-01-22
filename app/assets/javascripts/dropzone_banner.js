$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

  $("#user_avatar_dropzone").dropzone({
    maxFilesize: 2, // Set the maximum file size to 256 MB
    maxFiles: 1,
    dictDefaultMessage: "Solte suas imagens aqui",
	paramName: "user[avatar]", // Rails expects the file upload to be something like model[field_name]
	addRemoveLinks: true, // Don't show remove links on dropzone itself.
    dictRemoveFile: 'Remover',
    acceptedFiles: "image/*"
  });
  });
