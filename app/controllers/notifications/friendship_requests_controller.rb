module Notifications
  class FriendshipRequestsController < ApplicationController

    # GET /notifications/friendship_requests
    def index
      run User::Notifications::FriendshipRequest::Index do |result|
        render_concept('user/notifications/friendship_request/cell/index', nil, {
          tab: result['tab'],
          state: result['state'],
          received_friendship_requests: result['received_friendship_requests'],
          sent_friendship_requests: result['sent_friendship_requests'],
        })
        return
      end

      redirect_to root_url
    end

    # GET /notifications/friendship_requests/:id
    def show
      run User::Friendship::Request::Show do |result|
        render_concept('user/notifications/friendship_request/cell/show', result['model'], {
          comments: result['comments'],
          comment_contract: result['contract.comment'],
        })
        return
      end

      redirect_to root_url
    end

    # POST /notifications/friendship_requests/:id/accept
    def accept
      run User::Friendship::Request::Accept do |result|
        redirect_to notifications_friendship_request_url(result['model'])
        return
      end

      redirect_to notifications_friendship_requests_url
    end

    # POST /notifications/friendship_requests/:id/comment
    def comment
      result = run User::Friendship::Request::Comment
      # FIXME: use endpoint

      if result.success?
        redirect_to notifications_friendship_request_url(result['model'])
        return
      end

      if result['result.policy.default'].failure?
        redirect_to root_url
        return
      end

      render_concept('user/notifications/friendship_request/cell/show', result['model'], {
        comments: result['comments'],
        comment_contract: result['contract.comment'],
      })
    end
  end
end
