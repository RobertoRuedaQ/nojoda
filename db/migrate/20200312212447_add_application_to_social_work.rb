class AddApplicationToSocialWork < ActiveRecord::Migration[5.2]
  def change
    add_reference :social_works, :application, foreign_key: true
  end
end
