$(document).ready(function() {
  $('.toggle-link').on('click', function(e) {
    e.preventDefault();
    $('.index-form').removeClass('inactive');
    $(this).closest('.index-form').addClass('inactive');
  });

  $('.show-correct').on('click', function(e){
    e.preventDefault();
    $('.correct-list').toggle("blind", 500);
    $('.show-correct').removeClass('inactive');
    $(this).addClass('inactive');
  });

  $('.show-incorrect').on('click', function(e) {
    e.preventDefault();
    $('.incorrect-list').toggle("blind", 250);
    $('.show-incorrect').removeClass('inactive');
    $(this).addClass('inactive');
  });


});
