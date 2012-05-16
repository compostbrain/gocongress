require "spec_helper"

describe ReportsController do

  describe "#outstanding_balances" do
    it "shows users with non-zero balances" do
      sign_in FactoryGirl.create :admin

      paid_too_little = FactoryGirl.create(:user)
      paid_too_much = FactoryGirl.create(:user)
      paid_exactly = FactoryGirl.create(:user)
      paid_too_little.primary_attendee.plans << FactoryGirl.create(:plan)
      paid_too_much.transactions << FactoryGirl.create(:tr_sale)

      get :outstanding_balances, :year => Time.now.year
      assigns(:users).map(&:id).should =~ [paid_too_little.id, paid_too_much.id]
    end
  end

  describe "#user_invoices" do

    it "filters users alphabeticaly by name" do

      # Sign in as an admin whose primary attendee's name starts
      # with Z, ie. not in the range we'll be testing below.
      admin = FactoryGirl.create :admin,
        :primary_attendee => FactoryGirl.build(:attendee,
          :family_name => "Zhivago", :is_primary => true)
      sign_in admin

      # Create a handful of users, one for each letter of a subset
      # of the alphabet.  Also create their corresponding primary
      # attendees, with family names beginning with that letter.
      # In addition, capitalize half of the names, randomly.
      "a".upto("f") do |letter|
        name = (letter * 5)
        name = name.capitalize if (rand < 0.5)
        FactoryGirl.create :user,
          :primary_attendee => FactoryGirl.build(:attendee,
            :family_name => name,
            :is_primary => true,
            :year => admin.year \
          ),
          :year => admin.year
      end

      # Get the report, and expect the users to be filtered.
      get :user_invoices, :year => admin.year, :min => "a", :max => "c"
      assigns(:users).should have_exactly(3).users
    end
  end
end