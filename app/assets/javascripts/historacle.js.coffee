@HistoracleCtrl = ($scope, $http) ->
  $scope.chronicles = {}
  $scope.events = []

  $scope.getChronicle = (url) ->
    $http.get(url)
      .then (response) ->
        $scope.addChronicle(response.data)

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


