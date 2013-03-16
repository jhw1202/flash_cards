$(document).ready(function() {
  $('.toggle-link').on('click', function(e) {
    e.preventDefault();
    $('.index-form').removeClass('inactive');
    $(this).closest('.index-form').addClass('inactive');
  });
});
