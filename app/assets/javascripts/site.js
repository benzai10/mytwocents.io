$(function() {

    setInterval(function(){
      $('.counter').load('/posts/refresh');
    }, 5000);

    $('.feed').click(function (event) {
      $('.posts').load('/posts/feed');
      alert('Hooray!');
      event.preventDefault(); // Prevent link from following its href
    });

});
