require "rails_helper"

RSpec.describe 'Viewing Tournament details', type: :feature do

  let!(:tournament) { build_stubbed :tournament }
  let!(:players) { build_list(:player, 3) }

  context 'Any user' do
    fit 'can view all players for a tournament' do
      visit tournament_path(tournament)
      click_link 'Players'
      expect(find('tbody')).to have_selector('tr', 3)

    end

  end

end
