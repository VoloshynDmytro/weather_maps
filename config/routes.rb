Weather_maps::Application.routes.draw do

  resources :measurements

  resources :locations

  get 'pages/home'

  devise_for :user, controllers: {
      sessions: "sessions",
      registrations: "registrations",
      passwords: "passwords",
      confirmations: "confirmations"
  }

  resources :users

  root :to => "pages#home"
end
