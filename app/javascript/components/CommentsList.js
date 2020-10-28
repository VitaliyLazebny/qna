import React from "react"

class CommentsList extends React.Component {
    constructor( props ) {
        super( props );

        this.state = {
            comments: props.comments
        };

        this.subcsribeToWebSockets();
    }

    subcsribeToWebSockets() {
        if (!gon.question_id){
            return;
        }

        const bindedThis = this;
        const props = this.props;

        App.cable.subscriptions.create( 'CommentsChannel', {
            connected() {
                this.perform('follow',  {
                    question_id: gon.question_id
                })
            },
            received(data) {
                data = JSON.parse(data);

                if (data['commentable_type'] !== props.commentable.class ||
                    data['commentable_id']   !== props.commentable.id ) {
                    return;
                }

                const comments = bindedThis.state.comments;
                const commentsNew = [...comments, data];
                bindedThis.setState({comments: commentsNew});
            }
        });
    }

    commentsList() {
        return this.state.comments.map (
            c => <div key={c.id} className="comment" id={ `comment-${c.id}` }>{c.body}</div>
        );
    }

    render () {
        return (
            <React.Fragment>
                <div className='list'>
                    { this.commentsList() }
                </div>
            </React.Fragment>
        );
    }
}

export default CommentsList
