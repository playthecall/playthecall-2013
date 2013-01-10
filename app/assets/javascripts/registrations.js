$(document).ready(function() {
  var fetchCities = function() {
    var data = { country_id: $("#user_country_id").val() };
    $.get('/cities/by_country', data, function(html){
				$("#user_city_id").trigger("liszt:updated");
			}, 'script');
    };
  $("#user_country_id").chosen().change(fetchCities);
});

jQuery(function($){
    $('.chzn-select').chosen();
});