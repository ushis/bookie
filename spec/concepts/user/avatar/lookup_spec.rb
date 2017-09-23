require 'rails_helper'

RSpec.describe User::Avatar::Lookup do
  let(:result) { User::Avatar::Lookup.(nil, user: user) }

  let(:user) { Factory::User.create }

  before { NetStub::RoboHash.stub_request(user.username, user.email) }

  it 'successfully creates an avatar and its versions' do
    expect(result).to be_success
    expect(result['model']).to be_persisted

    User::Avatar::Proxy::Default.new(result['model']).tap do |proxy|
      expect(proxy.image[:original]).to be_present

      proxy.image[:large].fetch.tap do |version|
        expect(version.width).to eq(300)
        expect(version.height).to eq(300)
      end

      proxy.image[:small].fetch.tap do |version|
        expect(version.width).to eq(44)
        expect(version.height).to eq(44)
      end

      proxy.image[:tiny].fetch.tap do |version|
        expect(version.width).to eq(20)
        expect(version.height).to eq(20)
      end
    end
  end

  context 'when an avatar for the given user already exists' do
    let!(:avatar) { User::Avatar::Lookup.(nil, user: user)['model'] }

    it 'successfully finds the avatar' do
      expect(result).to be_success
      expect(result['model']).to eq(avatar)
    end
  end
end
