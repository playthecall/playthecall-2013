PlayTheCall::Application.routes.draw do

  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'm/:nickname/:slug' => 'mission_enrollments#show', as: 'mission_enrollment'
  match 'countdown'       => 'welcome#countdown',      as: 'countdown'
  match 'ranking'         => 'ranking#show',           as: 'ranking'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :users
  resources :missions do
    resources :mission_enrollments, only: [:new]
  end

  resources :mission_enrollments, only: [:edit]

  resources :mission_enrollments, except: [:show] do
    member do
      post 'check'
    end
  end

  root to: 'welcome#index'
end
