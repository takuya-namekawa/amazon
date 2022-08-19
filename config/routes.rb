Rails.application.routes.draw do
  namespace :public do
    get 'cart_items/index'
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  namespace :public do
   resources :customers, only: [:edit, :update]
   get 'customers/my_page' => 'customers#show', as: 'show'
   get 'customers/quit' => 'customers#quit', as: 'quit'
   patch 'customers/out' => 'customers#out', as: 'out'
   get 'homes/top'
   get 'homes/about'
   resources :items, only: [:index, :show]
   resources :cart_items, only: [:index, :update, :destroy, :create]
   delete 'cart_items/all_destroy' => 'cart_items#all_destroy', as: 'all_destroy'
  end


  namespace :admin do
   resources :items, except: :destroy
   resources :genres, only: [:index, :create, :edit, :update]
  end


end
