Rails.application.routes.draw do
  resources :replies do
    member do
      put "like", to: "replies#upvote"
    end
  end
  
  resources :submissions  do
    member do
      put "like", to: "submissions#upvote"
    end
  end
  
  resources :comments do
    member do
      put "like", to: "comments#upvote"
    end
  end  
    
  resources :users 
  
  get '/auth/:provider/callback', to:'sessions#create'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  # You can have the root of your site routed with "root"
  root 'submissions#index'
  
  
  #api
  
  scope '/api', defaults: {format: :json} do
    scope '/submissions' do
      get '/' => 'api/submissions#index'
      post '/' => 'api/submissions#create'
      scope '/:id' do
        get '/' => 'api/submissions#show'
        get '/comments' => 'api/submissions#comments'
        delete '/' => 'api/submissions#delete'
        put '/vote' => 'api/submissions#upvote'
      end
    end
    scope '/comments' do
      get '/' => 'api/comments#index'
      post '/' => 'api/comments#create'
      scope '/:id' do
        get '/' => 'api/comments#show'
        get '/replies' => 'api/comments#replies'
        put '/vote' => 'api/comments#upvote'
      end
    end
    scope '/users' do
      get '/' => 'api/users#index'
      scope '/:id' do
        get '/' => 'api/users#show'
        put '/' => 'api/users#edit'
        get '/submissions' => 'api/users#submissions'
        get '/comments' => 'api/users#comments'
        get '/replies' => 'api/users#replies'
      end
    end
    scope '/replies' do
      get '/' => 'api/replies#index'
      post '/' => 'api/replies#create'
      scope '/:id' do
        get '/' => 'api/replies#show'
        put '/vote' => 'api/replies#upvote'
      end
    end
  end
  
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
