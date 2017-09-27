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

  resources :users, only: [:show]

  namespace :settings do
    resource :account, only: [:show, :update, :destroy] do
      patch :password, to: 'accounts#update_password'
    end
  end
end
