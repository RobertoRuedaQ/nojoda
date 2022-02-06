require 'rails_helper'

RSpec.describe "rate_cap_updates/index", type: :view do
  before(:each) do
    assign(:rate_cap_updates, [
      RateCapUpdate.create!(
        rate_cap_value: 2.5,
        responsible_id: 3
      ),
      RateCapUpdate.create!(
        rate_cap_value: 2.5,
        responsible_id: 3
      )
    ])
  end

  it "renders a list of rate_cap_updates" do
    render
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
