PlayTheCall::Application.routes.draw do
  match ':slug', :to => 'pages#show', as: 'pages'

  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'm/:nickname/:slug' => 'mission_enrollments#show',  as: 'mission_enrollment'
  get 'ranking'           => 'ranking#show',              as: 'ranking'

  match 'countdown' => 'welcome#countdown', as: 'countdown'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :users
  resources :pages
  resources :missions, only: :show do
    resources :mission_enrollments, except: [:destroy, :index, :show] do
      resources :status_updates, except: [:index, :show]
      member do
        post 'check'
      end
    end
  end

  root to: 'welcome#index'
end
