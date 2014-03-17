$(function() {

    //every 5s
    setInterval(function(){
      $('.happy-row').load('/posts/counter');
      $('.new_posts').load('/posts/new_posts');
    }, 5000);

    //WHen modal is hidden
    $('#myModal').on('hidden.bs.modal', function (e) {
        $('#post_content').val('');
        $('#post_mood_id').val('');
        $('.mood-row i').removeClass('highlight');
        $('.myAlert').hide();
    });

    //When modal is shown
    $('#myModal').on('shown.bs.modal', function (e) {
        $('#post_content').focus();
    });

    //When focus form input
    $('#post_content').focus(function() {
        $('.myAlert').slideUp("fast");
    });

    //When click on mood
    $('.mood-row i').click(function() {

        $('.myAlert').slideUp("fast");

        // Set the form value
        $('#post_mood_id').val($(this).attr('data-value'));
        $('#comment_mood_id').val($(this).attr('data-value'));

        // Unhighlight all the images
        $('.mood-row i').removeClass('highlight');

        // Highlight the newly selected image
        $(this).addClass('highlight');
    });
});
