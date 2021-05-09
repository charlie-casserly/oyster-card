class Journey 
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :complete_journeys, :entry_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete_journeys = []
  end

  def end_journey(exit_station)
    complete_journey(exit_station)
  end

  def fare
    entry_station == nil ? PENALTY_FARE : MINIMUM_FARE
  end

  private

  def complete_journey(exit_station)
    complete_journeys << {entry_station: @entry_station, exit_station: exit_station}
    @entry_station = nil
  end
end