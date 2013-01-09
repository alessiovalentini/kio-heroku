Kio::Application.routes.draw do
  resources :reports
  resources :grounds
  resources :news
  resources :authentications

  # omniauth routes
  # match '/auth/:provider/callback' => 'authentications#callback_login'  # provider dynamically change ex. salesforce
  # match '/signout' => 'authentications#signout', :as => :signout

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"
end
