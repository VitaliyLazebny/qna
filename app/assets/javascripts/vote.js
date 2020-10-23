let hideVoteLinks = function(e){
    e.preventDefault();

    let votableType = $(this).data('votableType').toLowerCase();
    let votableId = $(this).data('votableId');

    $(`#${votableType}-${votableId} .vote .vote-1-link`).hide();
    $(`#${votableType}-${votableId} .vote .vote--1-link`).hide();
    $(`#${votableType}-${votableId} .vote .unvote-link`).show();
}

let showVoteLinks = function(e){
    e.preventDefault();

    let votableId   = $(this).data('votableId');
    let votableType = $(this).data('votableType').toLowerCase();

    $(`#${votableType}-${votableId} .vote .vote-1-link`).show();
    $(`#${votableType}-${votableId} .vote .vote--1-link`).show();
    $(`#${votableType}-${votableId} .vote .unvote-link`).hide();
}

let processResult = function(e) {
    let request_answer = e.detail[0];
    let votable_id     = request_answer['votable']['id'];
    let votable_type   = request_answer['resource'].toLowerCase();

    let votable_css    = `#${votable_type}-${votable_id}`;
    let counter        = $(votable_css + ' .vote .rating');

    counter.text(request_answer['rating']);
}

let processErrors = function(e) {
    let errors = e.detail[0];
    console.log(errors);
}

function setEventOnPlusOneLink(){
    $('.vote').on(
        'click',
        '.vote-1-link',
        hideVoteLinks
    );

    $('.vote').on(
        'click',
        '.vote--1-link',
        hideVoteLinks
    );

    $('.vote').on(
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
