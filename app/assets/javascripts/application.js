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
//= require paypal-button.min
//= require_tree .

$(function ()  
{ $("#tips").popover({trigger: 'hover', placement: 'bottom'});  
});  
$(function ()  
{ $("#follow").popover({trigger: 'hover', placement: 'bottom'});  
}); 
$(function ()  
{ $("#hidden").popover({trigger: 'hover', placement: 'bottom'});  
}); 
$(function ()  
{ $(".like").tooltip({trigger: 'hover', placement: 'bottom'});  
}); 
$(function ()  
{ $(".like_comment").tooltip({trigger: 'hover', placement: 'bottom'});  
});
$(function ()  
{ $(".rate").tooltip({trigger: 'hover', placement: 'bottom'});  
});
$(function ()  
{ $(".comment").tooltip({trigger: 'hover', placement: 'bottom'});  
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