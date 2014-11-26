@app.factory "Session", ($location, $http, $q, $rootScope) ->

  # Redirect to the given url (defaults to '/')
  redirect = (url) ->
    url = url or "/"
    $location.path url


  service =
    login: (email, password) ->
      $http.post("/login",
        user:
          email: email
          password: password
      ).then (response) ->
        $rootScope.currentUser = response.data.user
        $location.path "/"  if service.isAuthenticated()
        return


    logout: (redirectTo) ->
      $http.post("/logout").then ->
        $rootScope.currentUser = null
        redirect redirectTo

    register: (email, password, confirm_password) ->
      $http.post("/users.json",
        user:
          email: email
          password: password
          password_confirmation: confirm_password
      ).then (response) ->
        $rootScope.currentUser = response.data
        $location.path "/"  if service.isAuthenticated()
        return


    requestCurrentUser: ->
      if service.isAuthenticated()
        $q.when $rootScope.currentUser
      else
        $http.get("/current_user").then (response) ->
          $rootScope.currentUser = response.data.user
          $rootScope.currentUser

    #currentUser: null
    isAuthenticated: ->
      !!$rootScope.currentUser

  service
