angular.module("MyAngularSeed")
.config(["$routeProvider", ($routeProvider) ->

   $routeProvider
   .when("/",
      templateUrl: "templates/index.html"
   )
   .when("/page2",
      templateUrl: "templates/page2.html"
   )

])