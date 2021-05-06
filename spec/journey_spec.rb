require 'journey'
require 'station'
require 'oystercard'
describe Journey do
  describe '.new' do
    it 'new journey is not in journey' do
      expect(subject.in_journey).to eq true
    end
    it 'has a entry_station of nil when not given argument' do
      expect(subject.entry_station).to eq nil
    end 
    it 'has an entry_station of "test" when given "test"' do
      journey = Journey.new('test')
      expect(journey.entry_station).to eq('test')
    end

  describe '#fare' do
    context 'only checked in or out' do
      it 'returns penalty fare of 6' do
        exit_station = Station.new("exit", 2)
        card = Oystercard.new
        card.top_up(10)
        card.touch_out(exit_station)
        expect(card.balance)
      end
    end
  end
  end

end