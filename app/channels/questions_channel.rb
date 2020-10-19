class QuestionsChannel < ApplicationCable::Channel
  def do_smth(data)
    Rails.logger.info data
  end
end
