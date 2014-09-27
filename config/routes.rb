Weather_maps::Application.routes.draw do

  get 'pages/home'

  devise_for :users,  :controllers => {:registrations => "registrations"}, :skip => [:sessions]
    as :user do
    get '/admin' => 'devise/sessions#new', :as => :new_user_session
    post '/admin' => 'devise/sessions#create', :as => :user_session
    delete '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  root :to => "users#index"
end
