class RemoveEligibilityCriteriaMatchFromApplication < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :eligibility_criteria_match, :boolean
    remove_column :applications, :fulfill_requirements, :boolean
  end
end
