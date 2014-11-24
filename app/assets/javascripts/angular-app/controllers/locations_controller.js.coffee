@app.controller("LocationsController", ['$scope', ($scope) ->
  $scope.testMessage = "Welcome to Locations"
  $scope.locations = []
  ###
  # ng-init binding (Service Call)
  $scope.loadLocations = () ->
    Location.query().then (results) ->
      $scope.locations = results

  # ng-click binding (Service Call)
  $scope.deleteLocation = (location) ->
    location.delete()
    $scope.loadLocations()

  # ng-click binding (Service Call)
  $scope.updateLocation = (location) ->
    location.update()
    $scope.loadLocations()

  # ng-click binding (Service Call)
  $scope.createLocation = (location) ->
    location.create()
    $scope.loadLocations()

  # ng-click binding (Local Operation)
  $scope.createNewLocation = () ->
    $scope.locations.push(new Sample())
  ###

])