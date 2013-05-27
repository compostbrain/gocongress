require_relative '../../app/services/who_is_coming'

describe WhoIsComing do
  describe '#attendees' do

    it 'excludes attendees with zero plans' do
      a = create :attendee
      WhoIsComing.new(a.year).attendees.should_not include(a)
    end

    it 'returns attendees that paid in full and have at least one plan' do
      p = create :plan, price: 10000

      u1 = create :user
      create :attendee, user: u1, given_name: 'u1a', plans: [p]
      create :attendee, user: u1, given_name: 'u1b'
      create :tr_sale, amount: 10000, user: u1

      u2 = create :user
      create :attendee, user: u2, given_name: 'u2a', plans: [p]
      create :attendee, user: u2, given_name: 'u2b'
      create :tr_sale, amount: 9999, user: u2

      WhoIsComing.new(u1.year).attendees.map(&:given_name).should == ['u1a']
    end
  end
end
