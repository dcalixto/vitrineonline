
    $('#main-nav .main-cat .main-cat-li').on('mouseenter',function(){
        $('#main-nav .main-cat .main-cat-li').removeClass('show-main-sub');
        $(this).addClass('show-main-sub');
        setTimeout(function(){
            $('.hover-overlay').removeClass('hide');
        },20)
    });
    $('#categ-nav-sub ul.main-cat>li:last-of-type').on('hover',function(){
        $('#main-nav .main-cat .main-cat-li').removeClass('show-main-sub');
    });
    var cursorInitLeft = 0;
    $('#categ-nav-sub').on('mousemove',function(e){
        if(cursorInitLeft == 0){
            $('.hover-overlay').addClass('hide');
        } else if(cursorInitLeft < e.pageX){
            $('.hover-overlay').removeClass('hide');
        } else {
           setTimeout(function(){
                $('.hover-overlay').addClass('hide');
            },20)
        }
        cursorInitLeft = e.pageX;
    });
    $('#nav-tab1').on('hover',function(){
        $('#main-nav .main-cat .main-cat-li').removeClass('show-main-sub');
    });



   
