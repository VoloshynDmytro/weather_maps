@locationsApp.controller("LocationsIndexCtrl", ['$scope', '$filter', 'Location', 'ngTableParams', ($scope, $filter, Location, ngTableParams) ->
  $scope.locations = []

  $scope.tableParams = new ngTableParams(
    page: 1 # show first page
    count: 10 # count per page
    sorting:
      name: "asc" # initial sorting
  ,
    total: 0
    getData: ($defer, params) ->
      $scope.loadLocations().then (result) ->
        params.total result.length
        orderedData = (if params.sorting() then $filter("orderBy")(result, params.orderBy()) else result)
        $defer.resolve orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count())
  )

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