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
  resources :groups
  resources :contacts
  get 'learn_time/create/:link_id' => 'learn_time#create', as: :learn_time
  post 'links/list_selected' => 'links#list_selected'
  post 'links/remove_selected' => 'links#remove_selected'
  post '/links/send_links' => 'links#send_links'
  get 'charts/chart_by_learn(/:days)' => 'charts#chart_by_learn', as: :chart_by_learn

  post 'groups/add_member/:id' => 'groups#add_member', as: :add_member
  post 'groups/remove_member' => 'groups#remove_member', as: :remove_member
  post 'links/final_sender' => 'links#final_sender', as: :final_sender
  post 'links/toggle' => 'favourites#toggle', :as => :toggle_favourite
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords'}
end
