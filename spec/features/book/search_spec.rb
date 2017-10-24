require 'rails_helper'

RSpec.describe 'Search books', type: :feature do
  let!(:books) { Array.new(3) { |_| Factory::Book.create } }

  let(:sample) { books.sample }

  let(:word) { sample.title.split.sample }

  let(:words) { books.map { |book| book.authors.split.sample } }

  before { Bookie::Search.client.indices.refresh(index: 'books') }

  before { visit('/') }

  it 'is possible to search for books' do
    # check navigation and enter search term
    expect(page).to have_selector('.navbar form')

    within('.navbar form') do
      fill_in('q', with: word)
      click_button(class: 'button')
    end

    # check results
    expect(page).to have_selector('.box', minimum: 1)
    expect(page).to have_selector('.box', text: sample.title)

    # check navigation and enter search term
    expect(page).to have_selector('.navbar form')

    within('.navbar form') do
      expect(page).to have_field('q', with: word)

      fill_in('q', with: words.join(' '))
      click_button(class: 'button')
    end

    # check results
    expect(page).to have_selector('.box', count: 3)

    # check navigation and enter search term
    expect(page).to have_selector('.navbar form')

    within('.navbar form') do
      fill_in('q', with: '')
      click_button(class: 'button')
    end

    # check results
    expect(page).to have_content("We couldn't find any books")
  end
end
