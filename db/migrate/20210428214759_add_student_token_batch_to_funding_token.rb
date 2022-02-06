class AddStudentTokenBatchToFundingToken < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_tokens, :student_token_batch, foreign_key: true
  end
end
