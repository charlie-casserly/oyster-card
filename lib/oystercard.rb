require_relative 'journey.rb'

class Oystercard
  attr_reader :in_journey, :entry_station, :complete_journeys, :journey, :balance

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @journey = nil
    @balance = 0
  end

  def top_up(amount)
    fail "Exceeds maximum balance limit of #{MAXIMUM_LIMIT}" if (balance + amount) > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(entry_station, journey = Journey.new(entry_station))
    fail "Insufficient funds. Minimum fare #{MINIMUM_FARE}" if balance < MINIMUM_FARE
    @journey = journey
  end

  def touch_out(exit_station)
    touched_in? ? non_penalty_journey(exit_station) : penalty_journey(exit_station)
  end

  private

  def penalty_journey(exit_station)
    @journey = Journey.new
    deduct_fare
    journey.end_journey(exit_station)
  end

  def non_penalty_journey(exit_station)
    deduct_fare
    journey.end_journey(exit_station)
  end

  def touched_in?
    journey != nil
  end

  def deduct_fare
    @balance -= journey.fare
  end
end