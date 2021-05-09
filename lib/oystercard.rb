class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :complete_journeys

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @complete_journeys = []
  end

  def top_up(amount)
    fail "Exceeds maximum balance limit of #{MAXIMUM_LIMIT}" if (balance + amount) > MAXIMUM_LIMIT

    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds. Minimum fare #{MINIMUM_FARE}" if balance < MINIMUM_FARE
    @entry_station = entry_station
    @in_journey = true
  end

  def in_journey?
    entry_station != nil
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    complete_journey(exit_station)
  end

  private

  def complete_journey(exit_station)
    @complete_journeys << {entry_station: @entry_station, exit_station: exit_station}
    @entry_station = nil
    @in_journey = false
  end

  def deduct(amount)
    @balance -= amount
  end
end