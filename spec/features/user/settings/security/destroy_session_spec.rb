require 'rails_helper'

RSpec.describe 'Destroy session', type: :feature do
  let(:current_user_factory) { Factory::User.new }

  let!(:current_user) { current_user_factory.create }

  let!(:session) { Factory::Session.create({}, user: current_user) }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  before { visit('/') }

  it 'is possible to destroy sessions' do
    # check navigation and visit settings page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      find('.avatar').hover
      click_link('Settings')
    end

    # check navigation and visit security page
    expect(page).to have_selector('.panel', text: 'Personal settings')

    within('.panel', text: 'Personal settings') do
      click_link('Security')
    end

    # check page and destroy session
    expect(page).to have_selector('.box', text: session.ip_address)

    within('.box', text: session.ip_address) do
      click_link('Revoke')
    end

    # check page
    expect(page).to_not have_selector('.box', text: session.ip_address)
  end
end
