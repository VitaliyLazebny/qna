import React from "react"
import PropTypes from "prop-types"
import Question from "./Question";

class QuestionsList extends React.Component {
    constructor( props ) {
        super( props );

        this.state = {
            questions: props.questions
        };

        this.subcsribeToWebSockets();
    }

    subcsribeToWebSockets() {
        const bindedThis = this;

        App.cable.subscriptions.create('QuestionsChannel', {
            connected() {
                this.perform('follow')
            },
            received(data) {
                const questions    = bindedThis.state.questions;
                const questionsNew = [...questions, JSON.parse(data)];
                bindedThis.setState({questions: questionsNew});
            }
        })
    }

    questionsList() {
        return this.state.questions.map (
            q => <Question key={q.id} id={q.id} title={q.title} />
        );
    }

    render () {
        return (
            <React.Fragment>
                <div id='#questions-list'>
                    { this.questionsList() }
                </div>
            </React.Fragment>
        );
    }
}

QuestionsList.propTypes = {
    greeting: PropTypes.string
};

export default QuestionsList
