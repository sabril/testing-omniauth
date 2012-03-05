TestingOmniauth::Application.routes.draw do

  resource :session

  match "auth/failure"            => "sessions#create"
  match "auth/:provider/callback" => "sessions#create",  as: "omniauth_callback"
  match "logout"                  => "sessions#destroy", as: "logout"

  root :to => "welcome#index"

end
