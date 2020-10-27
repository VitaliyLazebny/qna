import React from "react"
import Answer from "./Answer";

class AnswersList extends React.Component {
  constructor( props ) {
    super( props );

    this.state = {
      answers: props.answers
    };

    this.subscribeToWebSockets();
  }

  subscribeToWebSockets() {
    if (!gon.question_id) {
      throw new Error('Answer expected to be rendered ' +
          'as a part of a question.');
    }

    const bindedThis = this;

    App.cable.subscriptions.create( 'AnswersChannel', {
      connected() {
        this.perform('follow',  {
          question_id: gon.question_id
        })
      },
      received(data) {
        const answers = bindedThis.state.answers;
        const answersNew = [...answers, JSON.parse(data)];
        bindedThis.setState({answers: answersNew});

        // let answers_list = $('#answers');
        // answers_list.append(fillAnswerHTML(JSON.parse(data)));
      }
    });
  }

  answersList() {
    return this.state.answers.map (
        a => <Answer key={a.id} answer={a} />
    );
  }

  render () {
    return (
      <React.Fragment>
        <div id='#answers'>
          { this.answersList() }
        </div>
      </React.Fragment>
    );
  }
}

export default AnswersList
