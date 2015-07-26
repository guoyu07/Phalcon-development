var notify = null;

(function(angular) {

    "use strict";

    // application module
    angular.module('app', [
        'ngRoute',
        'app.logger',
        'app.document',
        'app.directives',
        'app.session',
        'app.authenticate',
        'app.common',
        'app.user',
        'app.catalogue'
    ])

    // configure application's routes
    .config(['$routeProvider', '$locationProvider',function($routeProvider, $locationProvider) {

        $locationProvider.hashPrefix('!');
        $locationProvider.html5Mode(true);

        for(var path in CONFIG.ROUTER) {
            $routeProvider.when(path, CONFIG.ROUTER[path]);
        }
        $routeProvider.otherwise({redirectTo: CONFIG.LOCATIONS.NOT_FOUND});
    }])

    // setup global scope variables
    .run(['$rootScope', 'amMoment', '$notification', '$location', 'LanguageService', 'CategoriesService', 'CurrenciesService',
        function ($rootScope, amMoment, $notification, $location, LanguageService, CategoriesService, CurrenciesService) {

            //  load engine's categories
            CategoriesService.load(function(response) {
                $rootScope.categories   = response.categories;
                $rootScope.engines      = response.engines;
                $rootScope.bannersOn    = CONFIG.BANNERS;
                $rootScope.banners      = response.banners;
            });

            // load & configure shop currencies
            CurrenciesService.load(function(response) {
                $rootScope.currencies = response;
            });

            // getting store locale
            LanguageService.get();
            $rootScope.currentLanguage = LanguageService.get();

            // set date localization
            amMoment.changeLocale($rootScope.currentLanguage);

            // overwite global notify storage
            notify = $notification;

            $rootScope.location = $location;
        }
    ])

})(angular);