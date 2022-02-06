class ApplicationFollowUp < ApplicationRecord
  belongs_to :application

  validates :stage, :application_id,  presence: true

  after_save :give_position_in_order

  private

  def give_position_in_order
    order_number = ApplicationFollowUp.where(application_id: self.application_id).maximum(:order) + 1
    self.update_column('order', order_number)
  end
end
