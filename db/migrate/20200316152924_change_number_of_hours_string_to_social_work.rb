class ChangeNumberOfHoursStringToSocialWork < ActiveRecord::Migration[5.2]
  def change
  	change_column :social_works, :number_of_hours, :string
  end
end
