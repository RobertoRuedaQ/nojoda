require 'rails_helper'

RSpec.describe "rate_cap_updates/show", type: :view do
  before(:each) do
    @rate_cap_update = assign(:rate_cap_update, RateCapUpdate.create!(
      rate_cap_value: 2.5,
      responsible_id: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3/)
  end
end
