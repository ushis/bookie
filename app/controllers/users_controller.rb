class UsersController < ApplicationController

  # GET /users/:id
  def show
    run User::Show do |result|
      render_concept('user/cell/show', result['model'], {
        books: result['books'],
      })
      return
    end

    redirect_to root_url
  end

  # GET /sign_in
  def sign_in_form
    run User::SignIn::New do |result|
      render_concept('user/cell/sign_in', nil, {
        contract: result['contract.default'],
        layout: Bookie::Cell::Layout::Empty,
      })
      return
    end

    redirect_to root_url
  end

  # POST /sign_in
  def sign_in
    result = run User::SignIn

    if result.success?
      cookies.permanent.encrypted[:session_id] = result['session'].id
      redirect_to root_url
      return
    end

    render_concept('user/cell/sign_in', nil, {
      contract: result['contract.default'],
      error: result['error'],
      layout: Bookie::Cell::Layout::Empty,
    })
  end

  # DELETE /sign_out
  def sign_out
    run User::SignOut
    redirect_to root_url
  end

  # GET /sign_up
  def sign_up_form
    run User::SignUp::New do |result|
      render_concept('user/cell/sign_up', nil, {
        contract: result['contract.default'],
        layout: Bookie::Cell::Layout::Empty,
      })
      return
    end

    redirect_to root_url
  end

  # POST /sign_up
  def sign_up
    result = run User::SignUp

    if result.success?
      cookies.permanent.encrypted[:session_id] = result['session'].id
      redirect_to root_url
      return
    end

    render_concept('user/cell/sign_up', nil, {
      contract: result['contract.default'],
      layout: Bookie::Cell::Layout::Empty,
    })
  end
end
