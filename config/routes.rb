Rails.application.routes.draw do
  resources :followers do
    collection do
      get 'get_following'
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks", sessions: 'user_sessions', 
    registrations: 'user_registrations', passwords: 'user_passwords'
  }
  resources :users, only: [:show, :index, :edit, :update] do
    collection do
      get 'follow'
      get 'unfollow'
    end
  end
  
  resources :media do
    resources :slams
    resources :comments
    get 'like'
    get 'dislike'
    get 'unlike'
    get 'undislike'
    member do
      post 'challenge'
    end
#    get 'new_comment'
    collection do
      get 'my_media'
    end
  end
  #match "/my_media" => "media#my_media", via: [:get]

  resources :members, only: [:index, :create, :show, :destroy]

  resources :group_shares

  resources :user_groups do
    resources :members
    collection do
      get 'my_group'
    end
  end

  resources :user_votes, only: [:index, :show]

  resources :slams do 
    resources :user_votes do
      collection do
        get 'first_liked'
        get 'second_liked'
      end
    end
  end

  get 'welcome/index'
   
  
#  devise_scope :user do
#    get 'login' => 'devise/sessions#new', as: :login
#    delete 'logout' => 'devise/sessions#destroy', as: :logout
#    get 'signup' => 'devise/registrations#new', as: :signup
#  end
  
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

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
