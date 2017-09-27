require 'rails_helper'

RSpec.describe 'Update password', type: :feature do
  let(:current_user_factory) { Factory::User.new }

  let(:password) { Factory::User.password }

  let!(:current_user) { current_user_factory.create }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  before { visit('/') }

  it 'is possible to update account settings' do
    # check navigation and visit settings page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link('Settings')
    end

    # check and fill form
    expect(page).to have_selector('#password-form')

    within('#password-form') do
      fill_in('Password', with: password)
      fill_in('Repeat your password', with: password)
      fill_in('Current password', with: Factory::User.password)
      click_button('Update password')
    end

    # check and fill form
    expect(page).to have_selector('#password-form')

    within('#password-form') do
      expect(page).to have_selector('.user_current_password .input.is-danger')
      fill_in('Password', with: password)
      fill_in('Repeat your password', with: password)
      fill_in('Current password', with: current_user_factory.password)
      click_button('Update password')
    end

    # FIXME: check success message
    expect(page).to have_selector('#password-form')

    within('#password-form') do
      expect(page).to_not have_selector('.user_password .input.is-danger')
      expect(page).to_not have_selector('.user_password_confirmation .input.is-danger')
      expect(page).to_not have_selector('.user_current_password .input.is-danger')
    end
  end
end
