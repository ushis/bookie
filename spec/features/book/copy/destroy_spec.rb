require 'rails_helper'

RSpec.describe 'Destroy copy', type: :feature do
  let!(:book) { Factory::Book.create }

  let!(:user) { user_factory.create }

  let(:user_factory) { Factory::User.new }

  before { Book::Copy::Create.({book_id: book.id}, {current_user: user}) }

  before { Bookie::Search.client.indices.refresh(index: 'books') }

  before { sign_in(user_factory.username, user_factory.password) }

  before { visit('/') }

  it 'is possible to destroy a copy' do
    # check navigation and search for isbn
    expect(page).to have_selector('.navbar')

    within('.navbar form') do
      fill_in('q', with: book.isbn)
      click_button(class: 'button')
    end

    # check and click link to book
    expect(page).to have_link(book.title)
    click_link(book.title)

    # check and click button to destroy copy
    expect(page).to have_button('I lost it')
    click_button('I lost it')

    # check page
    expect(page).to have_selector('h1', text: book.title)
    expect(page).to_not have_button('I lost it')
  end
end
