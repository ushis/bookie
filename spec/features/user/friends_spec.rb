require 'rails_helper'

RSpec.describe 'View a users friends', type: :feature do
  let!(:user) { Factory::User.create }

  let!(:friend) { Factory::User.create }

  before {
    Factory::FriendshipRequest.create({
      id: friend.id,
    }, {
      current_user: user,
    })

    User::Friendship::Request::Accept.({
      id: friend.received_friendship_requests.find_by(sender: user).id,
    }, {
      current_user: friend,
    })
  }

  before { visit('/') }

  it 'is possible to view a users friends' do
    # check navigation and enter search term
    expect(page).to have_selector('.navbar form')

    within('.navbar form') do
      fill_in('q', with: user.username)
      click_button(class: 'button')
    end

    # check navigation and visit users
    expect(page).to have_selector('.navbar .navbar-tabs')

    within('.navbar .navbar-tabs') do
      click_link('Users')
    end

    # check page and navigate to users profile
    expect(page).to have_link(user.username)
    click_link(user.username)

    # check page and navigate to users friends
    expect(page).to have_selector('.tabs')

    within('.tabs') do
      click_link('Friends')
    end

    # check page
    expect(page).to have_selector('.box', text: friend.username)
  end
end
