require 'rails_helper'

describe "Homepage" do
  it "shows the homepage" do
    visit '/'
    expect(page).to have_content('ChekBlok')
  end
end
