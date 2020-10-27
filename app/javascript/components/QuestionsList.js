import React from "react"
import PropTypes from "prop-types"
import Question from "./Question";

class QuestionsList extends React.Component {
    render () {
        const questions = this.props.questions;
        const questionsList = questions.map(
            q => <Question key={q.id} id={q.id} body={q.body} />
        );

        return (
            <React.Fragment>
                <div id='#questions-list'>
                    { questionsList }
                </div>
            </React.Fragment>
        );
    }
}

QuestionsList.propTypes = {
    greeting: PropTypes.string
};

export default QuestionsList
