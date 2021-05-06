require_relative 'station'

class Oystercard
  attr_reader :balance
  attr_reader :in_journey
  attr_reader :entry_station
  attr_reader :journeys

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Exceeds maximum balance limit of #{MAXIMUM_LIMIT}" if (balance + amount) > MAXIMUM_LIMIT

    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds. Minimum fare #{MINIMUM_FARE}" if balance < MINIMUM_FARE
    @entry_station = station
    @in_journey = true
  end

  def in_journey?
    entry_station != nil
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journeys << {entry_station: @entry_station, exit_station: station}
    @entry_station = nil
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end