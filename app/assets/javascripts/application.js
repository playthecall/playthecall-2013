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
//= require jquery_ujs
//= require_tree .

$(function(){
  $('li.settings').mouseleave(function(e) {
    var drop = $(this).next('ul');
    $(this).removeClass('active')
    $(this).find('ul').fadeOut();
  });
  $('li.settings').mouseenter(function(e) {
    var drop = $(this).next('ul');
    $(this).addClass('active')
    $(this).find('ul').fadeIn();
  });
  $('li.settings > a').click(function(e) {

    var drop = $(this).next('ul');
    $(this).next('ul').fadeToggle();
    $(this).parent().toggleClass('active')
    $(document).click(function(e) {
      $(document).unbind('click');
      $('li.settings ul').fadeOut();
      e.preventDefault();
    });
    e.stopPropagation();
  });
})
