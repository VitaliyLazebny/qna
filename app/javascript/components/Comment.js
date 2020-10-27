import React from "react"
import PropTypes from "prop-types"
class Comment extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div class="comment" id="comment-{this.props.id}">{this.props.body}</div>
      </React.Fragment>
    );
  }
}

Comment.propTypes = {
  greeting: PropTypes.string
};

export default Comment
