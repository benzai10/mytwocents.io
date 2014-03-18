$(function() {

    $('.loaderImg').hide();
    //every 5s
    setInterval(function(){
      $('.happy-row').load('/posts/nav_counter');
      $('.new_posts').load('/posts/nav_new_posts');
    }, 5000);

    //When modal is hidden
    $('#myModal').on('hidden.bs.modal', function (e) {
        $('#form_content').val('');
        $('#form_mood_id').val('');
        $('.mood-row i').removeClass('highlight');
        $('.myAlert').hide();
    });

    //When modal is shown
    $('#myModal').on('shown.bs.modal', function (e) {
        $('#form_content').focus();
    });

    //When focus form input
    $('#form_content').focus(function() {
        $('.myAlert').slideUp("fast");
    });

    //When click on mood
    $('.mood-row i').click(function() {

        $('.myAlert').slideUp("fast");

        // Set the form value
        $('#form_mood_id').val($(this).attr('data-value'));

        // Unhighlight all the images
        $('.mood-row i').removeClass('highlight');

        // Highlight the newly selected image
        $(this).addClass('highlight');
    });

    $('.row .btn-filter').click(function() {
        // Unhighlight all the images
        $('.row .btn-filter').removeClass('btn-filter-a');

        // Highlight the newly selected image
        $(this).addClass('btn-filter-a');
        $.ajax({
            type: "POST",
            url: "/posts/post_feed",
            data: {
                filter: $(this).attr('data-value')
            },

            beforeSend: function() {
                $('.posts').hide();
                $('.loaderImg').show();    /*showing  a div with spinning image */
            },

            success: function(data) {
                $('.loaderImg').hide();
                $('.posts').html(data);
                $('.posts').show();
                return false;
            },
            error: function(data) {
                $('#loaderImg').hide();
                return false
            }
        });
    });
});
