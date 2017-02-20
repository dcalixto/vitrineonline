$(document).ready(function () {
    
    Dropzone.autoDiscover = false;
 $('#product_images').dropzone({// PDF dropzone element
        maxFilesize: 2, // Set the maximum file size to 256 MB
        maxFiles: 10,
        dictDefaultMessage: "Solte suas imagens aqui",
        paramName: "images[ifoto]",
        addRemoveLinks: true, // Don't show remove links on dropzone itself.
        dictRemoveFile: 'Remover',
        uploadMultiple: true,
       method: 'post',

        acceptedFiles: "image/*",
        //url: $('#images').data('update-url')
       
        url: "/products"
    });

   });









