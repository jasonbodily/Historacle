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
//= require jquery-ui
//= require jquery_ujs
//= require jQDateRange
//= require jQDateRangeRuler
//= require bootstrap
//= require events
//= require chronicles
//= require libraries

$(function () {
//
//   $(document).on('keyup', ".index-search", function () {
//      $.getJSON($(this).attr('action'), function(chronicles) {
//         var $rootScope = angular.injector(['ng']).get('$rootScope');
//         $rootScope.$apply(function() {
//            listedChronicles = chronicles;
//         });
//      });
//      return false;
//   });

   $(document).on('click', '.pagination a', function () {
      $.rails.handleRemote($(this));
      return false;
   });

   $(document).on('click', "#index-chronicle-events tr[data-link]", function () {
      $.getScript(this.dataset.link);
      return false;
   });

   $(document).on('click',"#index-library-chronicles tr[data-link]", function () {
      window.location = this.dataset.link;
      return false;
   });

   $(document).on('click',".icon-upload", function () {
      $('#featured-event').html($('.hidden-event-import').html());
      return false;
   });


});

