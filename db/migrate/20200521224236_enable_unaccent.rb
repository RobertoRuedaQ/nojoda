class EnableUnaccent < ActiveRecord::Migration[5.2]
  def up
    enable_extension 'unaccent'
  end

  def down
    disable_extension 'unaccent'
  end
end
