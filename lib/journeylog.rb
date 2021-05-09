class Journeylog
  attr_reader :entry_station, :exit_station, :journeylog

  def initialize(journey = Journey.new)
    @journey = journey
    @entry_station = nil
    @journeylog = []
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    journeylog << {entry_station: @entry_station, exit_station: exit_station}
  end
end