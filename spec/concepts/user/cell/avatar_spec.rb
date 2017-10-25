require 'rails_helper'

RSpec.describe User::Cell::Avatar, type: :cell do
  controller ApplicationController

  let(:cell) { concept('user/cell/avatar', user.reload, version: version).() }

  let(:user) { Factory::User.create }

  let(:version) { :small }

  it 'renders the users avatar' do
    expect(cell).to have_selector('img.avatar')

    cell.find('img.avatar').tap do |img|
      expect(img[:src]).to eq(User::Avatar::Proxy::Default.new(user.avatar).image[:small].url)
      expect(img[:alt]).to eq("Avatar of #{user.username}")
    end
  end

  context 'with large version' do
    let(:version) { :large }

    it 'renders the users large avatar' do
      expect(cell).to have_selector('img.avatar')

      cell.find('img.avatar').tap do |img|
        expect(img[:src]).to eq(User::Avatar::Proxy::Default.new(user.avatar).image[:large].url)
        expect(img[:alt]).to eq("Avatar of #{user.username}")
      end
    end
  end

  context 'without avatar' do
    before { User::Avatar::Destroy.(nil, model: user.avatar) }

    it 'renders a fallback avatar' do
      expect(cell).to have_selector('img.avatar')

      cell.find('img.avatar').tap do |img|
        expect(img[:src]).to eq('/assets/concepts/user/avatar/fallback/small.png')
        expect(img[:alt]).to eq("Avatar of #{user.username}")
      end
    end

    context 'with large version' do
      before { User::Avatar::Destroy.(nil, model: user.avatar) }

      let(:version) { :large }

      it 'renders a large fallback avatar' do
        expect(cell).to have_selector('img.avatar')

        cell.find('img.avatar').tap do |img|
          expect(img[:src]).to eq('/assets/concepts/user/avatar/fallback/large.png')
          expect(img[:alt]).to eq("Avatar of #{user.username}")
        end
      end
    end
  end
end
