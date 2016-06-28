$(document).ready ->
  $("#posts .page").infinitescroll
    navSelector: ".pagination" # selector for the paged navigation (it will be hidden)
    nextSelector: ".pagination a[rel=next]" # selector for the NEXT link (to page 2)
    itemSelector: "#posts tr.post" # selector for all items you'll retrieve
  $(window).scroll()
