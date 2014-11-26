angular.module('sessionService', []).factory "Session", ($location, $http, $q, $rootScope) ->
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
        service.currentUser = response.data.user
        $location.path "/"  if service.isAuthenticated()
        return

    logout: (redirectTo) ->
      $http.post("/logout").then ->
        service.currentUser = null
        redirect redirectTo

    register: (email, password, confirm_password) ->
      $http.post("/users.json",
        user:
          email: email
          password: password
          password_confirmation: confirm_password
      ).then (response) ->
        service.currentUser = response.data
        $location.path "/"  if service.isAuthenticated()
        return

    getCurrentUser: ->
      service.isAuthenticated or $http.get("/current_user"
      ).success((response) ->
        service.currentUser  = response.data.user
      ).error(->
        $location.path "/users/login"
      )


    currentUser: null
    isAuthenticated: ->
      !!service.currentUser

  service
