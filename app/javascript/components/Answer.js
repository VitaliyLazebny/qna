import React from "react"
import PropTypes from "prop-types"
class Answer extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div className="answer" id="answer-{this.props.id}">
          <div className="body">{this.props.body}</div>
          <a className="make-best-answer-link" data-remote="true" rel="nofollow" data-method="patch" href="/answers/{this.props.id}/make_best">Make best</a>
          <a className="edit-answer-link" data-answer-id="{this.props.id}" href="#">Edit</a>
          <a data-remote="true" rel="nofollow" data-method="delete" href="/answers/{this.props.id}">Delete answer</a>
        </div>
      </React.Fragment>
    );
  }
}

Answer.propTypes = {
  greeting: PropTypes.string
};

export default Answer
