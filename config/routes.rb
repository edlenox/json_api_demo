Rails.application.routes.draw do
  namespace :api do
    resources :persons
  end


  match "*path", :to => "application#routing_error", :via => :all
end
