require 'rails_helper'

RSpec.describe "rate_cap_updates/edit", type: :view do
  before(:each) do
    @rate_cap_update = assign(:rate_cap_update, RateCapUpdate.create!(
      rate_cap_value: 1.5,
      responsible_id: 1
    ))
  end

  it "renders the edit rate_cap_update form" do
    render

    assert_select "form[action=?][method=?]", rate_cap_update_path(@rate_cap_update), "post" do

      assert_select "input[name=?]", "rate_cap_update[rate_cap_value]"

      assert_select "input[name=?]", "rate_cap_update[responsible_id]"
    end
  end
end
