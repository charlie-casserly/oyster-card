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
    @journeys = []
    @current_journey = nil
    @journeylog = Journeylog.new(self)
  end

  def top_up(amount)
    fail "Exceeds maximum balance limit of #{MAXIMUM_LIMIT}" if (balance + amount) > MAXIMUM_LIMIT

    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds. Minimum fare #{MINIMUM_FARE}" if balance < MINIMUM_FARE
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    complete_journey(station)
    deduct(@current_journey.fare)
  end

  private

  def complete_journey(exit_station)
    if @current_journey
      @journeys << @current_journey.finish(exit_station)
    else
      @current_journey = Journey.new
      @journeys << @current_journey.finish(exit_station)
    end
  end
  
  def deduct(amount)
    @balance -= amount
  end

end