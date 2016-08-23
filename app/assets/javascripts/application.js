//= require jquery_ujs
//= require jquery.timeago
//= require private_pub
//= require morris.min
//= require raphael.min
//= require jquery.fancybox.pack
//= require jquery.raty
//= require jquery.tokeninput
//= require jquery.tipsy
//= require jquery-dynamic-selectable
//= require select2
//= require social-share-button
//= require dropzone
//= require respond.min
//= require url.min
//= jquery.menu-aim
//= Markdown.Converter
//= Markdown.Editor
//= Markdown.Sanitizer
//= stretchtext
//= dropzone_banner
//= user_banner
//= readmore
//= tipsy
//= require js.cookie
//= require jquery.bettertabs.min
//= require nprogress

//= require jquery.liquidcarousel
//= pagination
//= jquery.infinitescroll
//= require_tree .




$(document).ready(function() {
NProgress.configure({ showSpinner: false });

NProgress.start();
NProgress.done(); 


});



$(document).ready(function() {
$('vitrine_about').readmore({
  speed: 75,
  moreLink: '<a href="#">Ler Mais</a>'

});

});

// TWITTER OAUTH
$(document).ready(function() {
    $('#product_is_shared_on_twitter').click(function (e) {
        var checkbox = $(this);
        if(checkbox.is(':checked')) {
            if(document.cookie.indexOf('twitter_auth_token') == -1 || document.cookie.indexOf('twitter_auth_secret') == -1)
              window.open('/auth/twitter', '_blank', "scrollbars=1,resizable=1,height=500,width=650");
        }
    });
});

// PRODUCT SEARCH ORDER BY
$(document).ready(function() {
   $('#order_by').change(function() {
       var url = new Url;
       url.query.order_by = $(this).val();
       window.location = url.toString();
   });
});

$(document).ready(function() {
    $('.user_nav li a').tipsy({gravity: 'n'});
});

// CHANGE ORDER QUANTITY
$(document).ready(function() {
    $('.select_order_quantity').bind('change', function() {
        $.ajax({
                url: '/orders/' + $(this).data('order-id'),
                type: 'PUT',
                data: {
                    'order[quantity]': $(this).val()
                },
                success: function (response) {
                    if(response.success)
                      window.location.reload();
                }
            }
        );
    });
});




// FRONT PAGE TABS
$(document).ready(function() {
$("#main-nav").menuAim({
    rowSelector: "li.parentnav",
    submenuDirection: "below",

    tolerance: 0,
    exitMenu: function(){return true;},
    activate: function(a){
        $(a).children('.subnav').show();
    },
    deactivate: function(a){
        $(a).children('.subnav').hide();
    }
});
});


// SELECT2 (TAGS)
$(document).ready(function() {
  $('#product_tags').select2({
    tags: true
  })
});


$(document).ready(function() {
  $(".brand_list").select2();
  tags: true
});
// LIGHTSLIDER





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

  $("#user_avatar_dropzone").dropzone({
    maxFilesize: 2, // Set the maximum file size to 256 MB
    maxFiles: 1,
    dictDefaultMessage: "Solte suas imagens aqui",
	paramName: "user[avatar]", // Rails expects the file upload to be something like model[field_name]
	addRemoveLinks: true, // Don't show remove links on dropzone itself.
    dictRemoveFile: 'Remover',
    acceptedFiles: "image/*"
  });

	//dropzone.on("success", function(file) {
		//this.removeFile(file)
		//$.getScript("/edit")
//	})


  $("#vitrine_logo_dropzone").dropzone({
    maxFilesize: 2, // Set the maximum file size to 256 MB
    maxFiles: 1,
    dictDefaultMessage: "Solte suas imagens aqui",
    paramName: "vitrine[logo]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: true, // Don't show remove links on dropzone itself.
    dictRemoveFile: 'Remover',
    acceptedFiles: "image/*"
  });

  //dropzone.on("success", function(file) {
  //	this.removeFile(file)
    /*$.getScript("/edit")*/
  //})



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



//JQUERU CHAINED SELECTS




// PAGINTAION AND RANSACK
$(function() {
  $(".sort_links, #content .digg_pagination").on('click', 'a', function() {
    $.getScript(this.href);
    return false;
  });
  $("#ransack_search input").keyup(function() {
    $.get($("#ransack_search").attr("action"), $("#ransack_search").serialize(), null, "script");
    return false;
  });
});


// SEARCH AUTOCOMPLETE




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


// MARKDOWN TEXT

  if ($(".wmd-input").length > 0) {
      var converter = new Markdown.Converter();

      var editors = [];
      var i = 0;

      $(".wmd-input").each(function() {
          editors[i] = new Markdown.Editor(converter, "");
          editors[i].run();
          i = i + 1;
      });
  }



jQuery('.bettertabs').bettertabs();





$(document).ready(function() {
	$('.vitrine_carousel').liquidcarousel({
		height: 170,		//the height of the list
		duration: 100,		//the duration of the animation
		hidearrows: false	//hide arrows if all of the list items are visible
	});
});




$(document).ready(function() {
	$('.sugestion_carousel').liquidcarousel({
		height: 170,		//the height of the list
		duration: 100,		//the duration of the animation
		hidearrows: false	//hide arrows if all of the list items are visible
	});
});




$(document).ready(function() {
	$('.similar_carousel').liquidcarousel({
		height: 170,		//the height of the list
		duration: 100,		//the duration of the animation
		hidearrows: false	//hide arrows if all of the list items are visible
	});
});





