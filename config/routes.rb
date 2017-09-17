Rails.application.routes.draw do
  root 'books#index'

  get    '/sign_in',  to: 'users#sign_in_form'
  post   '/sign_in',  to: 'users#sign_in'
  delete '/sign_out', to: 'users#sign_out'

  get  '/sign_up', to: 'users#sign_up_form'
  post '/sign_up', to: 'users#sign_up'

  resources :books, only: [:show, :create] do
    collection do
      get  '/lookup', to: 'books#lookup_form'
      post '/lookup', to: 'books#lookup'
    end
  end

  resource :copies, only: [:create] do
    collection do
      delete '/', to: 'copies#destroy'
    end
  end

  resources :users, only: [:show]
end
