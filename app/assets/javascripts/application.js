//= require jquery_ujs
//= require jquery.timeago
//= require private_pub
//= require morris.min
//= require raphael.min
//= require jquery.fancybox.pack
//= require jquery.raty
//= require typeahead
//= require jquery.tokeninput
//= require jquery.webui-popover
//= require lightslider.min
//= require jquery-dynamic-selectable
//= require select2
//= require social-share-button
//= require dropzone
//= require simplemde.min
//= require_tree .




// SELECT2 (TAGS)
$(document).ready(function() {
  $('#product_tags').select2({
    tags: true
  })
});

// WEBUI-POPOVER




$(document).ready(function() {
$('.ttooltip').webuiPopover({
  type: 'async',
  /*url:'/feedbacks/links',*/
  padding: false,
  cache: false,


});
});
$(document).ready(function() {
$('.ttooltip2').webuiPopover({
  trigger: 'hover',
  padding: false,
  cache: false,


});
});



// LIGHTSLIDER

$(document).ready(function() {
  $(".content-slider").lightSlider({
    loop: true,
    keyPress: true,
    auto: true

  });
});

$(document).ready(function() {
  $(".box-slider").lightSlider({
    loop: true,
    keyPress: true,
    auto: true,
    item: 1,
  });
});

$(document).ready(function() {
  $(".content-slider-vertical").lightSlider({
    loop: true,
    vertical: true,
    verticalHeight: 500,
    auto: true,
    pager: false


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


// SimpleMDE-EDITOR


$(document).ready(function() {
var simplemde = new SimpleMDE({ element: document.getElementById("vitrine_about"),
showIcons: ["table", "horizontal-rule"],
hideIcons: ["guide"],
spellChecker: false,
toolbarTips: false,

 });
});
$(document).ready(function() {
var simplemde = new SimpleMDE({ element: document.getElementById("vitrine_garantia"),

showIcons: ["table", "horizontal-rule"],
hideIcons: ["guide"],
spellChecker: false,
toolbarTips: false,


 });
});


$(document).ready(function() {
var simplemde = new SimpleMDE({ element: document.getElementById("vitrine_anuncio"),

showIcons: ["table", "horizontal-rule"],
hideIcons: ["guide"],
spellChecker: false,
toolbarTips: false,


 });
});





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


// CHARTS
$(document).ready(function() {
  if (typeof(draw_chart) != 'undefined')
    draw_chart();
  if (typeof(chart_options) != 'undefined' && $('#chart_options').length > 0)
    $('#chart_options').change(chart_options);
});


// STARS RATING
$(document).ready(function() {
  $('.feedback_stars_rating').raty({
    path: '/assets'
  });
});


// FILE UPLOAD


$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;


	var avatarDropzone = new Dropzone (".dropzone", {
		maxFilesize: 2, // Set the maximum file size to 256 MB
     maxFiles: 1,
      dictDefaultMessage: "Solte suas imagens aqui",
		paramName: "user[avatar]", // Rails expects the file upload to be something like model[field_name]
		addRemoveLinks: true, // Don't show remove links on dropzone itself.
   dictRemoveFile: 'Remover'
  });

	//dropzone.on("success", function(file) {
	//	this.removeFile(file)
		/*$.getScript("/edit")*/
	//})


  var logoDropzone = new Dropzone (".dropzone", {
		maxFilesize: 2, // Set the maximum file size to 256 MB
     maxFiles: 1,
      dictDefaultMessage: "Solte suas imagens aqui",
		paramName: "vitrine[logo]", // Rails expects the file upload to be something like model[field_name]
		addRemoveLinks: true, // Don't show remove links on dropzone itself.
   dictRemoveFile: 'Remover'
  });

  //dropzone.on("success", function(file) {
  //	this.removeFile(file)
    /*$.getScript("/edit")*/
  //})

  var bannerDropzone = new Dropzone (".dropzone", {
		maxFilesize: 2, // Set the maximum file size to 256 MB
     maxFiles: 3,
      dictDefaultMessage: "Solte suas imagens aqui",
		paramName: "banner[img]", // Rails expects the file upload to be something like model[field_name]
		addRemoveLinks: true, // Don't show remove links on dropzone itself.
   dictRemoveFile: 'Remover'
  });


});

$('#banner').dropzone({// PDF dropzone element
  maxFilesize: 2, // Set the maximum file size to 256 MB
   maxFiles: 3,
    dictDefaultMessage: "Solte suas imagens aqui",
  paramName: "banner[img]", // Rails expects the file upload to be something like model[field_name]
  addRemoveLinks: true, // Don't show remove links on dropzone itself.
 dictRemoveFile: 'Remover'
    // rest of code
});

// CUSTOM FORM SUBMIT
$(document).ready(function() {
  $('a[data-submit-form]').click(function(e) {
    e.preventDefault();
    $(this).closest('form').attr('action', $(this).attr('href')).submit();
  });
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




// USER-SELECT-CITY
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


// PAGINTAION AND RANSACK
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


// SEARCH AUTOCOMPLETE
$("#query").typeahead({
  name: "product",
  remote: "/products/autocomplete?query=%QUERY"
});


// TOKEN INPUT TAGS

$(function() {
  $("#product_tags").tokenInput("/products/tags.json", {
    prePopulate: $("#product_tags").data("pre"),
    preventDuplicates: true,
    theme: 'mac',
    noResultsText: "No results, needs to be created.",
    animateDropdown: false
  });
});
