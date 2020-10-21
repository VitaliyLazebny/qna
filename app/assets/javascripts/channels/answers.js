App.cable.subscriptions.create('AnswersChannel', {
    connected() {
        this.perform('follow')
    },
    received(data) {
        let answers_list = $('#answers');
        answers_list.append(data);
    }
});
