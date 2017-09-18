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
      expect(proxy.image[:large]).to be_present
      expect(proxy.image[:small]).to be_present
      expect(proxy.image[:tiny]).to be_present
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
