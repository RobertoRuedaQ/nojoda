require 'rails_helper'

RSpec.describe "rate_cap_updates/new", type: :view do
  before(:each) do
    assign(:rate_cap_update, RateCapUpdate.new(
      rate_cap_value: 1.5,
      responsible_id: 1
    ))
  end

  it "renders new rate_cap_update form" do
    render

    assert_select "form[action=?][method=?]", rate_cap_updates_path, "post" do

      assert_select "input[name=?]", "rate_cap_update[rate_cap_value]"

      assert_select "input[name=?]", "rate_cap_update[responsible_id]"
    end
  end
end
