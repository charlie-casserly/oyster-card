require 'station'

describe Station do 
  let(:station) {Station.new('name', 'zone')}
  it 'responds to #name' do
    expect(station).to respond_to(station.name)
  end

  it 'responds to #zone' do
    expect(station).to respond_to(station.zone)
  end
end