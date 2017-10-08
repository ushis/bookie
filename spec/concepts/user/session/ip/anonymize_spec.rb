require 'rails_helper'

RSpec.describe User::Session::IP::Anonymize, type: :operation do
  let(:result) { User::Session::IP::Anonymize.(nil, ip_address: ip_address) }

  let(:ip_address) { Faker::Internet.ip_v4_address }

  it 'successfully masks the ip' do
    expect(result).to be_success
    expect(result['ip_address']).to eq(IPAddr.new(ip_address).mask(16).to_s)
  end

  context 'when address is ipv6' do
    let(:ip_address) { Faker::Internet.ip_v6_address }

    it 'successfully masks the ip' do
      expect(result).to be_success
      expect(result['ip_address']).to eq(IPAddr.new(ip_address).mask(64).to_s)
    end
  end

  context 'when address is invalid' do
    let(:ip_address) { 'invalid' }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
