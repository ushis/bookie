module FeatureHelper

  def sign_in(username, password)
    # visit root page
    visit('/')

    # check navigation and navigate to sign in page
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      click_link('Sign in')
    end

    # check and fill form
    expect(page).to have_selector('form.new_user')

    within('form.new_user') do
      fill_in('Username or email', with: username)
      fill_in('Password', with: password)
      click_button('Sign in')
    end

    # check path and navigation
    expect(page).to have_selector('.navbar')

    within('.navbar') do
      expect(page).to have_selector('.avatar')
    end

    # visit root page
    visit('/')
  end
end
