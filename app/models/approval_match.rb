class ApprovalMatch < ApplicationRecord
    resourcify
  audited
  belongs_to :user, touch: true
  belongs_to :role, optional: true, touch: true
  belongs_to :approver, :class_name => 'User', foreign_key: 'approver_id', optional: true, touch: true
end
