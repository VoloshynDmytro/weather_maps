@app = angular.module('app', [
  # additional dependencies here, such as restangular
  'ngRoute', 'templates', 'ui.bootstrap'
])

# for compatibility with Rails CSRF protection
@app.config([
  '$httpProvider', ($httpProvider)->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    interceptor = [
      "$location"
      "$rootScope"
      "$q"
      ($location, $rootScope, $q) ->
        success = (response) ->
          response
        error = (response) ->
          if response.status is 401
            $rootScope.$broadcast "event:unauthorized"
            $location.path "/users/login"
            return response
          $q.reject response
        return (promise) ->
          promise.then success, error
    ]
    $httpProvider.responseInterceptors.push interceptor
])



@app.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when '/',
    auth: (user) ->
      user
    templateUrl: 'home.html',
    controller: 'HomeController'

  .when '/locations/index',
    templateUrl: 'locations/index.html',
    controller: 'LocationsIndexController'
  .when '/users/login',
    templateUrl:'users/login.html',
    controller:'UsersController'
  .when '/users/register',
    templateUrl:'users/register.html',
    controller:'UsersController'

  .otherwise({redirectTo: '/'})
])

@app.run ($rootScope, $location) ->
  console.log 'angular app running'
  $rootScope.$on "$routeChangeStart", (ev, next, curr) ->
    if next.$$route
      console.log $rootScope.currentUser
      user = $rootScope.currentUser
      auth = next.$$route.auth
      $location.path "/"  if auth and not auth(user)
    return
  return

