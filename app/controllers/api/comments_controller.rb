# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    respond_to :json

    before_action :authenticate_user!
    before_action :load_commentable

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
        format.json { redirect_to question_path(id: comment_params[:commentable_id]) }
        format.json do
          render json: { resource: @commentable.class.to_s,
                         commentable: @commentable,
                         comment: comment }
        end
      end
    end

    def destroy
      Vote.where(
        user: current_user,
        commentable: @commentable
      ).destroy_all

      render json: { rating: @commentable.rating,
                     resource: @commentable.class.to_s,
                     commentable: @commentable }
    end

    private

    def load_commentable
      @commentable = comment_params[:commentable_type]
                   &.constantize
                   &.find(comment_params[:commentable_id])
    end

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
  end
end
