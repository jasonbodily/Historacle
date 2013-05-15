//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jQDateRange
//= require jQDateRangeRuler
//= require bootstrap
//= require angular.min
//= require timeline
//= require leaflet
//= require historacleController
//= require historacleMap

(function () {

   var index = -1,
      options = [
         {hex: "#FF9999", img_url: "/images/pin-red.png"},
         {hex: "#99CCFF", img_url: "/images/pin-blue.png"},
         {hex: "#FFCC00", img_url: "/images/pin-orange.png"},
         {hex: "#99FF00", img_url: "/images/pin-green.png"},
         {hex: "#CC66FF", img_url: "/images/pin-violet.png"}
      ];

   getColor = function (){
      index = index + 1;
      return options[index % options.length];
   }

})();

$(function() {
   slideTimeline = function(width){
      $('#timeline-line .indicator').animate({left: width});
   }

   slideCarousel = function(event){
      var index = $('#view-event-'+ event.id).index();
      $('.carousel').carousel(index)
   }

   bounceMapEvent = function(event) {
      $("#map-event-"+event.id).effect("bounce", { times:2 }, 1000);
   }
});
