PersonalWire::Application.routes.draw do

  get "destinations/create"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'


  get 'sources/dropbox/new' => 'sources#dropbox_new', as: :dropbox_new
  get 'sources/dropbox/create' => 'sources#dropbox_create', as: :dropbox_create

  get 'auth/:destinations/callback' => 'destinations#new_destination_service'
  get 'destinations/facebook_page/:facebook_id' => 'destinations#list_facebook_page' 
  get 'destinations/facebook_page/:facebook_id/add/:uid' => 'destinations#add_facebook_page', as: :add_fb_page
  get '/destinations/wordpress/new'  => 'destinations#wordpress_new'
  post '/destinations/wordpress'  => 'destinations#wordpress_create', as: :wordpress_create

  resources :destinations do 
    member do
      get :enable
      get :disable
    end
    
  end

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
