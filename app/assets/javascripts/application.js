//= require jquery.raty
//= require private_pub
//= require jquery.tipsy
//= require jquery-dynamic-selectable
//= Markdown.Converter
//= Markdown.Editor
//= Markdown.Sanitizer
//= stretchtext
//= dropzone_avatar
//= dropzone_images
//= dropzone_logo
//= require social-share-button
//= require jquery.bettertabs.min
//= require url.min
//= require jquery.liquidcarousel
//= jquery.shorten
//= dropit
//= require selectize

//= require_tree .



jQuery(function($) {
  $('script').attr('defer', 'defer');
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

//TIP

$(document).ready(function() {
    $('.user_nav li a').tipsy({gravity: 'n'});
});


$(document).ready(function() {
    $('#shopcart a').tipsy({gravity: 'n'});
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









$('#product_tags').selectize({
    delimiter: ',',
    persist: false,
    create: function(input) {
        return {
            value: input,
            text: input
        }
    }
});


$('#brand_list').selectize({
    create: true,
    sortField: 'text'
});





// PRODUCT IMAGE THUMBNAILS, GALLERY AND ZOOM


$('.thumbnail').on("click", function(e) {
$('#mainImage').hide();
var i = $('<img />').attr('src', $(this).data('href')).load(function() {
$('#mainImage').attr('src', i.attr('src')).fadeIn();
console.log('changed');
});
e.preventDefault();
return false;
});


// ZOOM PLACEHOLDER IMG

$("#big_img a").click( function() {

     window.location = $(this).children('img').attr('src');
     return false;
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





// ANNOUNCEMENT

function hideAnnouncement(announcement_created_at) {
  createCookie(announcement_created_at, 'hidden', 365);
  $("#announcement").slideUp();
}


//PRODUCT_ADD TAB





 $(document).ready(function () {
            var $tabs = $('#horizontalTab');
           $tabs.responsiveTabs({
                rotate: false,
               startCollapsed: 'false',
               collapsible: 'false',
               
           
               click: function(e, tab) {
                  $('.info').html('Tab <strong>' + tab.id + '</strong> clicked!');
                },
                activate: function(e, tab) {
                  $('.info').html('Tab <strong>' + tab.id + '</strong> activated!');
                },
                activateState: function(e, state) {
                    
                    $('.info').html('Switched from <strong>' + state.oldState + '</strong> state to <strong>' + state.newState + '</strong> state!');
                }
            });

        });







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







$(document).ready(function() {
	
	
	$(".filtro").shorten({
            
            showChars: 500,
            moreText: 'Mais',
            lessText: 'Menos',
            ellipsesText: ''
        });

 });



//$(document).ready(function() {
  /* Activating Best In Place */
//  jQuery(".best_in_place").best_in_place();
//});

