class GameAppointment < ApplicationRecord
  include YearlyModel

  belongs_to :attendee

  validates :attendee, presence: true
  validates :opponent, presence: true
  validates :location, presence: true
  validates :time,     presence: true

  # after_create :reminder

  # Notify our appointment attendee X minutes before the appointment time
  def reminder
    @twilio_number = ENV['TWILIO_NUMBER']
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    @client = Twilio::REST::Client.new account_sid, ENV['TWILIO_AUTH_TOKEN']
    time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
    reminder = "Hi #{self.attendee}. You have a game scheduled with the following details: Opponent: #{self.oppoenent}, Time: #{time_str}, Location: #{self.location}."
    message = @client.api.account(account_sid).messages.create(
      :from => @twilio_number,
      :to => self.attendee.phone_number,
      :body => reminder,
    )
  end
end