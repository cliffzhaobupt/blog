Blog::Application.routes.draw do
  root "user#index"

  post "users/new", to: "user#new"
  get "users/login", to: "user#login"
  get "users/logout", to: "user#logout"
  get "users/index", to: "user#index"
  get "users", to: "user#index"
  get "users/photo", to: "user#photo"
  get "users/small_photo", to: "user#small_photo"
  
  get "blogs/listbyuser", to: "blog#listbyuser"
  get "blogs/articledetail", to: "blog#articledetail"
  get "blogs/new", to: "blog#new"
  post "blogs/save", to: "blog#save"
  delete "blogs/delete", to: "blog#delete"
  get "blogs/edit", to: "blog#edit"
  patch "blogs/update", to: "blog#update"
  get "blogs/listbytag", to: "blog#listbytag"

  get "comments/getcomments", to: "comment#getcomments"
  post "comments/new", to: "comment#new"

  get "tags/get", to: "tag#get"
  post "tags/add", to: "tag#add"

  get "photos/new", to: "photo#new"
  post "photos/upload", to: "photo#upload"
  get "photos/getoriginal", to: "photo#getoriginal"
  get "photos/getthumbnail", to: "photo#getthumbnail"
  post "photos/updateintro", to: "photo#updateintro"
  get "photos/list", to: "photo#list"
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
