class RemoveFeedbackFromFeedback < ActiveRecord::Migration[5.2]
  def change
    remove_reference :feedbacks, :feedback, foreign_key: true
  end
end
