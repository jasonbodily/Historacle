@HistoracleCtrl = ($scope) ->
  $scope.chronicles = {}
  $scope.events = []

  $scope.addChronicle = (url) ->
    $.getJSON "#{url}.json", (chronicle) ->
      $scope.$apply ->
        $scope.chronicles[chronicle.id] = chronicle
        $scope.events = $scope.events.concat(chronicle.events)

  $scope.removeChronicle = (id) ->
    delete $scope.chronicles[id]

  $scope.showChronicle = (id) ->
    $scope.chronicles[id].display = true

  $scope.hideChronicle = (id) ->
    $scope.chronicles[id].display = false

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push(entry)
    $scope.newEntry = {}



