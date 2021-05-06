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

  it 'new card is not in journey' do
    expect(subject.in_journey).to eq false
  end

  it 'is in journey after touched in' do
    subject.top_up(1)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'is not in journey after being touched out' do
    subject.top_up(1)
    subject.touch_in
    subject.touch_out
    expect(subject).to_not be_in_journey
  end

  it 'cannot touch in unless it contains more than minimum fare in balance' do
    expect {subject.touch_in}.to raise_error("Insufficient funds. Minimum fare #{Oystercard::MINIMUM_FARE}")
  end

  it 'charges me the minimum amount when I tap out' do
    expect{subject.touch_out}.to change{subject.balance}.by -1
  end
end
