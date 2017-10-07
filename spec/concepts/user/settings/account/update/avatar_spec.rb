require 'rails_helper'

RSpec.describe User::Settings::Account::Update::Avatar, type: :operation do
  let(:result) { User::Settings::Account::Update::Avatar.(params, dependencies) }

  let(:params) {
    {
      user: {
        avatar: {
          image: image,
        },
      },
    }
  }

  let(:image) { fixture.open }

  let(:fixture) { Fixture::Image.new }

  let(:dependencies) { {current_user: current_user} }

  let(:current_user) { Factory::User.create }

  it 'successfully replaces the avatar and creates its versions' do
    expect(result).to be_success
    expect(result['model'].avatar).to be_persisted

    User::Avatar::Proxy::Default.new(result['model'].avatar).tap do |proxy|
      expect(proxy.image[:original].fetch.file.read).to eq(fixture.read)

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

    expect(Avatar.where(user: result['model']).count).to eq(1)
  end

  context 'with too big image' do
    let(:image) { StringIO.new(Faker::Config.random.bytes(3.megabytes)) }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.avatar'].errors[:'avatar.image'][0]).to \
        match(/too big/)
    end
  end

  context 'with invalid file type' do
    let(:fixture) { Fixture::Document.new }

    it 'fails with an error' do
      expect(result).to be_failure
      expect(result['contract.avatar'].errors[:'avatar.image'][0]).to \
        match(/invalid format/)
    end
  end

  context 'as anonymous user' do
    let(:current_user) { nil }

    it 'fails' do
      expect(result).to be_failure
    end
  end
end
