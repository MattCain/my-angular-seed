angular.module("myAngularSeed")
   .config(($stateProvider) ->

      $stateProvider
         .state("index",
           url: ""
           templateUrl: "templates/index.html"
         )
         .state("page2",
           url: "page2"
           templateUrl: "templates/page2.html"
         )
   )