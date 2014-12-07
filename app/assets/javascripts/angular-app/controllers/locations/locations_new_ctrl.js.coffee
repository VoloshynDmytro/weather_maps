@locationsApp.controller("LocationsNewCtrl", ['$scope', '$filter','$log', 'Location', ($scope, $filter, $log, Location) ->
  $scope.location = new Location()

  $scope.map = {
    control: {},
    markersControl: {},
    windowsControl: {},
    center: {
      latitude: 49.55,
      longitude: 24.10
    },
    options: {
      scrollwheel: false
    },
    zoom: 10,
    refresh: () ->
      $scope.map.control.refresh(origCenter)

  }

  $scope.marker =
    id: 0
    coords:
      latitude: 49.55,
      longitude: 24.10

    options:
      draggable: true

    events:
      dragend: (marker, eventName, args) ->
        lat = marker.getPosition().lat()
        lon = marker.getPosition().lng()
        $scope.marker.options =
          draggable: true
          labelContent: "Lat: " + $scope.marker.coords.latitude + " " + "Lon: " + $scope.marker.coords.longitude
          labelAnchor: "100 0"
          labelClass: "marker-labels"
        $scope.$apply()

      drag: (marker, eventName, args) ->
        lat = marker.getPosition().lat()
        lon = marker.getPosition().lng()
        $scope.location.latitude = lat
        $scope.location.longitude = lon


  # ng-init binding (Service Call)
  $scope.loadLocations = () ->
    Location.query().then (results) ->
      $scope.locations = results

  # ng-click binding (Service Call)
  $scope.createLocation = (location) ->
    location.create()
    $scope.loadLocations()

  origCenter = {latitude: $scope.map.center.latitude, longitude: $scope.map.center.longitude}
  return

])