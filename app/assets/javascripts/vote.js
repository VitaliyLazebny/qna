let hideVoteLinks = function(e){
    e.preventDefault();

    let answerId = $(this).data('answerId');

    $(`#answer-${answerId} .vote .vote-1-link`).hide();
    $(`#answer-${answerId} .vote .vote--1-link`).hide();
    $(`#answer-${answerId} .vote .unvote-link`).show();
}

function setEventOnPlusOneLink(){
    $('.answer').on(
        'click',
        '.vote-1-link',
        hideVoteLinks
    );

    $('.answer').on(
        'click',
        '.vote--1-link',
        hideVoteLinks
    );

    $('.vote-1-link')
        .on('ajax:success', function(e) {
            let request_answer = e.detail[0];
            let answer_id = '#answer-' + request_answer['answer_id']
            let counter   = $(answer_id + ' .vote .rating')
            counter.text(Number(counter.text()) + 1);
        })
        .on('ajax:error', function(e) {
            let errors = e.detail[0];
            console.log(errors);
        });

    $('.vote--1-link')
        .on('ajax:success', function(e) {
            let request_answer = e.detail[0];
            let answer_id = '#answer-' + request_answer['answer_id']
            let counter   = $(answer_id + ' .vote .rating')
            counter.text(Number(counter.text()) - 1);
        })
        .on('ajax:error', function(e) {
            let errors = e.detail[0];
            console.log(errors);
        });
}

$(document).on("turbolinks:load",
    setEventOnPlusOneLink
);
