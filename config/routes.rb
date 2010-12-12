ActionController::Routing::Routes.draw do |map|
  map.root :controller => "invoices"

  map.resources :products, :active_scaffold => true
  map.resources :clients, :active_scaffold => true
  map.resources :invoices, :active_scaffold => true
  map.resources :invoice_products, :active_scaffold => true

  # AuthLogic
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
