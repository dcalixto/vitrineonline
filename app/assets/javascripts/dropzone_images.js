$(document).ready(function() {
  	Dropzone.autoDiscover = false;
$('#images').dropzone({// PDF dropzone element
  maxFilesize: 2, // Set the maximum file size to 256 MB
   maxFiles: 10,
    dictDefaultMessage: "Solte suas imagens aqui",
    paramName: "images[foto]",
addRemoveLinks: true, // Don't show remove links on dropzone itself.
 dictRemoveFile: 'Remover'

});

});
