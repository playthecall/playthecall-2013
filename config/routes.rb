PlayTheCall::Application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                            :registrations => :registrations}

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'm/:nickname/:slug' => 'mission_enrollments#show',  as: 'mission_enrollment'
  get 'ranking'           => 'ranking#show',              as: 'ranking'
  get 'cities/by_country' => 'cities#by_country'

  match 'countdown' => 'welcome#countdown', as: 'countdown'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :users
  resources :missions, only: :show do
    member do
      get 'welcome'
    end
    resources :mission_enrollments, except: [:destroy, :index, :show] do
      resources :status_updates, except: [:index, :show]
      member do
        post 'check'
      end
    end
  end

  root to: 'welcome#index'
end
