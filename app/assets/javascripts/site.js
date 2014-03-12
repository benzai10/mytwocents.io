$(function() {

    setInterval(function(){
      $('.counter').load('/posts/counter');
      $('.new_posts').load('/posts/new_posts');
    }, 5000);

    $('.feed').click(function (event) {
      $('.posts').load('/posts/feed');
      alert('Hooray!');
      event.preventDefault(); // Prevent link from following its href
    });
});
