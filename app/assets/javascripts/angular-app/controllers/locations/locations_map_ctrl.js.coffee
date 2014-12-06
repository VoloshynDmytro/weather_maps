@locationsApp.controller("LocationsMapCtrl", ['$scope', '$filter', 'Location', ($scope, $filter, Location) ->
  $scope.locations = []

  $scope.map = {
    center: {
      latitude: 49.55,
      longitude: 24.10
    },
    zoom: 10
  }

  # ng-init binding (Service Call)
  $scope.loadLocations = () ->
    Location.query().then (results) ->
      $scope.locations = results

  # ng-click binding (Service Call)
  $scope.deleteLocation = (location) ->
    location.delete()
    $scope.loadLocations()

  return

])