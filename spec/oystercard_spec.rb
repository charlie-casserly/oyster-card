require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'a freshly initialised card has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds the top up amount to the balance' do
      subject.top_up(15)
      expect(subject.balance).to eq 15
    end

    it 'raise an error if the topup would take balance beyond £90' do
      expect { subject.top_up(91) }.to raise_error("Exceeds maximum balance limit of #{Oystercard::MAXIMUM_LIMIT}")
    end
  end

  describe '#touch_in' do
    context 'with minimum fare' do
      let(:card) { double(:oystercard, in_journey?: true, entry_station: 'station') }
      
      it 'is in journey after touched in' do
        expect(card).to be_in_journey
      end

      it 'remembers the entry station when touching in' do
        expect(card.entry_station).to eq('station')
      end
    end

    it 'cannot touch in unless it contains more than minimum fare in balance' do
      expect {subject.touch_in('station')}.to raise_error("Insufficient funds. Minimum fare #{Oystercard::MINIMUM_FARE}")
    end
  end

  describe '#touch out' do
    it 'is not in journey after being touched out' do
      subject.top_up(1)
      subject.touch_in('station')
      subject.touch_out('station2')
      expect(subject.journey.entry_station).to eq nil
    end

    it 'returns entry_station to nil after touching out' do
      subject.top_up(1)
      subject.touch_in('station')
      subject.touch_out('station2')
      expect(subject.entry_station).to eq nil
    end
  end

  it 'charges me the minimum amount when I tap out' do
    subject.top_up(10)
    subject.touch_in('station')
    expect{subject.touch_out('station2')}.to change{subject.balance}.by(-Journey::MINIMUM_FARE)
  end

  it 'charges me the penalty amount when I tap out without tapping in' do
    subject.top_up(10)
    expect{subject.touch_out('station2')}.to change{subject.balance}.by(-Journey::PENALTY_FARE)
  end

  it 'creates a journey when touching in and out' do
    subject.top_up(1)
    subject.touch_in('station')
    subject.touch_out('station2')
    expect(subject.journey.complete_journeys).to eq [{entry_station: 'station', exit_station: 'station2'}]
  end
end
