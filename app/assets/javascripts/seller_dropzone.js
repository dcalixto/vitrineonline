$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

  $("#seller_dropzone").dropzone({
    maxFilesize: 2, // Set the maximum file size to 256 MB
    maxFiles: 10,
    dictDefaultMessage: "Solte suas imagens aqui",
	paramName: "dipute[seller_file]", // Rails expects the file upload to be something like model[field_name]
	addRemoveLinks: true, // Don't show remove links on dropzone itself.
    dictRemoveFile: 'Remover',
    acceptedFiles: "image/*, .mp4,.mkv,.avi"

   
  });
  });

