class RemoveFeedbackCaseFromFeedback < ActiveRecord::Migration[5.2]
  def change
    remove_column :feedbacks, :feedback_case, :string
  end
end
