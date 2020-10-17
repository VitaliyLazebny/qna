let hideVoteLinks = function(e){
    e.preventDefault();

    let answerId = $(this).data('answerId');

    $(`#answer-${answerId} .vote .vote-1-link`).hide();
    $(`#answer-${answerId} .vote .vote--1-link`).hide();
    $(`#answer-${answerId} .vote .unvote-link`).show();
}

let showVoteLinks = function(e){
    e.preventDefault();

    let answerId = $(this).data('answerId');

    $(`#answer-${answerId} .vote .vote-1-link`).show();
    $(`#answer-${answerId} .vote .vote--1-link`).show();
    $(`#answer-${answerId} .vote .unvote-link`).hide();
}

let processResult = function(e) {
    let request_answer = e.detail[0];
    let answer_id = '#answer-' + request_answer['votable']['id'];
    let counter   = $(answer_id + ' .vote .rating');
    counter.text(request_answer['rating']);
}

let processErrors = function(e) {
    console.log('errors');
    let errors = e.detail[0];
    console.log(errors);
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

    $('.answer').on(
        'click',
        '.unvote-link',
        showVoteLinks
    );

    $('.vote-1-link')
        .on('ajax:success', processResult )
        .on('ajax:error', processErrors);

    $('.vote--1-link')
        .on('ajax:success', processResult)
        .on('ajax:error', processErrors);

    $('.unvote-link')
        .on('ajax:success', processResult)
        .on('ajax:error', processErrors);
}

$(document).on("turbolinks:load",
    setEventOnPlusOneLink
);
