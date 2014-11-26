@app = angular.module('app', [
  # additional dependencies here, such as restangular
  'ngRoute', 'templates', 'ui.bootstrap', 'sessionService'
])

# for compatibility with Rails CSRF protection
@app.config([
  '$httpProvider', ($httpProvider)->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    #with this full redirect work without error, can be removed later
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



@app.config(['$routeProvider', '$locationProvider', ($routeProvider,  $locationProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'home.html',
    controller: 'HomeController',
    resolve: {
      factory: getCurrentUser
    }
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

@app.run ($rootScope, $location, Session) ->
  console.log 'angular app running'


getCurrentUser = ($q, $rootScope, $location, $http, $window) ->
  !!$rootScope.currentUser or $http.get("/current_user"
  ).success((response) ->
    $rootScope.currentUser = response.user
  ).error((response) ->
    $location.path "/" unless response.success
  )