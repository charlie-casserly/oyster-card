class Journey
  attr_reader :entry_station, :in_journey, :exit_station

  MINIMUM_FARE = 1

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @exit_station = nil
    @in_journey = true
  end

  def finish(exit_station)
    @in_journey = false
    @exit_station = exit_station
    {entry_station: @entry_station, exit_station: exit_station}
  end

  def fare
    if @entry_station.nil? || @exit_station.nil?
      6
    else
      1
    end
  end
end