require 'rails_helper'

RSpec.describe 'Accept friendship request', type: :feature do
  before {
    # FIXME: replace with factory
    User::Friendship::Request::Create.({
      id: current_user.id,
      friendship_request: {
        comments: [{comment: Faker::Lorem.paragraph}],
      },
    }, {
      current_user: sender,
    })
  }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  let(:sender) { Factory::User.create }

  let(:current_user) { current_user_factory.create }

  let(:current_user_factory) { Factory::User.new }

  it 'is possible to accept a received friendship request' do
    # check page and navigate to notifications
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link(title: 'Notifications')
    end

    # check page and navigate to friendship request
    expect(page).to have_link(sender.username)
    click_link(sender.username)

    # check page and accept request
    expect(page).to have_selector('.tag', text: 'Open')
    click_button('Accept request')

    # check page
    expect(page).to have_selector('.tag', text: 'Accepted')
  end
end
