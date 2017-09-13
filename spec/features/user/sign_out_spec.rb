require 'rails_helper'

RSpec.describe 'Sign out', type: :feature do
  let!(:user) { factory.create }

  let(:factory) { Factory::User.new }

  before { sign_in(factory.username, factory.password) }

  it 'is possible to sign out' do
    # check navigation and sign out
    expect(page).to have_selector('nav.navbar')

    within('nav.navbar') do
      click_link('Sign out')
    end

    # check navigation
    expect(page).to have_selector('nav.navbar')

    within('nav.navbar') do
      expect(page).to have_link('Sign in')
    end
  end
end
