import React from "react"
class Comment extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div class="comment" id="comment-{this.props.id}">{this.props.body}</div>
      </React.Fragment>
    );
  }
}

export default Comment
