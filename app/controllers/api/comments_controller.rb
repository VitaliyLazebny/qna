# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    # respond_to :json

    before_action :authenticate_user!

    def index
      render json: Comments.all
    end

    def create
      comment = Comment.create(
        user: current_user,
        commentable_id: comment_params[:commentable_id],
        commentable_type: comment_params[:commentable_type],
        body: comment_params[:body]
      )

      respond_to do |format|
        format.html { redirect_to question_path(id: comment_params[:commentable_id]) }
        format.json do
          render json: { resource: comment.commentable.class.to_s,
                         commentable: comment.commentable,
                         comment: comment }
        end
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
  end
end
