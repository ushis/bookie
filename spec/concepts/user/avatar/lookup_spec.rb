require 'rails_helper'

RSpec.describe User::Avatar::Lookup do
  let(:result) { User::Avatar::Lookup.(nil, user: user) }

  let(:user) { Factory::User.create }

  let(:robo_hash) { NetStub::RoboHash.new(user.username, user.email) }

  before { robo_hash.stub }

  it 'successfully replaces the users avatar and creates its versions' do
    expect(result).to be_success
    expect(result['model']).to be_persisted

    User::Avatar::Proxy::Default.new(result['model']).tap do |proxy|
      expect(proxy.image[:original].fetch.file.read).to \
        eq(robo_hash.body)

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

    expect(Avatar.where(user: user).count).to eq(1)
  end
end
