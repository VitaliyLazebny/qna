let answerHTML = [];
answerHTML.push(`<div className="answer" id="answer-#{id}">`);
answerHTML.push(`<div className="body">#{body}</div>`);
answerHTML.push(`<a className="make-best-answer-link" data-remote="true" rel="nofollow" data-method="patch" href="/answers/#{id}/make_best">Make best</a>`);
answerHTML.push(`<a className="edit-answer-link" data-answer-id="#{id}" href="#">Edit</a>`);
answerHTML.push(`<a data-remote="true" rel="nofollow" data-method="delete" href="/answers/#{id}">Delete answer</a>`);
answerHTML.push(`</div>`);

// JSON example:
//
// {
//      "id":10,
//      "body":"asdfasdf",
//      "question_id":1,
//      "created_at":"2020-10-22T06:25:41.958Z",
//      "updated_at":"2020-10-22T06:25:41.958Z",
//      "user_id":2,
//      "best":false
// }
//
function fillAnswerHTML(body) {
    let userId = Number($('#current_user').text());
    let answer = '';

    answer += answerHTML[0].replaceAll('#{id}',   body['id']);
    answer += answerHTML[1].replaceAll('#{body}', body['body']);

    console.log(userId, body['user_id'], userId === body['user_id'])
    if (userId === body['user_id']){
        // answer += answerHTML[2].replaceAll('#{id}',   body['id']);
        answer += answerHTML[3].replaceAll('#{id}',   body['id']);
        answer += answerHTML[4].replaceAll('#{id}',   body['id']);
    }

    answer += answerHTML[5];
    return answer;
}

const addAnswersSubscription = () => {
    let questionId = $('#question_id').text();

    App.cable.subscriptions.create( 'AnswersChannel', {
        connected() {
            this.perform('follow',  {
                question_id: questionId
            })
            console.log('followed', questionId);
        },
        received(data) {
            console.log('received');
            let answers_list = $('#answers');
            answers_list.append(fillAnswerHTML(JSON.parse(data)));
        }
    });
}

$(document).on('turbolinks:load', addAnswersSubscription );
// setTimeout(() => { addAnswersSubscription }, 1000);
