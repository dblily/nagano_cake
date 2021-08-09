Rails.application.routes.draw do
  
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'

  namespace :admin do
    resources :items, except: [:destroy]
    resources :genres, except: [:show, :new, :destroy]
  end
  
  scope module: :public do
    resource :customers, only: [:show, :edit, :update]
    get '/customers/leave' => 'customers#leave', as: 'customers_leave'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
    resources :items, only: [:index, :show]
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
