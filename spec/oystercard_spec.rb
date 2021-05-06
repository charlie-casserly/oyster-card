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

  describe '#deduct' do
    it 'deducts the #deduct amount from the balance' do
      expect{subject.deduct 1}.to change{subject.balance}.by -1
    end 
  end

  it 'new card is not in journey' do
    expect(subject.in_journey).to eq false
  end

  it 'is in journey after touched in' do
    subject.touch_in
    expect(subject.in_journey).to eq true
  end

  it 'is not in journey after being touched out' do
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey).to eq false
  end
end
