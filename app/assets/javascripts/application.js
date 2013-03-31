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
//= require bootstrap
//= require_tree .

//Initial load of page
$(function() {

   $(document).on('click', ".btn-add-chronicle", function (e) {
      e.preventDefault();
      $.getJSON($(this).attr('href'), function(data) {
         historacle.addChronicle(data);
      });
      return false;
   });

   $(document).on('keyup', ".index-search", function () {
      $.get($(this).attr('action'), $(this).serialize(), null, "script");
      return false;
   });

   $("#index-chronicle-events tr[data-link]").click(function() {
      $.getScript(this.dataset.link);
   });

   $("#index-library-chronicles tr[data-link]").click(function() {
      window.location = this.dataset.link;
   });
});


