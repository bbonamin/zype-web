// Detach video player from DOM before caching the page with Turbolinks
// otherwise, it will be duplicated on the next visit
$(document).on('turbolinks:before-cache', function(){
  if($('.video-player').length){
    $('.video-player').remove();
  }
});