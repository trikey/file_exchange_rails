Rails.application.routes.draw do
  get 'users/index' => 'users#index', as: :users

  get 'users/create' => 'users#create', as: :admin_users_create
  delete 'users/:id' => 'users#destroy', as: :admin_users_delete
  post 'users/create' => 'users#storeUser', as: :admin_users_store
  get 'users/:id/edit' => 'users#editUser', as: :admin_users_edit
  put 'users/:id/edit' => 'users#updateUser', as: :admin_users_update

  get 'folders' => 'folders#index', as: :folders
  get 'login' => 'folders#index', as: :login
  get 'register' => 'folders#index', as: :register
  get 'password_reset' => 'folders#index', as: :password_reset
  get 'logout' => 'folders#index', as: :logout



  get 'folders' => 'folders#index', as: :admin_folders
  delete 'folders/:id' => 'folders#destroy', as: :admin_folders_delete
  get 'folders/create' => 'folders#create', as: :admin_folders_create
  get 'folders/gettree' => 'folders#getTree', as: :get_folders_tree
  post 'folders/create' => 'folders#store', as: :admin_folders_store
  get 'folders/:id/edit' => 'folders#edit', as: :admin_folders_edit
  put 'folders/:id/edit' => 'folders#update', as: :admin_folders_update
  get 'folders/:id' => 'folders#viewFolder', as: :admin_folder_view

  get 'files/getmodal' => 'files#getModal', as: :admin_files_get_modal
  get 'files/getmodal/:id' => 'files#getModalForUpdate', as: :admin_files_get_modal_update
  post 'files/multi' => 'files#multiHandle', as: :admin_files_multi_post
  delete 'files/:id' => 'files#destroy', as: :admin_files_delete
  post 'files/create' => 'files#store', as: :admin_files_store
  put 'files/:id/edit' => 'files#update', as: :admin_files_update
  get 'files/:id' => 'files#download', as: :admin_files_download

  get 'search' => 'folders#search', as: :search
  get 'users/search' => 'users#search', as: :users_search

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
