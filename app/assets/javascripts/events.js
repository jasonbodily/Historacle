$(function () {
   $(document).on('click', '.submit-geocode', function (e) {
      e.preventDefault();
      address = $('.geocode-input').val();
      typeof geocoder === 'undefined' ? geocoder = new google.maps.Geocoder() : geocoder;
      geocoder.geocode({ 'address':address}, function (results, status) {
         if (status == google.maps.GeocoderStatus.OK) {
            updateGeoFields(results);
            return false;
         }
      });
   });

   $(document).on('blur', '.geocode-input', function () {
      var address = $('.geocode-input').val();
      typeof geocoder === 'undefined' ? geocoder = new google.maps.Geocoder() : geocoder;

      geocoder.geocode({ 'address':address}, function (results, status) {
         if (status == google.maps.GeocoderStatus.OK) {
            updateGeoFields(results);
            return false;
         }
      });
   });

   function updateGeoFields(results) {
      var lat = results[0].geometry.location.lat(),
         lng = results[0].geometry.location.lng();
      $('#event_longitude').val(results[0].geometry.location.lng());
      $('#event_latitude').val(results[0].geometry.location.lat());
      $('#event_location').val(results[0].formatted_address);
      if (lat && lng) {
         updateMap(mapUrl([lat,lng]));
      }
   }

   function mapUrl(coords) {
      return "http://maps.google.com/maps/api/staticmap?" + $.param({
         size:"300x150",
//         maptype:"roadmap",
         sensor:"false",
         center:coords.join(','),
         zoom:12,
//         style:"feature:all|element:all|saturation:-100",
         markers:"" + coords.join(',')
      });
   }

   function updateMap(src) {
      $('.event-map > span > img').attr('src', src);
      $('.event-map > span > img').load(function(){
         if ($('.event-map').css('display') == "none") {
            $('.event-map').slideDown("slow");
         }
      });
   }

   function showSpinner() {
      $('#search-button').hide();
      $('#spinner').show();
   }

   function hideSpinner() {
      $('#search-button').show();
      $('#spinner').hide();
   }

})