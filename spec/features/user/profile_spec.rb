require 'rails_helper'

RSpec.describe 'Visit profile', type: :feature do
  let!(:user) { factory.create }

  let(:factory) { Factory::User.new }

  before { sign_in(factory.username, factory.password) }

  it 'is possible to visit the profile' do
    # check navigation and visit profile
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      find('.avatar').hover
      click_link('Your Profile')
    end

    # check page
    expect(page).to have_selector('h1', text: user.username)
  end
end
