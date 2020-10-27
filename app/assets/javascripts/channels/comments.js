// const commentHTML = '<div class="comment" id="comment-#{id}">#{body}</div>';
//
// function fillCommentHTML(body) {
//     let comment = '';
//     comment = commentHTML;
//     comment = comment.replaceAll('#{id}', body['id']);
//     comment = comment.replaceAll('#{body}', body['body']);
//
//     return comment;
// }
//
// const addCommentsSubscription = () => {
//     if (!gon.question_id){
//         return;
//     }
//
//     console.log('subscribe to comments');
//
//     App.cable.subscriptions.create( 'CommentsChannel', {
//         connected() {
//             this.perform('follow',  {
//                 question_id: gon.question_id
//             })
//         },
//         received(data) {
//             data = JSON.parse(data);
//
//             let commentsSelector;
//             if (data['commentable_type'] === 'Answer') {
//                 commentsSelector = `#answer-${data['commentable_id']} .comments .list`;
//             } else if (data['commentable_type'] === 'Question') {
//                 commentsSelector = `.question .comments .list`;
//             }
//
//             $(commentsSelector).append(fillCommentHTML(data));
//         }
//     });
// }
//
// $(document).on('turbolinks:load', addCommentsSubscription );
