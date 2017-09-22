require 'rails_helper'

RSpec.describe 'Search users', type: :feature do
  let!(:users) { Array.new(3) { |_| Factory::User.create } }

  let(:sample) { users.sample }

  let(:username) { sample.username }

  let(:usernames) { users.map(&:username) }

  before { Bookie::Search.client.indices.refresh(index: 'users') }

  before { visit('/') }

  it 'is possible to search for users' do
    # check navigation and enter search term
    expect(page).to have_selector('.navbar .navbar-form')

    within('.navbar .navbar-form') do
      fill_in('q', with: username)
      click_button(class: 'btn')
    end

    # check navigation and visit users
    expect(page).to have_selector('.nav', text: 'Users')

    within('.nav', text: 'Users') do
      click_link('Users')
    end

    # check results
    expect(page).to have_selector('a.thumbnail', minimum: 1)
    expect(page).to have_selector('a.thumbnail figcaption', text: sample.username)

    # check navigation and enter search term
    expect(page).to have_selector('.navbar .navbar-form')

    within('.navbar .navbar-form') do
      expect(page).to have_field('q', with: username)

      fill_in('q', with: usernames.join(' '))
      click_button(class: 'btn')
    end

    # check results
    expect(page).to have_selector('a.thumbnail', minimum: 3)

    # check navigation and enter search term
    expect(page).to have_selector('.navbar .navbar-form')

    within('.navbar .navbar-form') do
      fill_in('q', with: '')
      click_button(class: 'btn')
    end

    # check results
    expect(page).to have_content("We couldn't find any users")
  end
end
