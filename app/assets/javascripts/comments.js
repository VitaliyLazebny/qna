$(document).on('turbolinks:load', () => {
    $('.comments form').submit( (event)=>{
        event.preventDefault();

        const form             = event.target;
        const submit_button    = $('input[type=submit]', form);

        const comment_body     = $('#comment_body', form).val();
        const commentable_id   = $('#comment_commentable_id', form).val();
        const commentable_type = $('#comment_commentable_type', form).val();

        setTimeout(() => { submit_button.removeAttr("disabled") }, 500);

        if (comment_body.length < 1) {
            return;
        }

        $.post('/api/comments', { comment: {
                body: comment_body,
                commentable_id: commentable_id,
                commentable_type: commentable_type
            }
        });
    });
} );
