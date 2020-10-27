import React from "react"
class QuestionItem extends React.Component {
  render () {
    return (
      <React.Fragment>
        <p>
          <a href={`/questions/${this.props.id}`}>{this.props.title}</a>
        </p>
      </React.Fragment>
    );
  }
}

export default QuestionItem
