Rails.application.routes.draw do
  
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'

  namespace :admin do
    get '/' => 'homes#top', as: 'top'
    resources :customers, except: [:new, :create, :destroy]
    resources :items, except: [:destroy]
    resources :genres, except: [:show, :new, :destroy]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end
  
  scope module: :public do
    resource :customers, only: [:show, :edit, :update]
    get '/customers/leave' => 'customers#leave', as: 'customers_leave'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    
    resources :items, only: [:index, :show]
    
    resources :cart_items, except: [:new, :show, :edit]
    delete '/cart_items/destroy_all/:id' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    
    post '/orders/comfirm' => 'orders#comfirm', as: 'orders_comfirm'
    get '/orders/thanks' => 'orders#thanks', as: 'orders_thanks'
    resources :orders, except: [:edit, :update, :destroy]
    
    resources :addresses, except: [:show, :new]
  end
  
  devise_for :admin, controllers: {
    sessions: 'admin/admin/sessions',
    passwords: 'admin/admin/passwords',
    registrations: 'admin/admin/registrations'
  }
  
  devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',
    passwords: 'public/customers/passwords',
    registrations: 'public/customers/registrations'
  }
  
end
