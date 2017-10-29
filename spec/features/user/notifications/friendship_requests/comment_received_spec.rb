require 'rails_helper'

RSpec.describe 'Comment on received friendship request', type: :feature do
  before {
    Factory::FriendshipRequest.create({
      id: current_user.id,
    }, {
      current_user: sender,
    })
  }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  let(:sender) { Factory::User.create }

  let(:current_user) { current_user_factory.create }

  let(:current_user_factory) { Factory::User.new }

  it 'is possible to comment on a received friendship request' do
    # check page and navigate to notifications
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link(title: 'Notifications')
    end

    # check page and navigate to friendship request
    expect(page).to have_link(sender.username)
    click_link(sender.username)

    # check page and submit comment form
    expect(page).to have_selector('#comment-form')

    within('#comment-form') do
      click_button('Comment')
    end

    # check page and fill comment form
    expect(page).to have_selector('#comment-form')

    within('#comment-form') do
      expect(page).to have_selector('.textarea.is-danger')
      fill_in(class: 'textarea', with: Faker::Lorem.paragraph)
      click_button('Comment')
    end

    # check page
    expect(page).to \
      have_selector('.comment .comment-header', text: current_user.username)
  end
end
