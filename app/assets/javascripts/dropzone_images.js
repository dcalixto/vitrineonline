//$(document).ready(function () {
    
  //  Dropzone.autoDiscover = false;
// $('#product_images').dropzone({// PDF dropzone element
  //      maxFilesize: 2, // Set the maximum file size to 256 MB
    //    maxFiles: 10,
     //   dictDefaultMessage: "Solte suas imagens aqui",
     //   paramName: "images[ifoto]",
    //    addRemoveLinks: true, // Don't show remove links on dropzone itself.
    //    dictRemoveFile: 'Remover',
    //    uploadMultiple: true,
   //    method: 'post',

    //    acceptedFiles: "image/*",
        //url: $('#images').data('update-url')
       
   //     url: "/products"
  //  });

  // });




var myDropZ, ProductId;
$(document).ready(function() {
   
    var filesSent = [];
    Dropzone.autoDiscover = false;
    if($('.dropzone').length > 0){
        myDropZ = new Dropzone('.dropzone', {
            maxFilesize: 2,
            maxFiles: 10,
            dictDefaultMessage: "Solte suas imagens aqui",
            paramName: "images[ifoto]",
            addRemoveLinks: true,
            dictRemoveFile: 'Remover',
            autoProcessQueue: false,
            uploadMultiple: true,
            method: 'post',
            parallelUploads: 10000,
            headers: {
                'Accept': '*/*'
            },
            params: {
                'product[name]': '',
                'product[quantity]': '',
                'authenticity_token': $('meta[name="csrf-token"]').attr('content')
            },
            url: "/products",
            acceptedFiles: 'image/*',
            init: function() {
                this.on("addedfile", function(file) {
                    // console.log(JSON.stringify(file));
                });
                this.on('queuecomplete', function(f) {
                    // alert(f);
                });
            },
            errormultiple: function(file, response) {
                // showError();
                // console.log(response);
            },
           // successmultiple: function(file, response) {
             //   var res = jQuery.parseJSON(response);
               // console.log(res);
                //if(res.success == true){
                  //  $('#new_product input').not('[type="submit"]').val('');
                    //showSuccess(res);
                //}else{
                  //  showError();
               // }
            }
        );
     //   $('#new_product input').not('[type="submit"]').on('change keyup paste', function(){
    //   ''     $(this).val() == '' ? $(this).css('border-color','red') : $(this).removeAttr('style');
        //});
        //$(document).find('#new_product input[name="commit"]').on('click', function(e) {
          //  $(this).attr('disbaled', true);
            //e.preventDefault();
            //e.stopPropagation();
            //myDropZ.options.params['product[name]'] = $('#product_name').val();
            //myDropZ.options.params['product[quantity]'] = $('#product_quantity').val();
            //$('#new_product input').not('[type="submit"]').removeAttr('style');
            // Validation
           // var errs = 0;
            //$('#new_product input').not('[type="submit"]').each(function(){
              //  if($(this).val() == ''){
                //    $(this).css('border-color','red');
                  //  errs = 1;
                //}else
                  //  $(this).removeAttr('style');
            //});
            //if(errs == 0){
              //  if(myDropZ.getQueuedFiles().length > 0){
                //    console.log('dropzone');
                  //  myDropZ.processFiles(myDropZ.files);
                //} else{
                  //  console.log('ajax');
                    //$.ajax({
                      //  url: 'http://localhost:3000/products/',
                        //type: 'POST',
                        // dataType: 'JSON',
                        //data: $('#new_product').serialize(),
                        //error: function(xhr,status,err){
                          //  showError();
                            //console.log(err);
                        //},
                     //   success: function(resp, status, xhr){
                       //     var res = jQuery.parseJSON(resp);
                         //   console.log(res);
                           // if(res.success == true){
                             //   $('#new_product input').not('[type="submit"]').val('');
                               // showSuccess(res);
                            //}else{
                              //  showError();
                            //}
                        //}
                    //});
                //}
            //}
            $(this).attr('disbaled', false);
     //   });
    }
});
function showSuccess(res){
    if($(document).find('#product-success').length == 0)
        $('#rTabsDemo').append('<div id="product-success" style="position:absolute;background-color:green;color:white;text-align: center;padding:10px 0;left:0;top:37px;width:100%;z-index:10;font-size:16px;display:none;">Product added successfully!</div>');
    $('#product-success').slideDown(600).delay(2100).slideUp(600);
    setTimeout(function(){
        if(res.product_id != '')
            window.location = '/products/'+res.product_id;  // Redirect to specific product page
    }, 3300);
}

function showError(){
    if($(document).find('#product-error').length == 0)
        $('#rTabsDemo').append('<div id="product-error" style="position:absolute;background-color:red;color:white;text-align: center;padding:10px 0;left:0;top:37px;width:100%;z-index:10;font-size:16px;display:none;">Some error occurred!</div>');
    $('#product-error').slideDown(600).delay(2600).slideUp(600);
}
  












