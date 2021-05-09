require 'journey'
require 'oystercard'

describe Journey do
  it 'instantiates with an empty journey list' do
    expect(subject.complete_journeys).to eq []
  end

  it 'saves a completed journey' do
    card = Oystercard.new
    card.top_up(1)
    card.touch_in('station')
    card.touch_out('station2')
    expect(card.journey.complete_journeys).to eq [{entry_station: 'station', exit_station: 'station2'}]
  end

  it 'instantiates with an entry station' do
    journey = Journey.new('here')
    expect(journey.entry_station).to eq 'here'
  end

  it 'passes nil to entry station when instantiated with no argument' do
    journey = Journey.new
    expect(journey.entry_station).to eq nil
  end

  it 'completes a journey when touching out without touching in' do
    card = Oystercard.new
    card.top_up(1)
    card.touch_out('station2')
    expect(card.journey.complete_journeys).to eq [{entry_station: nil, exit_station: 'station2'}]
  end
end