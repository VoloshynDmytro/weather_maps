angular.module('app.homePageApp').controller("HomePageCtrl", ['$scope', ($scope)->
    console.log 'HomePageCtrl running'
    $scope.exampleValue = "Hello angular and rails"
])