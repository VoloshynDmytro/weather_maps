@app = angular.module('app', [
  # additional dependencies here, such as restangular
  'ngRoute', 'templates', 'rails', 'ui.bootstrap', 'ngTable', 'sessionService', 'app.locationsApp'
])

# for compatibility with Rails CSRF protection
@app.config([
  '$httpProvider', ($httpProvider)->
])


@app.config(['$routeProvider', '$locationProvider', ($routeProvider,  $locationProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'home.html',
    controller: 'HomeController',
  .when '/locations/index',
    templateUrl: 'locations/index.html',
    controller: 'LocationsIndexCtrl',
    resolve: {
      auth: checkLoggedIn
    }
  .when '/users/login',
    templateUrl:'users/login.html',
    controller:'UsersController'
    resolve: {
      auth: ["Session", "$location", (Session, $location) ->
        if Session.currentUser
          Session.getCurrentUser().then((user) ->
             $location.path("/") if user && ("/users/login" is $location.path())
          )
        return true
      ]
    }
  .when '/users/register',
    templateUrl:'users/register.html',
    controller:'UsersController',
    resolve: {
      auth: ["Session", "$location", (Session, $location) ->
        if Session.currentUser
          Session.getCurrentUser().then (user) ->
            $location.path("/") if user && ("/users/register" is $location.path())
          return true
      ]
    }

  .otherwise({redirectTo: '/'})
])

@app.run ($rootScope, $location, Session) ->
  console.log 'angular app running'

checkLoggedIn = ($location, Session) ->
  Session.getCurrentUser().then((response) ->
    true
  ).catch (error) ->
    $location.path "/users/login" if error.status is 401

