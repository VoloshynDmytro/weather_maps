Weather_maps::Application.routes.draw do
  scope "/:locale" do
    resources :measurements
    resources :locations
    resources :users
    get 'pages/home'

    devise_for :user, controllers: {
        sessions: "sessions",
        registrations: "registrations",
        passwords: "passwords",
        confirmations: "confirmations"
    }

  end
  root :to => "pages#home"
end
