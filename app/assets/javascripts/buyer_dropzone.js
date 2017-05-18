$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

  $("#buyer_dropzone").dropzone({
    maxFilesize: 2, // Set the maximum file size to 256 MB
    maxFiles: 10,
    dictDefaultMessage: "Solte suas imagens aqui",
	paramName: "dipute[buyer_file]", // Rails expects the file upload to be something like model[field_name]
	addRemoveLinks: true, // Don't show remove links on dropzone itself.
    dictRemoveFile: 'Remover',
    acceptedFiles: "image/*"
    acceptedFiles: ".mp4,.mkv,.avi"
  });
  });

