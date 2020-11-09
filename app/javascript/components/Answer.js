import React from "react"
class Answer extends React.Component {
  constructor( props ) {
    super( props );

    this.state = {
      answer: props.answer
    };
  }

  render () {
    if (!this.state.answer.id){
      return '';
    }

    const bestAnswer = this.state.answer.best ?
        <div>Best answer!</div> :
        ''

    const makeBestAnswer = gon.question_creator === gon.user_id ?
        <a className="make-best-answer-link" data-remote="true"
           rel="nofollow" data-method="patch"
           href={ `/answers/${this.state.answer.id}/make_best` }>Make best</a> :
        ''

    const editAnswer = gon.question_creator === gon.user_id ?
        <a className="edit-answer-link" data-answer-id={ this.state.answer.id } href="#">Edit</a> :
        ''

    const deleteAnswer = gon.question_creator === gon.user_id ?
        <a data-remote="true" rel="nofollow" data-method="delete" href={ `/answers/${this.state.answer.id}` }>Delete answer</a> :
        ''

    return (
      <React.Fragment>
        <div className="answer" id={ `answer-${this.state.answer.id}` }>
          <div className="body">{this.state.answer.body}</div>
          { bestAnswer }
          { makeBestAnswer }
          { editAnswer }
          { deleteAnswer }
        </div>
      </React.Fragment>
    );
  }
}

export default Answer;
