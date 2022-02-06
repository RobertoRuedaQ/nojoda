class RemoveInstitutionGroupFromFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    #remove_reference :funding_opportunities, :institution_group, foreign_key: true
	  drop_table :institution_subgroups, if_exists: true
  	drop_table :institution_groups, if_exists: true
  end
end
