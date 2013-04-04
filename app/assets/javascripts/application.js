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
//= require angular
//= require_tree .

//Initial load of page

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



   $("#index-chronicle-events tr[data-link]").click(function () {
      $.getScript(this.dataset.link);
   });

   $("#index-library-chronicles tr[data-link]").click(function () {
      window.location = this.dataset.link;
   });
});


