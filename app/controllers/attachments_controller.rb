# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_attachment
  before_action :load_model
  authorize_resource

  def destroy
    @attachement_id = @attachment.id
    @attachment.destroy
  end

  private

  def load_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end

  def load_model
    @model = @attachment.record
  end
end
