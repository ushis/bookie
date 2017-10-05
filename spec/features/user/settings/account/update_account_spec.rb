require 'rails_helper'

RSpec.describe 'Update account', type: :feature do
  let(:current_user_factory) { Factory::User.new }

  let(:email) { Factory::User.email }

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
    expect(page).to have_selector('#account-form')

    within('#account-form') do
      fill_in('Email', with: email)
      fill_in('Current password', with: Factory::User.password)
      click_button('Update settings')
    end

    # check and fill form
    expect(page).to have_selector('#account-form')

    within('#account-form') do
      expect(page).to have_selector('#account-form-current-password.is-danger')
      fill_in('Current password', with: current_user_factory.password)
      click_button('Update settings')
    end

    # FIXME: check success message
    expect(page).to have_selector('#account-form')

    within('#account-form') do
      expect(page).to_not have_selector('#user_email.is-danger')
      expect(page).to_not have_selector('#account-form-current-password.is-danger')
    end
  end
end
