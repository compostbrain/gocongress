require "rails_helper"

RSpec.describe "gotha tournament import", type: :feature do
  let(:password) { 'asdfasdf' }
  let(:admin) { create :admin, :password => password }
  let!(:tournament) { create :tournament, name: "US Open"}

  it "imports tournament data from xml file" do
    visit new_user_session_path(year: admin.year)
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: password
    click_button 'Sign in'
    click_link 'Tournaments'
    click_link 'Import Data'
    attach_file("tournament_import[file]", Rails.root + "spec/fixtures/files/usopen_players_2018.xml")
    click_button "Import Tournament Data"
    expect(page).to have_content 'Tournament Data Imported'
  end

end
