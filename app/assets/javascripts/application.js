// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jsapi
//= require bootstrap-sprockets
//= require turbolinks
//= require bootstrap
//= require bootstrap-switch.min
//= require chosen.proto
//= require chosen.jquery
//= require_tree .
//= require links


$(document).ready(function() {
  if ($('.pagination').length > 0 && $('#links-list').length > 0 ) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href');
         if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
          $('.pagination').html("<img src= 'load.gif' style='margin-bottom: 10px; margin-left: 400px'/>");
          return $.getScript(url);
          }
        });
      return $(window).scroll();
  }
});