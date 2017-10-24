require 'rails_helper'

RSpec.describe 'Create friendship request', type: :feature do
  let!(:receiver) { Factory::User.create }

  let!(:current_user) { current_user_factory.create }

  let(:current_user_factory) { Factory::User.new }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  it 'is possible to create a friendship request' do
    # check navigation and search for user
    expect(page).to have_selector('.navbar form')

    within('.navbar form') do
      fill_in('q', with: receiver.username)
      click_button(class: 'button')
    end

    # check navigation and visit users
    expect(page).to have_selector('.navbar .navbar-tabs')

    within('.navbar .navbar-tabs') do
      click_link('Users')
    end

    # check results and navigate to the receivers profile
    expect(page).to have_selector('.box', text: receiver.username)
    click_link(receiver.username, class: 'box')

    # check page and open friendship request modal
    expect(page).to have_selector('.button', text: 'I know this person')
    find('.button', text: 'I know this person').click

    # check modal and submit form
    expect(page).to have_selector('.modal', text: 'Send friendship request')

    within('.modal', text: 'Send friendship request') do
      click_button('Submit')
    end

    # check page and fill form
    expect(page).to have_selector('.modal', text: 'Send friendship request')

    within('.modal', text: 'Send friendship request') do
      expect(page).to have_selector('.help.is-danger')

      fill_in('friendship_request[comments_attributes][0][comment]', {
        with: Faker::Lorem.paragraph,
      })

      click_button('Submit')
    end

    # check page
    # FIXME: check indicator that there is a pending request
    expect(page).to_not have_selector('.button', text: 'I know this person')
  end
end
