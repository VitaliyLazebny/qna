# frozen_string_literal: true

module Api
  class VotesController < ApplicationController
    skip_before_action :verify_authenticity_token
    respond_to :json

    before_action :authenticate_user!
    before_action :load_votable

    def index
      render json: Comments.all
    end

    def create
      Comment.create(
        user: current_user,
        votable: @commentable,
        body: comment_params[:body]
      )

      render json: { resource: @commentable.class.to_s,
                     votable: @commentable }
    end

    def destroy
      Vote.where(
        user: current_user,
        votable: @votable
      ).destroy_all

      render json: { rating: @votable.rating,
                     resource: @votable.class.to_s,
                     votable: @votable }
    end

    private

    def load_commentable
      @commentable = comment_params[:commentable_type]
                   &.constantize
                   &.find(vote_params[:commentable_id])
    end

    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end
  end
end
