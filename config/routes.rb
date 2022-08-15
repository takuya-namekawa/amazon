Rails.application.routes.draw do
  namespace :admin do
   resources :genres, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :items, except: :destroy
  end
root to: "public/homes#top"
  namespace :public do
    get 'homes/top'
    get 'homes/about'
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




end
