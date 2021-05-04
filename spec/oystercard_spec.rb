require 'oyster-card.rb'

describe Oystercard do
 describe '#balance'do
    it 'a freshly initialised card has a balance of 0' do
        card = Oystercard.new
        expect(card.balance).to eq 0
    end
end
end