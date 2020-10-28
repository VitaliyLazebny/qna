$(document).on('turbolinks:load', () => {
    $('.comments form').submit( (event)=>{
        event.preventDefault();

        const form             = event.target;
        const body_element     = $('#comment_body', form);
        const submit_button    = $('input[type=submit]', form);

        const comment_body     = body_element.val();
        const commentable_id   = $('#comment_commentable_id', form).val();
        const commentable_type = $('#comment_commentable_type', form).val();

        if (comment_body.length < 1) {
            setTimeout(() => { submit_button.removeAttr("disabled") }, 1000);
            return;
        }

        $.post('/api/comments', { comment: {
                body: comment_body,
                commentable_id: commentable_id,
                commentable_type: commentable_type
            }
        }).always( () => {
            body_element.val('');
            submit_button.removeAttr("disabled");
        })
    });
} );
