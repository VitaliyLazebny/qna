# frozen_string_literal: true

module Api
  class VotesController < ApplicationController
    skip_before_action :verify_authenticity_token
    respond_to :json

    before_action :authenticate_user!
    authorize_resource
    before_action :load_votable

    def create
      Vote.create(
        user: current_user,
        votable: @votable,
        value: vote_params[:value]
      )

      render json: { rating: @votable.rating,
                     resource: @votable.class.to_s,
                     votable: @votable }
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

    def load_votable
      @votable = vote_params[:votable_type]
                   &.constantize
                   &.find(vote_params[:votable_id])
    end

    def vote_params
      params.require(:vote).permit(:value, :votable_id, :votable_type)
    end
  end
end
