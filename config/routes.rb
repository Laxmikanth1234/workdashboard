Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'jobs#index'

  get '/register', to: 'users#new'
  get 'users/month', to: 'users#month'

  resources :clocks

  resources :jobs do
    member do
      post 'punch_in', to: 'punches#punch_in'
      post 'punch_out', to: 'punches#punch_out'
      post 'complete', to: 'jobs#complete'
      post 'restart', to: 'jobs#restart'
    end
  end
  
  devise_for :users
  
  resources :users, except: [:destroy] do
    member do
      post 'clock_in', to: 'clocks#clock_in'
      post 'clock_out', to: 'clocks#clock_out'
    end
  end
  resources :users, except: [:destroy]

end
