$(document).ready(function() {
  	Dropzone.autoDiscover = false;
$('#banner').dropzone({// PDF dropzone element
  maxFilesize: 2, // Set the maximum file size to 256 MB
   maxFiles: 1,
    dictDefaultMessage: "Solte suas imagens aqui",
  paramName: "marketing[banner]", // Rails expects the file upload to be something like model[field_name]
  addRemoveLinks: true, // Don't show remove links on dropzone itself.
 dictRemoveFile: 'Remover'
    // rest of code
});

});
