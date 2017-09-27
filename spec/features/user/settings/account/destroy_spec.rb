require 'rails_helper'

require 'rails_helper'

RSpec.describe 'Destroy account', type: :feature do
  let(:current_user_factory) { Factory::User.new }

  let(:email) { Factory::User.email }

  let!(:current_user) { current_user_factory.create }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  before { visit('/') }

  it 'is possible to destroy the users account' do
    # check navigation and visit settings page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link('Settings')
    end

    # check and fill form
    expect(page).to have_selector('#destroy-form')

    within('#destroy-form') do
      fill_in('Current password', with: Factory::User.password)
      click_button('Delete account')
    end

    # check and fill form
    expect(page).to have_selector('#destroy-form')

    within('#destroy-form') do
      expect(page).to have_selector('.user_current_password .input.is-danger')
      fill_in('Current password', with: current_user_factory.password)
      click_button('Delete account')
    end

    # check navigation
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      expect(page).to have_link('Sign in')
    end
  end
end
