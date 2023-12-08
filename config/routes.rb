Rails.application.routes.draw do
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  namespace :admin do
    get 'items/new'
    get 'items/index'
    get 'items/show'
    get 'items/edit'
  end
  namespace :admin do
    get 'homes/top'
    get 'homes/search'
  end
  namespace :admin do
    get 'genres/edit'
    get 'genres/index'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/edit'
    get 'customers/show'
  end
  namespace :public do
    get 'orders/confirm'
    get 'orders/error'
    get 'orders/index'
    get 'orders/new'
    get 'orders/show'
    get 'orders/thanks'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/unsubscribe'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions",
  }
  
  namespace :admin do
    get 'top' => "homes#top", as: "top"
    get "search" => "homes#search", as: "search"
    get "customers/:customer_id/orders" => "orders#index", as: "customer_orders" ##??????これ何
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update] do ####orders#index重複してない？
      resources :order_details, only: [:update]
    end
  end
  #=============================================================================
  devise_for :customers, controllers: {
    sessions: "public/sessions",
    registrations: "public/registrations"
  }
  
  scope module: :public do
    root "homes#top"
    
    get "customers/mypage" => "customers#show", as: "mypage"
    get "customers/information/edit" => "customers#edit", as: "edit_information"
    patch "customers/information" => "customers#update", as: "update_information"
    get "customers/unsubscribe" => "customers#unsubscribe", as: "confirm_unsubscribe"
    put "customers/information" => "customers#update"
    patch "customers/withdraw" => "customers#withdraw", as: "withdraw_customer"
    
    delete "cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    
    post "orders/confirm" => "orders#confirm"
    get "orders/confirm" => "orders#error"
    get "orders/thanks" => "orders#thanks", as: "thanks"
    
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show] do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index]
    resources :orders, only:[:new, :create, :index, :show]
  end
  
end
