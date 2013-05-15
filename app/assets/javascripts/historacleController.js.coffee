@HistoracleCtrl = ($scope, $http) ->
  $scope.selected_event
  $scope.timeline =
    event_min: 0
    event_max: 0
    absol_min: 0
    absol_max: 0
    absol_diff: 0
    frame_min: 0
    frame_max: 0
    frame_diff: 0
    major_units: []
    minor_units: []

  $scope.timeline =
    $scope.chronicles_store = {}
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

  $scope.selectEvent = (event) ->
    $scope.setEventToMap(event)
    $scope.setEventToViewer(event)
    $scope.setEventToTimeline(event)

  # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  # Viewer Management

  $scope.setEventToViewer = (event) ->
    slideCarousel(event)

  # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  # Map Management

  $scope.setEventToMap = (event) ->
    HistoracleMap.setView(event)
    bounceMapEvent(event)

  $scope.updateMap = (event) ->
    HistoracleMap.setView(event)
    bounceMapEvent(event)

  # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  # Timeline Management

  $scope.setEventToTimeline = (event) ->
    slideTimeline($scope.getCx(event.start_date))

  $scope.setTimeline = (event) ->
    dates = []
    Object.keys($scope.chronicles).forEach (key) ->
      $scope.chronicles[key].events.forEach (event) ->
        dates.push(event.start_date)

    $scope.timeline.event_min = new Date(Math.min.apply(null, dates))
    $scope.timeline.event_max = new Date(Math.max.apply(null, dates))
    diff = $scope.timeline.event_max.getTime() - $scope.timeline.event_min.getTime()

    $scope.timeline.absol_min = new Date($scope.timeline.event_min.getTime() - diff * .01)
    $scope.timeline.absol_max = new Date($scope.timeline.event_max.getTime() + diff * .01)
    $scope.timeline.absol_diff = $scope.timeline.absol_max.getTime() - $scope.timeline.absol_min.getTime()

    if Object.keys($scope.chronicles).length == 1
      $scope.setFrame($scope.timeline.absol_min, $scope.timeline.absol_max)

    setJQTimeline($scope.timeline)
    $('#timeline-pane').show()

  $scope.setFrame = (min, max) ->
    $scope.timeline.frame_min = min
    $scope.timeline.frame_max = max
    $scope.timeline.frame_diff = max.getTime() - min.getTime()
    $scope.setTimelineUnits(min, max)

  $scope.setTimelineUnits = ->
    del = {}
    major = []
    i = 0

    while i < $scope.units.length
      del = $scope.units[i]
      break if $scope.units[i].base * $scope.units[i].multiple > $scope.timeline.frame_diff
      i++

    low = $scope.dateRound($scope.timeline.frame_min, del)

    while low < $scope.timeline.frame_max
      major.push([new Date(low), del.format]) if low > $scope.timeline.frame_min && low < $scope.timeline.frame_max
      low = new Date(del.major(low))
    $scope.timeline.major_units = major

  $scope.dateRound = (d, del) ->
    if del.base * del.multiple < 12
      d = new Date(1970,0).setFullYear(d.getFullYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds(),d.getMilliseconds())
    else if del.base * del.multiple < 12 * 1000
      d = new Date(1970,0).setFullYear(d.getFullYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes(),d.getSeconds())
    else if del.base * del.multiple < 12 * 60000
      d = new Date(1970,0).setFullYear(d.getFullYear(),d.getMonth(),d.getDate(),d.getHours(),d.getMinutes())
    else if del.base * del.multiple < 12 * 3600000
      d = new Date(1970,0).setFullYear(d.getFullYear(),d.getMonth(),d.getDate(),d.getHours())
    else if del.base * del.multiple < 12 * 86400000
      d = new Date(1970,0).setFullYear(d.getFullYear(),d.getMonth(),d.getDate())
    else if del.base * del.multiple < 12 * 2678400000
      d = new Date(1970,0).setFullYear(d.getFullYear(),d.getMonth())
    else if del.base * del.multiple < 12 * 31536000000
      d = new Date(1970,0).setFullYear(d.getFullYear())
    else
      d = new Date(1970,0).setFullYear(5*Math.floor(d.getFullYear()/5))
    new Date(d)

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}

  $scope.isEmpty = (dictionary) ->
    angular.equals({}, dictionary) || angular.equals([], dictionary)

  $scope.getFill = (id) ->
    color = $scope.chronicles["" + id].color
    return color.hex

  $scope.getLineLabel = (lineObj) ->
    lineObj[1](lineObj[0])

  $scope.getFrameCx = (d) ->

    diff = Math.abs($scope.timeline.frame_max - $scope.timeline.frame_min)
    diff = 1 if diff == 0
    "" + (((d.getTime() - $scope.timeline.frame_min) / diff) * 100).toFixed(6) + "%"

  $scope.getFrameCy = (id) ->
    _id = "" + id
    index = Object.keys($scope.chronicles).indexOf(_id)
    60 - (index * 15)

  $scope.getAbsoluteCx = (d) ->
    x = ((d.getTime() - $scope.timeline.absol_min.getTime()) / $scope.timeline.absol_diff * 100).toFixed(6)
    if x is 0 then "-10%" else "" + x + "%"

  $scope.months = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

  $scope.units = [
#    multiple: 30 # 30 min
#    base: 60 * 1000 # MINUTE
#    major: 5 * 60 * 1000
#    minor: 60 * 1000
#  ,
#    multiple: 1 # 1 hr
#    base: 60 * 60 * 1000 # HOUR
#    major: 5 * 60 * 1000
#    minor: 60 * 1000
#  ,
#    multiple: 3 # 3 hr
#    base: 60 * 60 * 1000 # HOUR
#    major: 30 * 60 * 1000
#    minor: 5 * 60 * 1000
#  ,
#    multiple: 6 # 6 hr
#    base: 60 * 60 * 1000 # HOUR
#    major: 30 * 60 * 1000
#    minor: 5 * 60 * 1000
#  ,
#    multiple: 12 # 12 hr
#    base: 60 * 60 * 1000 # HOUR
#    major: 60 * 60 * 1000
#    minor: 5 * 60 * 1000
#  ,
#    multiple: 1 # 1 day
#    base: 24 * 60 * 60 * 1000 # DAY
#    major: 3 * 60 * 60 * 1000
#    minor: 10 * 60 * 1000
#  ,
    multiple: 3 # 3 day
    base: 24 * 60 * 60 * 1000 # DAY
    major: (d) ->
      if d.getHours() < 6
        d.setHours(6)
      else if d.getHours() < 12
        d.setHours(12)
      else if d.getHours() < 18
        d.setHours(18)
      else
        d.setHours(0)
        d.setDate(d.getDate() + 1)
    format: (d) ->
      if d.getHours() == 6
        "6 AM"
      else if d.getHours() == 12
        "12 PM"
      else if d.getHours() == 18
        "6 PM"
      else if d.getMonth() > 0 || d.getDate() > 1
        "" + $scope.months[d.getMonth()] + " " + d.getDate()
      else
        d.getFullYear()
    minor: 60 * 60 * 1000
  ,
    multiple: 6 # 6 day
    base: 24 * 60 * 60 * 1000 # DAY
    major: (d) ->
      if d.getHours() < 12
        d.setHours(12)
      else
        d.setHours(0)
        d.setDate(d.getDate() + 1)
    format: (d) ->
      if d.getHours() == 12
        "12 PM"
      else if d.getMonth() > 0 || d.getDate() > 1
        "" + $scope.months[d.getMonth()] + " " + d.getDate()
      else
        d.getFullYear()
    minor: 60 * 60 * 1000
  ,
    multiple: 20 # 12 day
    base: 24 * 60 * 60 * 1000 # DAY
    major: (d) -> d.setDate(d.getDate() + 1)
    format: (d) ->
      if d.getMonth() > 0 || d.getDate() > 1
        "" + $scope.months[d.getMonth()] + " " + d.getDate()
      else
        d.getFullYear()
    minor: 3 * 60 * 60 * 1000
  ,
    multiple: 2 # 1 month
    base: 31 * 24 * 60 * 60 * 1000 # Month
    major: (d) ->
      if d.getDate() < 5
        d.setDate(5)
      else if d.getDate() < 10
        d.setDate(10)
      else if d.getDate() < 15
        d.setDate(15)
      else if d.getDate() < 20
        d.setDate(20)
      else if d.getDate() < 25
        d.setDate(25)
      else
        d.setMonth(d.getMonth() + 1)
        d.setDate(1)
    format: (d) ->
      if d.getMonth() > 0 || d.getDate() > 1
        "" + $scope.months[d.getMonth()] + " " + d.getDate()
      else
        d.getFullYear()
    minor: 6 * 60 * 60 * 1000
  ,
    multiple: 3 # 3 month
    base: 31 * 24 * 60 * 60 * 1000 # Month
    major: (d) ->
      if d.getDate() < 10
        d.setDate(10)
      else if d.getDate() < 20
        d.setDate(20)
      else
        d.setMonth(d.getMonth() + 1)
        d.setDate(1)
    format: (d) ->
      if d.getMonth() > 0 || d.getDate() > 1
        "" + $scope.months[d.getMonth()] + " " + d.getDate()
      else
        d.getFullYear()
    minor: 12 * 60 * 60 * 1000
  ,
    multiple: 6 # 6 month
    base: 31 * 24 * 60 * 60 * 1000 # Month
    major: (d) ->
      if d.getDate() < 15
        d.setDate(15)
      else
        d.setMonth(d.getMonth() + 1)
        d.setDate(1)
    format: (d) ->
      if d.getMonth() > 0 || d.getDate() > 1
        "" + $scope.months[d.getMonth()] + " " + d.getDate()
      else
        d.getFullYear()
    minor: 24 * 60 * 60 * 1000
  ,
    multiple: 1 # 1 year
    base: 365 * 24 * 60 * 60 * 1000 # Year
    major: (d) -> d.setMonth(d.getMonth() + 1)
    format: (d) -> if d.getMonth() > 0 then $scope.months[d.getMonth()] else d.getFullYear()
    minor: 3 * 24 * 60 * 60 * 1000
  ,
    multiple: 2 # 2 year
    base: 365 * 24 * 60 * 60 * 1000 # Year
    major: (d) -> d.setMonth(d.getMonth() + 2)
    format: (d) -> if d.getMonth() > 0 then $scope.months[d.getMonth()] else d.getFullYear()
    minor: 3 * 24 * 60 * 60 * 1000
  ,
    multiple: 3 # 3 year
    base: 365 * 24 * 60 * 60 * 1000 # Year
    major: (d) -> d.setMonth(d.getMonth() + 3)
    format: (d) -> if d.getMonth() > 1 then $scope.months[d.getMonth()] else d.getFullYear()
    minor: 7 * 24 * 60 * 60 * 1000
  ,
    multiple: 5 # 5 year
    base: 365 * 24 * 60 * 60 * 1000 # Year
    major: (d) -> d.setMonth(d.getMonth() + 6)
    format: (d) -> if d.getMonth() > 1 then $scope.months[d.getMonth()] else d.getFullYear()
    minor: 14 * 24 * 60 * 60 * 1000
  ,
    multiple: 10 # 10 year
    base: 365 * 24 * 60 * 60 * 1000 # Year
    major: (d) -> d.setFullYear(d.getFullYear() + 1)
    format: (d) -> d.getFullYear()
    minor: 30 * 24 * 60 * 60 * 1000
  ,
    multiple: 25 # 25 year
    base: 365 * 24 * 60 * 60 * 1000 # Year
    major: (d) -> d.setFullYear(d.getFullYear() + 3)
    format: (d) -> d.getFullYear()
    minor: (365 / 5) * 24 * 60 * 60 * 1000
  ,
    multiple: 50 # 50 year
    base: 365 * 24 * 60 * 60 * 1000 # Year
    major: (d) -> d.setFullYear(d.getFullYear() + 5)
    format: (d) -> d.getFullYear()
    minor: (365 / 3) * 24 * 60 * 60 * 1000
  ,
    multiple: 100 # 100 year
    base: 365 * 24 * 60 * 60 * 1000
    major: (d) -> d.setFullYear(d.getFullYear() + 10)
    format: (d) -> d.getFullYear()
    minor: 365 * 24 * 60 * 60 * 1000
  ,
    multiple: 300 # 300 year
    base: 365 * 24 * 60 * 60 * 1000
    major: (d) -> d.setFullYear(d.getFullYear() + 25)
    format: (d) -> d.getFullYear()
    minor: 3 * 365 * 24 * 60 * 60 * 1000
  ,
    multiple: 500 # 500 year
    base: 365 * 24 * 60 * 60 * 1000
    major: (d) -> d.setFullYear(d.getFullYear() + 50)
    format: (d) -> d.getFullYear()
    minor: 5 * 365 * 24 * 60 * 60 * 1000
  ,
    multiple: 1000 # 1000 year
    base: 365 * 24 * 60 * 60 * 1000
    major: (d) -> d.setFullYear(d.getFullYear() + 100)
    format: (d) -> d.getFullYear()
    minor: 10 * 365 * 24 * 60 * 60 * 1000
  ]


setJQTimeline = (timeline) ->
  $("#timeline-framer .content").dateRangeSlider
    arrows: false
    bounds:
      min: timeline.absol_min
      max: timeline.absol_max

    defaultValues:
      min: timeline.frame_min
      max: timeline.frame_max

    valueLabels: "change" #change, hide, show
    delayOut: 0
    durationIn: 0
    durationOut: 500
    formatter: (val) ->
      days = val.getDate()
      month = val.getMonth() + 1
      year = val.getFullYear()
      month + "/" + year
  #         range: {
  #            min: {days: 36500}
  #//            max: {days: 7}
  #         },
  #         step:{
  #            days: 3650
  #         }
    wheelMode: "zoom"
    wheelSpeed: 30

  $("#timeline-framer .content").on "valuesChanging", (e, data) ->
    scope = angular.element($("#dashboard")).scope()
    scope.$apply ->
      scope.setFrame(data.values.min, data.values.max)

  $("#timeline-framer .content").on "valuesChanged", (e, data) ->
    scope = angular.element($("#dashboard")).scope()
    scope.$apply ->
      scope.setFrame(data.values.min, data.values.max)
