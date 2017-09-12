require 'rails_helper'

RSpec.describe 'Search books', type: :feature do
  let!(:books) { 3.times.map { |_| Factory::Book.create } }

  let(:sample) { books.sample }

  before { visit('/') }

  it 'is possible to search for books' do
    # check navigation and enter search term
    expect(page).to have_selector('.navbar .navbar-form')

    within('.navbar .navbar-form') do
      fill_in('q', with: sample.title)
      click_button(class: 'btn')
    end

    # check results
    expect(page).to have_selector('a.thumbnail', count: 1)
    expect(page).to have_selector('a.thumbnail figcaption', text: sample.title)

    # check navigation and enter search term
    expect(page).to have_selector('.navbar .navbar-form')

    within('.navbar .navbar-form') do
      expect(page).to have_field('q', with: sample.title)

      fill_in('q', with: '')
      click_button(class: 'btn')
    end

    # check results
    expect(page).to have_selector('a.thumbnail', count: 3)
  end
end
