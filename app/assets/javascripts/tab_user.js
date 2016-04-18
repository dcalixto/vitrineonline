
$(document).ready(function() {
$("#tab_user .nav a.tab").click(function(e) {
     $("#tab_container .nav li a").removeClass("selected");
     $(this).addClass("selected");
     $("#tab_container .nav_section").append('<div class="progress"><img src="/images/fancybox_loading.gif" width="32" height="32" alt="" /></div>');
     $.getScript(this.href);
     if (history && history.replaceState) {
       history.replaceState(null, document.title, this.href);
     }
     e.preventDefault();
   });
});
