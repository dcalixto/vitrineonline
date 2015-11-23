//= require jquery_ujs
//= require jquery.timeago
//= require wmd/wmd
//= require wmd/showdown
//= require private_pub
//= require FileAPI.min
//= require morris.min
//= require raphael.min
//= require tipsy
//= require jquery.fancybox.pack
//= require jquery.raty
//= require responsiveslides.min
//= require typeahead
//= require jquery.tokeninput
//= require jquery.webui-popover
//= require lightslider.min

//= require_tree .


// TIPSY




//$('.ttooltip').webuiPopover({
  //  type:'async',
    //url:'/feedbacks/links',



 //closeable:true,
   //                     padding:false,
     //                   cache:false,


//});




$(document).ready(function() {
$(".content-slider").lightSlider({
                loop:true,
                keyPress:true,
                auto:true
               
            });
});



$(document).ready(function() {
$(".content-slider-vertical").lightSlider({
                loop:true,
                 vertical:true,
                verticalHeight:500,
                 auto:true,
                 pager: false

               
            });
});






$(document).ready(function() {
  $('.balao li a').tipsy({
    gravity: 'n'
  });
});






// PRODUCT IMAGE THUMBNAILS, GALLERY AND ZOOM
$(document).ready(function() {
  $('.thumbnail').on("click", function(e) {
    $('#mainImage').hide();
    var i = $('<img />').attr('src', $(this).data('zoom-href')).load(function() {
      $('#mainImage').attr('src', i.attr('src')).fadeIn();
    });
    e.preventDefault();

    return false;
  });
  $('#placeholder').click(function() {
    var img = $("img[data-zoom-href='" + $(this).find('img').attr('src') + "']");
    var index = $("#showcase img").index(img);
    $.fancybox($('#showcase a'), {
      index: index
    });
  });
});


// WMD-EDITOR

$(document).ready(function() {
  if ($('#notes-bar').length > 0) {
    new WMDEditor({
      input: "notes",
      button_bar: "notes-bar",
      preview: "notes-preview",
      buttons: "bold italic  blockquote ol ul  heading hr"
    });
  }
});

// META-TAGS
//$(document).ready(function() {

  //$('#tags').tagsInput({
    //height: '100px',
    //width: '60%',
    //interactive: true,
    //defaultText: 'Adicione',
    //minChars: 0,
    //maxChars: 500

  //});
//});


// FLASH NOTICE ANIMATION
var fade_flash = function() {
  $(".flash_notice").delay(7000).fadeOut("slow");
  $(".flash_alert").delay(7000).fadeOut("slow");
  $(".flash_error").delay(7000).fadeOut("slow");
  $(".flash_success").delay(7000).fadeOut("slow");
};
fade_flash();

var show_ajax_message = function(msg, type) {
  $(".flash-message").html('<div class="flash_' + type + '">' + msg + '</div>');
  fade_flash();
};

$(".flash-message").ajaxComplete(function(event, request) {
  var msg = request.getResponseHeader('X-Message');
  var type = request.getResponseHeader('X-Message-Type');
  show_ajax_message(msg, type); //use whatever popup, notification or whatever plugin you want
});


// FILE UPLOAD

$(document).ready(function() {


});

// CUSTOM FORM SUBMIT
$(document).ready(function() {
  $('a[data-submit-form]').click(function(e) {
    e.preventDefault();
    $(this).closest('form').attr('action', $(this).attr('href')).submit();
  });
});

// CHARTS

$(document).ready(function() {
  if (typeof(draw_chart) != 'undefined')
    draw_chart();
  if (typeof(chart_options) != 'undefined' && $('#chart_options').length > 0)
    $('#chart_options').change(chart_options);
});

// POSTS
var bind_comment_handler = function() {
  $('.comment_input').unbind('keyup');
  $('.comment_input').keyup(function(event) {
    if (event.keyCode == 13 && $(this).val().length > 0) {
      var comment_value = $(this).val();
      var post_id = $(this).prev().val();
      $.post('/feedbacks/comment', {
        feedback_id: feedback_id,
        comment: comment_value
      }, function() {
        $('#comments' + feedback_id).load('/feedbacks/comments?post_id=' + feedback_id);
      });
    }
  });
};

$(document).ready(function() {
  if (typeof(total_feedback_pages) != 'undefined' && $('#more_feedbacks').length > 0) {
    $('#more_feedbacks').pageless({
      totalPages: total_feedback_pages,
      url: '/feedbacks/',
      loaderHtml: '<div></div>'
    });

  }
  bind_comment_handler();
});

// method moved here to use on any page
var createUploadWithPreviewBox = function(container, inputName) {
  var previewBoxWidth = 250;
  var previewBoxHeight = 250;

  var input = $("<input type='file'>");
  input.attr('name', inputName);

  var preview = $('<div>').addClass('preview-container');
  preview.append(input);
  container.append(preview);

  input.bind('change', function(evt) {
    var targetInput = $(this);
    var files = FileAPI.getFiles(evt);
    FileAPI.each(files, function(file) {
      if (/image/.test(file.type)) {
        FileAPI.Image(file).resize(previewBoxWidth, previewBoxHeight, {
          preview: true
        }).get(function(error, image) {
          if (error) {
            console.log('Error: ' + error);
          } else {
            targetInput.addClass('hidden');
            preview.append(image);
          }
        });
      }
    });
  });
};


// ANNOUNCEMENT


function hideAnnouncement(announcement_created_at) {
  createCookie(announcement_created_at, 'hidden', 365);
  $("#announcement").slideUp();
}

// http://www.quirksmode.org/js/cookies.html
function createCookie(name, value, days) {
  if (days) {
    var date = new Date();
    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    var expires = "; expires=" + date.toGMTString();
  } else var expires = "";
  document.cookie = name + "=" + value + expires + "; path=/";
}



// MENU CHOOSEN BRANDS ON NEW PRODUCT


$(document).ready(function() {
  $("#notificationLink").click(function() {
    $("#notificationContainer").fadeToggle(300);
    $("#notification_count").fadeOut("slow");
    return false;
  });

  //Document Click hiding the popup
  $(document).click(function() {
    $("#notificationContainer").hide();
  });

  //Popup on click
  $("#notificationContainer").click(function() {
    return false;
  });

});


//JQUERU CHAINED SELECTS


// STARS RATING
$(document).ready(function() {
  $('.feedback_stars_rating').raty({
    path: '/assets'
  });
});



// Slideshow 2
$("#slider1").responsiveSlides({
  auto: true,
  pager: true,
  speed: 300,
  maxwidth: 540
});


$(function() {
  return $(document).on('change', '#states_select', function(evt) {
    return $.ajax('update_city_select', {
      type: 'GET',
      dataType: 'script',
      data: {
        state_id: $("#states_select option:selected").val()
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("Dynamic state select OK!");
      }
    });
  });

});



$(function() {
  $(".sort_links a, #content .digg_pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#ransack_search input").keyup(function() {
    $.get($("#ransack_search").attr("action"), $("#ransack_search").serialize(), null, "script");
    return false;
  });
});



$("#query").typeahead({
  name: "product",
  remote: "/products/autocomplete?query=%QUERY"
});



$(function() {
  $("#product_tags").tokenInput("/products/tags.json", {
    prePopulate: $("#product_tags").data("pre"),
    preventDuplicates: true,
    theme: 'mac',
    noResultsText: "No results, needs to be created.",
    animateDropdown: false
  });
});



// $('form').submit(function() {
//   var valuesToSubmit = $(this).serialize();
//   $.ajax({
//   type: "POST",
//   url: $(this).attr('action'), //sumbits it to the given url of the form
//   data: valuesToSubmit,
//   dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
// }).success(function(json){
//     console.log("success", json);
// });
// return false; // prevents normal behaviour
// });


//$(document).ready(
//    function(){
//         $("a.message_link").bind("ajax:success",
//                function(evt, data, status, xhr){
//                     $("#response").html(data); // in case data is html. (_*.html.erb)
//      }).bind("ajax:error", function(evt, xhr, status, error){
//              console.log('server error' + error );
//    });
//});







// GENDER ON PRODUCT




//$(document).ready(function() {
//    $("input[type='radio'][name='product[gender_id]']").click(function() {
//        var gender = $("input[type='radio'][name='product[gender_id]']:checked").val();

//        jQuery.get('/products/update_category_select/' + gender, function(data){
//          $("#productCategories").html(data);


//
//           $('#product_category_id').change(function() {

//                var category = $('select#product_category_id :selected').val();

//                if(category == "") category="0";

//                jQuery.get('/products/update_subcategory_select/' + category, function(data){
//                    $("#productSubcategories").html(data);
//                })
//                return false;
//            });


//        })
//    });


//});
//
//
//
//

