@app.controller("HomeController", ['$scope', 'Session', ($scope, Session) ->
  #console.log Session.requestCurrentUser()
  Session.requestCurrentUser().then (user) ->
   $scope.user = user

  $scope.logout = ->
    Session.logout "/"

])