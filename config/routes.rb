DealGo::Application.routes.draw do
  root :to => "static#home"
  get "/authorize" => "users#authorize"
  get "/signup/:type" => "users#new"
  get "/register/merchant" => "users#new_merchant"
  post "/register/merchant" => "users#create_merchant"
  post "/register/consumer" => "users#create_consumer"

  get "/signin" => "sessions#new"
  match "signout", to: 'sessions#destroy', via: :delete

  get "/admin/deals" => "admin#deals"
  get "/admin/deals/:id" => "admin#deals"
  get "/admin/merchants" => "admin#merchants"
 
  
  get "/merchants/signup" => "merchants#new"
  get "/merchants/:id/deal" => "merchants#current_deal"
  get "/merchants/:id/history" => "merchants#history"
  get "/merchants/:id/profile" => "merchants#profile"
  resources :merchants, only: [:show, :create]

  #sessions
  resources :sessions, only: [:new, :create, :destroy]

  # Deals
  get "deals/:merchant_code" => "deals#deal"
  get "deals/:merchant_code/purchase" => "deals#purchase"
  post "deals/:merchant_code/purchase" => "deals#submit"
  match "deals/:merchant_code/:purchase_code" => "deals#confirmation"

  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
