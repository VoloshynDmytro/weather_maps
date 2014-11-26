@app.controller("AppController", ['$scope', 'Session', ($scope, Session) ->
  $scope.$on "event:unauthorized", (event) ->
    console.log "unauthorized"
    return

  $scope.$on "event:authenticated", (event) ->
    console.log "authenticated"
    return

])