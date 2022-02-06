class Child < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user, touch: true

  def age
    ((Time.zone.now - self.birthday.to_time) / 1.year.seconds).floor
  end


end
