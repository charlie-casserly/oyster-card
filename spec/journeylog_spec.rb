require 'journeylog'

describe Journeylog do
  it 'starts a new journey with an entry station' do
    subject.start('this')
    expect(subject.entry_station).to eq('this')
  end

  it 'adds a completed journey to the journeylog' do
    subject.start('this')
    subject.finish('that')
    expect(subject.journeylog).to eq [{entry_station: 'this', exit_station: 'that'}]
  end

  it "adds a 'touch out only' journey to the journeylog" do
    subject.finish('that')
    expect(subject.journeylog).to eq [{entry_station: nil, exit_station: 'that'}]
  end

  it 'prints the journey log' do

  end
end