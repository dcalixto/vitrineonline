

//$(document).ready(function(){
	// disable auto discover
    //
//  Dropzone.autoDiscover = false;

 // $("#file").dropzone({
 //   maxFilesize: 2, // Set the maximum file size to 256 MB
 //   maxFiles: 10,
  //  dictDefaultMessage: "Solte suas imagens aqui",
//	paramName: "proofs[file][]", // Rails expects the file upload to be something like model[field_name]
//	addRemoveLinks: true, // Don't show remove links on dropzone itself.
  //  dictRemoveFile: 'Remover',
 //   acceptedFiles: "image/*"
 // });
//  });



  $(document).ready(function () {
   Dropzone.autoDiscover = false;
    $('#file').dropzone({// PDF dropzone element
        maxFilesize: 2, // Set the maximum file size to 256 MB
        maxFiles: 10,
        dictDefaultMessage: "Solte suas imagens aqui",
        paramName: "proofs[file]",
        addRemoveLinks: true, // Don't show remove links on dropzone itself.
        dictRemoveFile: 'Remover',
        uploadMultiple: true,
       method: 'post',
       acceptedFiles: "image/*",
        url: $('#file').data('post-url')

    // url: "<%=  uploadfiles_order_dispute_url %>"


    });
});
