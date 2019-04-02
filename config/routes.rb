Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'login', to: 'users#login'
  post 'signup', to: 'users#create'

  get 'allocations', to: 'allocations#list'
  post 'allocations', to: 'allocations#create'
  put 'allocations/:id', to: 'allocations#allocate'
end
