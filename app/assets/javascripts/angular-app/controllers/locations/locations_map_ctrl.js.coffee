@locationsApp.controller("LocationsMapCtrl", ['$scope', '$filter', '$timeout', 'Location', ($scope, $filter,$timeout, Location) ->
  $scope.locations = []

  $scope.map = {
    control: {},
    markersControl: {},
    windowsControl: {},
    center: {
      latitude: 49.55,
      longitude: 24.10
    },
    zoom: 10,
    refresh: () ->
      $scope.map.control.refresh(origCenter)

  }

  $scope.onMarkerClicked = (marker) ->
    $scope.zoomToMarker(marker)
    $scope.$apply()

  $scope.showInfo = (location) ->
    #$scope.map.markers = $scope.map.markersControl.getGMarkers()
    #marker = $filter('getByProperty')('key', location.id, $scope.map.markers );
    $scope.zoomToMarker(location)

  $scope.zoomToMarker = (marker) ->
    $scope.map.control.refresh({latitude: marker.latitude, longitude: marker.longitude})
    $scope.map.control.getGMap().setZoom(13)
    marker.showWindow = true


  # ng-init binding (Service Call)
  $scope.loadLocations = () ->
    Location.query().then (results) ->
      $scope.locations = results

  # ng-click binding (Service Call)
  $scope.deleteLocation = (location) ->
    location.delete()
    $scope.loadLocations()

  origCenter = {latitude: $scope.map.center.latitude, longitude: $scope.map.center.longitude}
  return

])