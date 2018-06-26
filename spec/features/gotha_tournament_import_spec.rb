require "rails_helper"

RSpec.describe "gotha tournament import", type: :feature do
  let(:admin) { create :admin }
  before { sign_in admin }

  it "imports tournament data from xml file" do
    visit import_tournament_data_path
    
  end
  
end
