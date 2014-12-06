@app.controller("AppController", ['$scope', 'Session', '$location', '$rootScope', ($scope, Session, $location, $rootScope) ->
  $scope.sessionService = Session
  $scope.sessionService.getCurrentUser().then (user) ->
    $scope.user = user

  $scope.$watch "sessionService.currentUser", (user) ->
    $scope.user = user

  #$rootScope.$watch "currentUser", (newVal) ->
  #  $scope.user = newVal

  $scope.isActive = (route) ->
    route is $location.path()

  $scope.logout = ->
    Session.logout "/"

])