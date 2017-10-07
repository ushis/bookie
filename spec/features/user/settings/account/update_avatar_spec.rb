require 'rails_helper'

RSpec.describe 'Update avatar', type: :feature do
  let(:current_user_factory) { Factory::User.new }

  let(:document) { Fixture::Document.new }

  let(:image) { Fixture::Image.new }

  let!(:current_user) { current_user_factory.create }

  before { sign_in(current_user_factory.username, current_user_factory.password) }

  before { visit('/') }

  it 'is possible to upload a new avatar' do
    # check navigation and visit settings page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      find('.avatar').hover
      click_link('Settings')
    end

    # check and fill form
    expect(page).to have_selector('#avatar-form')

    # Selenium file_detector
    within('#avatar-form') do
      attach_file('Upload new avatar', document.path)
    end

    # check and fill form
    expect(page).to have_selector('#avatar-form')

    # Selenium file_detector
    within('#avatar-form') do
      expect(page).to have_selector('.help.is-danger')
      attach_file('Upload new avatar', image.path)
    end

    # check form
    expect(page).to have_selector('#avatar-form')

    # Selenium file_detector
    within('#avatar-form') do
      expect(page).to_not have_selector('.help.is-danger')
    end
  end
end
