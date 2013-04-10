@HistoracleCtrl = ($scope, $http) ->
  $scope.timeline =
    min_ms: 0
    max_ms: 0
  $scope.chronicles = {}
  $scope.events = []

  $scope.getChronicle = (url) ->
    $http.get(url)
      .then (response) ->
        chronicle = response.data
        if !$scope.chronicles[chronicle.id]
          chronicle = $scope.cleanChronicle(chronicle)
          $scope.addChronicle(chronicle)

  $scope.cleanChronicle = (chronicle) ->
    chronicle.events.forEach (event)  ->
      start = new Date(Date.parse(event.start_date))
      event.start_date = new Date(start.getTime() + start.getTimezoneOffset() * 60000);
      end = new Date(Date.parse(event.end_date))
      event.end_date = new Date(end.getTime() + end.getTimezoneOffset() * 60000);
    chronicle.color = getColor()
    chronicle

  $scope.addChronicle = (chronicle) ->
    length = $scope.events.length
    chronicle.events.forEach (event) ->
      $scope.events.push(event)
    $scope.chronicles[chronicle.id] = chronicle
    $scope.setTimeline()
    HistoracleMap.createChronicleEvents(chronicle)
#    if length == 0 && $scope.events.length > 0
#      console.log($scope.events[0])
      #$scope.selectEvent($scope.events[0])

  $scope.removeChronicle = (id) ->
    $scope.events = []
    delete $scope.chronicles[id]
    Object.keys($scope.chronicles).forEach (key) ->
      $scope.chronicles[key].events.forEach (event) ->
        $scope.events.push(event)
    $scope.setTimeline()
    HistoracleMap.deleteChronicleEvents(id)

  $scope.setTimeline = ->
    dates = []
    Object.keys($scope.chronicles).forEach (key) ->
      $scope.chronicles[key].events.forEach (event) ->
        dates.push(event.start_date)
    $scope.timeline.min_ms = new Date(Math.min.apply(null, dates))
    $scope.timeline.max_ms = new Date(Math.max.apply(null, dates))
    $scope.timeline.major_units = [$scope.timeline.min_ms, $scope.timeline.max_ms]
  #$scope.bound_hour(min_milli,max_milli)

  $scope.selectEvent = (event) ->
    slideCarousel(event)
    slideTimeline($scope.getCx(event.start_date))
    bounceMapEvent(event)
    HistoracleMap.setView(event)

  $scope.showChronicle = (id) ->
    $scope.chronicles[id].display = true

  $scope.hideChronicle = (id) ->
    $scope.chronicles[id].display = false

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}

  $scope.isEmpty = (dictionary) ->
    angular.equals({}, dictionary) || angular.equals([], dictionary)

  $scope.getCx = (d) ->
    diff = Math.abs($scope.timeline.max_ms - $scope.timeline.min_ms)
    "" + (((d.getTime()-$scope.timeline.min_ms)/diff)*100).toFixed(4)  + "%"

  $scope.getCy = (id) ->
    _id = "" + id
    index = Object.keys($scope.chronicles).indexOf(_id)
    60-(index*15)

  $scope.getFill = (id) ->
    color = $scope.chronicles["" + id].color
    return color.hex


