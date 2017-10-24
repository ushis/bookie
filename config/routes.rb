Rails.application.routes.draw do
  root 'books#index'

  get :health, to: 'health_checks#show'

  get    :sign_in,  to: 'users#sign_in_form'
  post   :sign_in,  to: 'users#sign_in'
  delete :sign_out, to: 'users#sign_out'

  get  :sign_up, to: 'users#sign_up_form'
  post :sign_up, to: 'users#sign_up'

  get :search, to: 'searches#index'

  resources :books, only: [:show, :create] do
    collection do
      get  :lookup, to: 'books#lookup_form'
      post :lookup, to: 'books#lookup'
    end
  end

  resource :copies, only: [:create] do
    collection do
      delete :index, to: 'copies#destroy'
    end
  end

  resources :users, only: [:show] do
    member do
      post :create_friendship_request
    end
  end

  namespace :notifications do
    resources :friendship_requests, only: [:index, :show] do
      member do
        post :accept
        post :comment
      end
    end
  end

  namespace :settings do
    resource :account, only: [:show, :update, :destroy] do
      resource :avatar, only: [] do
        patch :index, to: 'accounts#update_avatar'
      end

      resource :password, only: [] do
        patch :index, to: 'accounts#update_password'
      end
    end

    resource :security, only: [:show] do
      resources :sessions, only: [] do
        member do
          delete :index, to: 'securities#destroy_session'
        end
      end
    end
  end
end
