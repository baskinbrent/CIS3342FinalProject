/* Warning: Do not modify this file unless you know what you are doing
* This is AngularJS logic for generating class and method panels using data provided in the JSON.
*/

var app = angular.module('app', []);

app.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
	$http.get('./DescriptionPage/JSON/classes.json').success(function(data) {
		$scope.classes = data;
	});
	$http.get('./DescriptionPage/JSON/methods.json').success(function(data) {
		$scope.methods = data;
	});
	$scope.clickNavLink = function(elementID) {
		var elementOffset = $("#" + elementID).offset().top;
		$('html, body').animate({
			scrollTop: (elementOffset - (10 + $("#contents-nav-fixed").height()))
		}, 1000);
	};
	$scope.scrollToTop = function() {
		$('html, body').animate({scrollTop: '0px'}, 1000);
	}
}]);