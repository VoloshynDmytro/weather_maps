@app.controller("HomeController", ['$scope', 'Session', ($scope, Session) ->
  #console.log Session.requestCurrentUser
  # for get data after http service
  #Session.requestCurrentUser().then (user) ->
  # $scope.user = user

  $scope.logout = ->
    Session.logout "/"

])