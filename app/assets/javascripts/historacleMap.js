$(function () {
   (function (window) {

      function historacleMap(map_id) {
         var
            map_id = map_id,
            cloudmadeAttribution = '',
            cloudmadeUrl = 'http://{s}.tile.cloudmade.com/06b9e7be60cf41f290a310df8248d1dd/{styleId}/256/{z}/{x}/{y}.png',
            minimal = L.tileLayer(cloudmadeUrl, {styleId:22677, attribution:cloudmadeAttribution}),
            layers = {},
            map = L.map(map_id, {
               center:new L.LatLng(20, 5),
               zoom:3,
               layers:[minimal]
            });

         this.getMap = function() {
            return map
         }

         this.renderMap = function() {
            return map_id
         }

         this.setView = function(event) {
            var map = this.getMap(),
               bounds = map.getBounds(),
               map_height = bounds._southWest.lat - bounds._northEast.lat,
               map_width = bounds._northEast.lng - bounds._southWest.lng;

            w = $('#map').width();
            h = $('#map').outerHeight();

            block_height = $('#timeline-wrapper').outerHeight() + 20;
            block_width = $('#viewer-wrapper').outerWidth();

            adj_height = ((.5*block_height)/h)*map_height
            adj_width = ((.5*block_width)/w)*map_width

            map.setView([parseFloat(event.latitude)+adj_height, parseFloat(event.longitude)+adj_width], map._zoom)
         }

         this.createChronicleEvents = function(chronicle) {
            var markers = this.createMarkersLayer(chronicle.events, {color: chronicle.color}),
               layer = L.layerGroup(markers);
            layer.addTo(map);
            this.recordLayer(chronicle.id, layer)
         }

         this.deleteChronicleEvents = function(id) {
            var layer = this.deleteLayer(id);
         }

         this.recordLayer = function(chronicle_id, layer) {
            layers[chronicle_id] = layer;
         }

         this.deleteLayer = function(chronicle_id) {
            map.removeLayer(layers[chronicle_id]);
            delete layers[chronicle_id]
         }

         this.retrieveLayer = function(chronicle_id) {
            return layers[chronicle_id]
         }
      }

      historacleMap.prototype = {

         addChronicle: function() {

         },

         createMarkersLayer: function (locations, options) {
            var me = this,
               markers = [];
            locations.forEach(function(event){
               markers.push(me.createMarker(event, options));
            })
            return markers;
         },

         createMarker: function (event, options) {
            var iconURL = options.color.img_url;
            var icon = L.icon({
               iconUrl: iconURL,
               // shadowUrl: 'leaf-shadow.png',
               iconSize:[32, 32], // size of the icon
               iconAnchor:[16, 32], // point of the icon which will correspond to marker's location
               popupAnchor:[-0, -30] // point from which the popup should open relative to the iconAnchor
            });

            return L.marker([event.latitude, event.longitude], options={icon: icon, title: event.title, id: "map-event-" + event.id});
         }
      }

      window.HistoracleMap = new historacleMap('map');
   })(window);
});