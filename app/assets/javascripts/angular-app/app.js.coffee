@app = angular.module('app', [
  # additional dependencies here, such as restangular
  'ngRoute', 'templates', 'ui.bootstrap'
])

# for compatibility with Rails CSRF protection
@app.config([
  '$httpProvider', ($httpProvider)->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

@app.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'dashboard.html',
    controller: 'DashboardController'
  .when '/locations/index',
    templateUrl: 'locations/index.html',
    controller: 'LocationsController'

  .otherwise({redirectTo: '/'})
])

@app.run(->
  console.log 'angular app running'
)
