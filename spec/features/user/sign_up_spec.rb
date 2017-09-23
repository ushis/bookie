require 'rails_helper'

RSpec.describe 'Sign up', type: :feature do
  let(:factory) { Factory::User.new }

  before { NetStub::RoboHash.stub_request(factory.username, factory.email) }

  before { visit('/') }

  it 'is possible to navigate to the sign up form and sign up' do
    # check navigation and navigate to sign in page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link('Sign in')
    end

    # check page and navigate to sign up page
    expect(page).to have_content('Sign in to Bookie')

    click_link('Create an account.')

    # check and fill form
    expect(page).to have_selector('form.new_user')

    within('form.new_user') do
      fill_in('Username', with: factory.username)
      fill_in('Email', with: factory.email)
      fill_in('Password', with: factory.password)
      fill_in('Repeat your password', with: Factory::User.password)
      click_button('Create an account')
    end

    # check and fill form
    expect(page).to have_selector('form.new_user')

    within('form.new_user') do
      expect(page).to have_selector('.user_password_confirmation .input.is-danger')
      fill_in('Password', with: factory.password)
      fill_in('Repeat your password', with: factory.password_confirmation)
      click_button('Create an account')
    end

    # check path and navigation
    expect(page).to have_current_path(root_path)
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      expect(page).to have_content(factory.username)
    end
  end
end
