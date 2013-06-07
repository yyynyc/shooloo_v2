ShoolooV2::Application.routes.draw do


resources :users do
  member do
    get :following, :followers,  
        :posts, :rated_posts, :commented_posts, :alarmed_posts,
        :comments, :alarmed_comments, 
        :liked_posts, :liked_comments
  end
  collection { post :search, to: 'users#index' }
end
resources :sessions, only: [:new, :create, :destroy]
resources :relationships, only: [:create, :destroy]
resources :nudges, only: [:create, :destroy]
resources :posts do
  resources :likes, only: [:create, :destroy]
  resources :ratings 
  resources :comments do
    resources :alarms, only: [:create, :destroy]
  end
  resources :alarms, only: [:create, :destroy]
  member do
    get :raters
  end
  collection { post :search, to: 'posts#index' }
end
resources :ratings do
  member do
    get :operations, :improvements, :flags
  end
end
resources :comments do
  resources :alarms
  resources :likes, only: [:create, :destroy]
end
resources :alarms
resources :likes, only: [:create, :destroy]
resources :activities
resources :password_resets
resources :authorizations do 
  member do
    put :decline
  end
  collection { post :search, to: 'authorizations#new' }
end
resources :referrals do 
  collection { post :search, to: 'referrals#new' }
end
resources :ref_checks
resources :user_steps
    root to: "static_pages#home"
 
  match '/about', to: 'static_pages#about'
  match '/team', to: 'static_pages#team'
  match '/advisors', to: 'static_pages#advisors'
  match '/help', to: 'static_pages#help'
  match '/contact', to: 'static_pages#contact'
  match '/rules', to: 'static_pages#rules'
  match '/terms', to: 'static_pages#terms'
  match '/privacy', to: 'static_pages#privacy'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete 
  match '/alarmed_posts', to: "alarms#alarmed_posts"
  match '/my_alerts', to: "users#show_activity"
  match '/my_abilities', to: "users#my_abilities"
  match 'hidden', to: "users#hidden"
 

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
