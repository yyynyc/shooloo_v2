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
//= require best_in_place
//= require rails.validations
//= require rails.validations.formtastic
//= require jquery.jplayer.min
//= require_tree .

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

$(document).ready(function(){
      $("#jquery_jplayer_1").jPlayer({
        ready: function () {
          $(this).jPlayer("setMedia", {
            m4v: "https://fun.shooloo.org/attachments/jplayer/shooloo_home.mp4",
            ogv: "https://fun.shooloo.org/attachments/jplayer/shooloo_home.ogv",
            webmv: "https://fun.shooloo.org/attachments/jplayer/shooloo_home.webm",
            flv: "https://fun.shooloo.org/attachments/jplayer/shooloo_home.flv",
            poster: "https://fun.shooloo.org/attachments/jplayer/shooloo_home_520px.png"
          });
        },
        swfPath: "/x-shockwave-flash",
        supplied: "m4v, ogv, webmv, flv",
      });
    });
$(document).ready(function(){
      $("#video-1").jPlayer({
        ready: function () {
          $(this).jPlayer("setMedia", {
            m4v: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup.mp4",
            ogv: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup.ogv",
            webmv: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup.webm",
            poster: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup_520px.png"
          });
        },
        swfPath: "/x-shockwave-flash",
        supplied: "m4v, ogv, webmv",
      });
    });
$(document).ready(function(){
      $("#video-2").jPlayer({
        ready: function () {
          $(this).jPlayer("setMedia", {
            m4v: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup_teacher.mp4",
            ogv: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup_teacher.ogv",
            webmv: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup_teacher.webm",
            poster: "https://fun.shooloo.org/attachments/jplayer/shooloo_signup_teacher_520px.png"
          });
        },
        swfPath: "/x-shockwave-flash",
        supplied: "m4v, ogv, webmv",
      });
    });
$(document).ready(function(){
      $("#video-3").jPlayer({
        ready: function () {
          $(this).jPlayer("setMedia", {
            m4v: "https://fun.shooloo.org/attachments/jplayer/shooloo_overview.mp4",
            ogv: "https://fun.shooloo.org/attachments/jplayer/shooloo_overview.ogv",
            webmv: "https://fun.shooloo.org/attachments/jplayer/shooloo_overview.webm",
            poster: "https://fun.shooloo.org/attachments/jplayer/shooloo_overview_520px.png"
          });
        },
        swfPath: "/x-shockwave-flash",
        supplied: "m4v, ogv, webmv",
      });
    });
$(document).ready(function(){
      $("#video-4").jPlayer({
        ready: function () {
          $(this).jPlayer("setMedia", {
            m4v: "https://fun.shooloo.org/attachments/jplayer/shooloo_post.mp4",
            ogv: "https://fun.shooloo.org/attachments/jplayer/shooloo_post.ogv",
            webmv: "https://fun.shooloo.org/attachments/jplayer/shooloo_post.webm",
            poster: "https://fun.shooloo.org/attachments/jplayer/shooloo_post_520px.png"
          });
        },
        swfPath: "/x-shockwave-flash",
        supplied: "m4v, ogv, webmv",
      });
    });
$(document).ready(function(){
      $("#video-5").jPlayer({
        ready: function () {
          $(this).jPlayer("setMedia", {
            m4v: "https://fun.shooloo.org/attachments/jplayer/shooloo_comment.mp4",
            ogv: "https://fun.shooloo.org/attachments/jplayer/shooloo_comment.ogv",
            webmv: "https://fun.shooloo.org/attachments/jplayer/shooloo_comment.webm",
            poster: "https://fun.shooloo.org/attachments/jplayer/shooloo_comment_520px.png"
          });
        },
        swfPath: "/x-shockwave-flash",
        supplied: "m4v, ogv, webmv",
      });
    });
jQuery(function() {
  $('.best_in_place').best_in_place();
});
