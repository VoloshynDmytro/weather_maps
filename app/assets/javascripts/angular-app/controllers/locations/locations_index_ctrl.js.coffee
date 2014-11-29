@locationsApp.controller("LocationsIndexCtrl", ['$scope', '$filter', 'Location', 'ngTableParams', ($scope, $filter, Location, ngTableParams) ->
  $scope.testMessage = "Welcome to Locations"
  $scope.locations = []

  #$scope.$watch "locations", (locs) ->
  #  $scope.locations = locs

  $scope.tableParams = new ngTableParams(
    console.log $scope.locations
    page: 1 # show first page
    count: 10 # count per page
    sorting:
      name: "asc" # initial sorting
  ,
    total: $scope.locations.length # length of data
    getData: ($defer, params) ->
      # use build-in angular filter
      orderedData = (if params.sorting() then $filter("orderBy")($scope.locations, params.orderBy()) else $scope.locations)
      $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
      return
  )

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
    $scope.locations.push(new Location())

  return

])