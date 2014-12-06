angular.module('sessionService', []).factory "Session", ($location, $http, $q, $rootScope) ->
  # Redirect to the given url (defaults to '/')
  redirect = (url) ->
    url = url or "/"
    $location.path url

  service =
    login: (email, password) ->
      $http.post("/api/login",
        user:
          email: email
          password: password
      ).then (response) ->
        service.currentUser = response.data.user
        $location.path "/"  if service.isAuthenticated()
        return

    logout: (redirectTo) ->
      $http.post("/api/logout").then ->
        service.currentUser = null
        $rootScope.currentUser = null
        redirect(redirectTo)
        return

    register: (email, name, password, confirm_password) ->
      $http.post("/users.json",
        user:
          email: email
          name: name
          password: password
          password_confirmation: confirm_password
      ).then (response) ->
        service.currentUser = response.data
        $location.path "/"  if service.isAuthenticated()
        return

    getCurrentUser: ->
      if service.isAuthenticated()
        #wrapping object in promise
        return $q.when(service.currentUser)
      else
        $http.get("/api/current_user"
        ).then ((response) ->
          service.currentUser  = response.data.user
        ), (error) ->
          $q.reject(error)

    currentUser: null
    isAuthenticated: ->
      !!service.currentUser

  service
