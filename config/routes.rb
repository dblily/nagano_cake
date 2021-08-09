Rails.application.routes.draw do
  
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
  
  
  namespace :admin do
    resources :items, except: [:destroy]
    resources :genres, except: [:show, :new, :destroy]
  end
  
  namespace :public do
  end
  
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'

  
  

end
