Weather_maps::Application.routes.draw do

  get 'pages/home'

  devise_for :user, controllers: {
      sessions: "sessions",
      registrations: "registrations",
      passwords: "passwords",
      confirmations: "confirmations"
  }

  root :to => "pages#home"
end
