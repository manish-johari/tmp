Rails.application.routes.draw do

  devise_for :users

  scope module: 'web' do
    root to: 'home#index', :as => :root
  end

  namespace :api, defaults: {format: 'json'} do

    namespace :v1 do
      devise_scope :user do
        post 'users/sign_in' => 'sessions#create'
        delete 'users/sign_out' => 'sessions#destroy'
        post 'users/password' => 'passwords#create'
        put 'users/password' => 'passwords#update'
        post 'users/sign_up' => 'registrations#create'
        post 'users/confirmation' => 'confirmations#create'
        post 'users/confirm_token' => 'confirmations#confirm_token'
      end
      post 'deactivate' => 'profile#deactivate'
      resources :interests, only: [:index]
      resources :myinterests, only: [:index]
    end

  end

end
