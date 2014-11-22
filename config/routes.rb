Weather_maps::Application.routes.draw do
  scope "/:locale" do
    resources :measurements
    resources :locations
    resources :users, only:[:index, :show]
    get "user/dashboard", to: "users#dashboard", as: :dashboard
    get "admin/dashboard", to: "users#admin_dashboard", as: :admin_dashboard

    devise_for :user, controllers: {
        sessions: "sessions",
        registrations: "registrations",
        passwords: "passwords",
        confirmations: "confirmations"
    }
    get 'pages/home'

  end
  root :to => "pages#home"
end
