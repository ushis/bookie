require_dependency 'bookie/operation'
require_dependency 'friendship_request'
require_dependency 'user/find'
require_dependency 'user/friendship/request/contract/create'

class User < ApplicationRecord
  class Show < Bookie::Operation
    TABS = [:books, :friends]

    step self::Nested(Find)
    step self::Contract::Build({
      constant: Friendship::Request::Contract::Create,
      builder: :friendship_request_contract!,
      name: :friendship_request,
    })
    step :tab!
    step :books!
    step :friends!

    def friendship_request_contract!(options, constant:, current_user:, model:, **)
      constant.new(::FriendshipRequest.new, {
        sender: current_user,
        receiver: model,
        comments: [::Comment.new(author: current_user)],
      })
    end

    def tab!(options, params:, **)
      options['tab'] = TABS.find { |tab| tab.to_s == params[:tab] } || TABS.first
    end

    def books!(options, model:, params:, **)
      options['books'] = model
        .books
        .includes(:cover)
        .order('copies.created_at desc')
        .page(params[:page])
        .per(30)
    end

    def friends!(options, model:, params:, **)
      options['friends'] = model
        .friends
        .includes(:avatar)
        .order('users.username asc')
        .page(params[:page])
        .per(30)
    end
  end
end
