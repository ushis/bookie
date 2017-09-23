require 'rails_helper'

RSpec.describe 'Sign in', type: :feature do
  let!(:user) { factory.create }

  let(:factory) { Factory::User.new }

  let(:username) { factory.username }

  let(:password) { factory.password }

  before { visit '/' }

  it 'is possible to navigate to the sign in form and sign in' do
    # check navigation and navigate to sign in page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link('Sign in')
    end

    # check and fill form
    expect(page).to have_selector('form.new_user')

    within('form.new_user') do
      fill_in('Username or email', with: username)
      fill_in('Password', with: Factory::User.password)
      click_button('Sign in')
    end

    # check alert
    expect(page).to have_selector('.notification.is-danger')

    # check and fill form
    expect(page).to have_selector('form.new_user')

    within('form.new_user') do
      fill_in('Password', with: password)
      click_button('Sign in')
    end

    # check path and navigation
    expect(page).to have_current_path(root_path)
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      expect(page).to have_content(username)
    end
  end
end
