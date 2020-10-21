function setEventOnEditQuestionLink(){
    $('.question').on(
        'click',
        '.edit-question-link',
        function(e){
            e.preventDefault();
            $(this).hide();
            let questionId = $(this).data('questionId');
            $('form#edit-question-' + questionId).removeClass('hidden');
        }
    );
}

$(document).on("turbolinks:load",
    setEventOnEditQuestionLink
);

App.cable.subscriptions.create('QuestionsChannel', {
    connected() {
        console.log('Hello, World!');
        this.perform('follow')
    },
    received(data) {
        let questions_list = $('#questions-list');
        questions_list.append(data);
    }
});
