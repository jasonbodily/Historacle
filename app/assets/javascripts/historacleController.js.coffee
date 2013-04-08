@HistoracleCtrl = ($scope, $http) ->
  $scope.timeline = {}
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
    chronicle

  $scope.addChronicle = (chronicle) ->
    $scope.chronicles[chronicle.id] = chronicle
    $scope.setEvents()
    HistoracleMap.createChronicleEvents(chronicle)

  $scope.removeChronicle = (id) ->
    chronicle = $scope.chronicles[id]
    delete $scope.chronicles[id]
    $scope.setEvents()
    HistoracleMap.deleteChronicleEvents(chronicle)

  $scope.setEvents = ->
    events = []
    Object.keys($scope.chronicles).forEach (key) ->
      events = events.concat($scope.chronicles[key].events)
    $scope.events = events
    $scope.setTimeline()

  $scope.setTimeline = ->
    dates = []
    $scope.events.forEach (event) ->
      dates.push(event.start_date)
    min_date = new Date(Math.min.apply(null, dates))
    max_date = new Date(Math.max.apply(null, dates))
    $scope.timeline.min_ms = min_date
    $scope.timeline.max_ms = max_date
    $scope.timeline.major_units = [min_date, max_date]
#    $scope.bound_hour(min_milli,max_milli)

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
#
#  $scope.bound_hour = (d1, d2) ->
#    major_lines = []
#    lower = new Date(d1)
#    lower.setMilliseconds(0)
#    lower.setSeconds(0)
#    lower.setMinutes(lower.getMinutes() > 30 ? 30 : 0)
#    $scope.timeline.diff = lower
#
#    upper = new Date(d2)
#    upper.setMilliseconds(0)
#    upper.setSeconds(0)
#    upper.setMinutes(upper.getMinutes() > 30 ? 60 : 30)
#    $scope.timeline.upper_bound = upper
#
#    adj_diff = upper.getMilliseconds() - lower.getMilliseconds()
#    $scope.timeline.diff = adj_diff
#    i;
#    if ((adj_diff / 30*60*1000) > 5)
#      i = 30
#    else if ((adj_diff / 15*60*1000) > 5)
#      i = 15
#    else if ((adj_diff / 10*60*1000) > 10)
#      i = 10
#    else
#      i = 5
#
#    major_unit = new Date(lower)
#    while (major_unit.getMilliseconds() <= upper.getMilliseconds())
#      major_lines.push(major_unit)
#      major_unit.setMinutes(major_unit.getMinutes() + i)
#
##    $scope.timeline.major_units = major_lines
#
  $scope.getOffset = (d) ->
    diff = Math.abs($scope.timeline.max_ms - $scope.timeline.min_ms)
    "" + (((d.getTime()-$scope.timeline.min_ms)/diff)*100).toFixed(4)  + "%"