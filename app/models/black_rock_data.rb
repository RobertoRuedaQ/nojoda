class BlackRockData < ApplicationRecord
  validates :user, presence: true

  belongs_to :user
  has_one_attached :support_document
  has_one_attached :black_rock_authorization

  def origination
    self.user.funding_opportunities.last.fund.black_rock_origination
  end
end
