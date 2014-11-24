Weather_maps::Application.routes.draw do
  scope "/:locale" do
    resources :users, only:[:index, :show]
    devise_for :user, controllers: {
        sessions: "sessions",
        registrations: "registrations",
        passwords: "passwords",
        confirmations: "confirmations"
    }
    #get 'pages/home'


  end
  authenticated :user, lambda {|u| u.role == 1} do
    root :to => "users#admin_dashboard", :as => "admin_root"
  end
  root :to => "pages#home"

  #get "user/dashboard", to: "users#dashboard", as: :dashboard
  #get "admin/dashboard", to: "users#admin_dashboard", as: :admin_dashboard


end
