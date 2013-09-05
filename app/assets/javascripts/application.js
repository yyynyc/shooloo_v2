// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require fancybox 
//= require jquery_ujs
//= require bootstrap
//= require rails.validations
//= require rails.validations.formtastic
//= require_tree .

$(function ()  
{ $(".like").tooltip({trigger: 'click', placement: 'bottom'});  
}); 
$(function ()  
{ $(".like_comment").tooltip({trigger: 'click', placement: 'bottom'});  
});
$(function ()  
{ $(".rate").tooltip({trigger: 'click', placement: 'bottom'});  
});
$(function ()  
{ $(".comment").tooltip({trigger: 'click', placement: 'bottom'});  
});
$(function ()  
{ $(".question").popover({trigger: 'click', placement: 'left', html: true});  
});
$(function ()  
{ $(".post").popover({trigger: 'click', placement: 'right', html: true});  
});
$(function ()  
{ $(".follow").popover({trigger: 'click', placement: 'bottom', html: true});  
});
jQuery(function() {
  $("a.fancybox").fancybox();
});
setTimeout(function(){
    $('.progress .bar').each(function() {
        var me = $(this);
        var perc = me.attr("data-percentage");
        var current_perc = 0;
        var progress = setInterval(function() {
            if (current_perc>=perc) {
                clearInterval(progress);
            } else {
                current_perc +=1;
                me.css('width', (current_perc)+'%');
            }
            me.text((current_perc)+'%');
              }, 5);
          });
    },50);
!function ($) {
    $(function(){
        // Fix for dropdowns on mobile devices
        $('body').on('touchstart.dropdown', '.dropdown-menu', function (e) { 
            e.stopPropagation(); 
        });
        $(document).on('click','.dropdown-menu a',function(){
            document.location = $(this).attr('href');
        });
    })
}(window.jQuery)