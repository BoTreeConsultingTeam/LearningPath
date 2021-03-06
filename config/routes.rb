Rails.application.routes.draw do

  root 'links#index'
  get 'links/favourites' => 'links#favourites', :as => :favourite_links
  get 'links/import_form' => 'links#import_form', :as => :links_import_form
  post 'links/search' => 'links#search', as: :links_search
  resources :links do
    collection { post :import }
  end
  resources :tag
  resources :favourites
  get 'learn_time/create/:link_id' => 'learn_time#create', as: :learn_time

  get 'charts/chart_by_learn(/:days)' => 'charts#chart_by_learn', as: :chart_by_learn
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # devise_scope :users do
  #   get '/users' => 'users#index'
  # end
  post 'links/toggle' => 'favourites#toggle', :as => :toggle_favourite
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords'}

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
