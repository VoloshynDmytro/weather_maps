@locationsApp.controller("LocationsMapCtrl", ['$scope', '$filter', 'Location', ($scope, $filter, Location) ->
  $scope.locations = []



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