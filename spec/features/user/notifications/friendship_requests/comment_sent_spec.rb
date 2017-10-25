require 'rails_helper'

RSpec.describe 'Comment on sent friendship request', type: :feature do
  before {
    # FIXME: replace with factory
    User::Friendship::Request::Create.({
      id: receiver.id,
      friendship_request: {
        comments: [{comment: Faker::Lorem.paragraph}],
      },
    }, {
      current_user: current_user,
    })
  }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  let(:receiver) { Factory::User.create }

  let(:current_user) { current_user_factory.create }

  let(:current_user_factory) { Factory::User.new }

  it 'is possible to comment on a sent friendship request' do
    # check page and navigate to notifications
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link(title: 'Notifications')
    end

    # check page and navigate to sent friendship requests
    expect(page).to have_link('Sent')
    click_link('Sent')

    # check page and navigate to friendship request
    expect(page).to have_link(receiver.username)
    click_link(receiver.username)

    # check page and submit comment form
    expect(page).to have_selector('form.new_comment')

    within('form.new_comment') do
      click_button('Comment')
    end

    # check page and fill comment form
    expect(page).to have_selector('form.new_comment')

    within('form.new_comment') do
      expect(page).to have_selector('.help.is-danger')
      fill_in(name: 'comment[comment]', with: Faker::Lorem.paragraph)
      click_button('Comment')
    end

    # check page
    expect(page).to \
      have_selector('.comment .comment-header', {
        text: current_user.username,
        count: 2,
      })
  end
end
