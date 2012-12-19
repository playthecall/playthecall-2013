$(document).ready(function() {
  var fetchCities = function() {
    var data = { country_id: $("#user_country_id").val() };
    $.get('/cities/by_country', data, function(html){}, 'script');
  };

  $("#user_country_id").change(fetchCities);
  //fetchCities();
});
