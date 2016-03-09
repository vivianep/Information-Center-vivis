Rails.application.routes.draw do
  get 'authentication/login'
  post 'authentication/login'

  get 'authentication/welcome'
  post 'authentication/welcome'

  get 'authentication/error'
  post 'authentication/error'

  get 'authentication/navigate'
	post 'authentication/navigate'

	get 'authentication/files'
  post 'authentication/files'

	get 'authentication/navigation_params'
	post 'authentication/navigation_params'

  post 'upload' => 'authentication#upload'

  get 'refresh' => 'authentication#refresh'

  post 'rename' => 'authentication#refresh'

  post 'move' => 'authentication#move'

  post 'remove' => 'authentication#remove'
  
  get 'login1' => 'sessions#new'

  post 'sessions/create'
  
  get 'logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'
  
  get 'error' => 'sessions#error'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'authentication#login'

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
