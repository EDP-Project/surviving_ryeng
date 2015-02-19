Rails.application.routes.draw do

#-- Basic routes --
  root 'main_pages#home'

  match '/home',    to: 'main_pages#home',    via: :get
  match '/about',   to: 'main_pages#about',   via: :get
  match '/contact', to: 'main_pages#contact', via: :get
  match '/admin_feed', to: 'main_pages#admin_feed', via: :get
#-- End of basic routes

#-- Cumulative searches --

  match '/search', to: 'searches#search', via: :get 

#-- User routes --
  #Devise user routes
  devise_for :users, :skip => [:sessions], controllers: {registrations: 'registrations'}

  as :user do
    #custom routes for logging in and out
    get '/signin' => 'devise/sessions#new', :as => :new_user_session
    post '/signin' => 'devise/sessions#create', :as => :user_session
    match '/signout' => 'devise/sessions#destroy', :as => :log_out, :via => :delete
    match '/signout' => 'devise/sessions#destroy', :via => :get
    #custom route for showing users via UsersController
    #(devise doesn't come with a 'show' view)
    #match '/users/:username', to: 'users#show', :as => :show_user, via: :get
  end

  #Route for allowing users to be viewed publicly
  match '/user/:username', to: 'users#show', as: :user, via: :get
  match '/users/:id', to: 'users#show', via: :get
  match '/users', to: 'users#index', via: :get

    resources :users, only: [:index] do
      resources :friend_requests, only: [:create]
      #resources :likes, only: [:create]
      #resources :messages, only: [:new]
    end
#-- End of User routes --

#-- Friendship routes --
  resources :friend_requests, only: [:destroy]
  resources :friendships, only: [:index, :create, :destroy]
#-- End of friendship routes --


#-- Attachment routes --
  concern :attachable do
    resources :attachments, only: [:create, :destroy]
  end

  resources :attachments, only: [:new, :create, :destroy]

#-- Course and Guide routes --
  match '/course/:course_code', as: :course, to: 'courses#show', via: :get 

  resources :courses, only: [:new, :index, :create], concerns: [:attachable] do
    resources :enrollments, only: [:create]
  end

  resources :guides, only: [:new, :create, :edit, :show, :update, :destroy], concerns: [:attachable]

  resources :enrollments, only: [:index, :destroy] 

  #match '/enroll/:course_code', to: 'enrollments#create', as: :enroll, via: :post
#-- End of courses routes --


#-- Guide routes --
  




#-- End of guides routes --



















  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index't

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
