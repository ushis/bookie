class UsersController < ApplicationController

  # GET /users/:id
  def show
    run User::Show do |result|
      render_concept('user/cell/show', result['model'], {
        tab: result['tab'],
        books: result['books'],
        friends: result['friends'],
        friendship_request_contract: result['contract.friendship_request'],
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
    result = run(User::SignIn, params, {
      user_agent: request.user_agent,
      ip_address: request.remote_ip,
    })

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
    result = run(User::SignUp, params, {
      user_agent: request.user_agent,
      ip_address: request.remote_ip,
    })

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

  # POST /users/:id/create_friendship_request
  def create_friendship_request
    result = run User::Friendship::Request::Create

    User::Friendship::Request::Endpoint::Create.(result) do |m|
      m.success { redirect_to user_url(result['model']) }
      m.not_found { root_url }
      m.unauthorized { root_url }

      m.invalid {
        render_concept('user/cell/show', result['model'], {
          tab: result['tab'],
          books: result['books'],
          friends: result['friends'],
          friendship_request_contract: result['contract.friendship_request'],
        })
      }
    end
  end
end
