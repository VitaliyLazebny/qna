import React from "react"
import PropTypes from "prop-types"
class QuestionItem extends React.Component {
  render () {
    return (
      <React.Fragment>
        <p>
          <a href={`/questions/${this.props.id}`}>{this.props.body}</a>
        </p>
      </React.Fragment>
    );
  }
}

QuestionItem.propTypes = {
  greeting: PropTypes.string
};

export default QuestionItem
