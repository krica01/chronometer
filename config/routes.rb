Rails.application.routes.draw do
  
  
  
	get 'races/start-races' => 'races#start_races'
	get 'races/finish-races' => 'races#finish_races'
	get 'results/list-races' => 'results#list_races'
	get 'results/live-races' => 'results#live_races'
	get 'results/refresh-live-results/:id' => 'results#refresh_live_results'
	
	get 'races/assign_names/:id' => 'races#assign_names', :as => :assign_names
	post 'races/assign_name/:id' => 'races#assign_name', :as => :assign_name	
  
	resources :races
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
	get 'chronometer/hello' => 'chronometer#hello'
	get 'chronometer/homepage' => 'chronometer#homepage', :as => :homepage
	get 'races/:id/show-rzs' => 'races#show_rzs'
	get 'races/:id/finish-rzs' => 'races#finish_rzs'
	get 'races/:id/show-rzs-finish' => 'races#show_rzs_finish'
	get 'races/:id/start-rz/:rzid' => 'races#start_rz'
	
	get 'races/delete_rz/:id/:rz_id' => 'races#delete_rz'
	
	get 'races/:id/finish-rz/:rzid' => 'races#finish_rz'

	get 'results/show/:id' => 'results#show_results'
	get 'results/live/:id' => 'results#live_results'
	get 'results/live/rz/:id' => 'results#live_results_rz'
	
	
  root :to => 'chronometer#hello'
  
  get 'race/:raceId/start/:rzId/racer/:racerId' => 'rz#start_racer', :as => :start_racer
  get 'race/:raceId/finish/:rzId/racer/:racerId' => 'rz#finish_racer', :as => :finish_racer
  
  get '/signup', to: 'users#new'
  resources :users
  
	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	#post   '/login_new_user',   to: 'sessions#create_new_user'
	#get    '/login_new_user',   to: 'sessions#create_new_user'
	match 'login_new_user' => 'sessions#create_new_user', via: [:get, :post], :as => :login_new_user
	get '/logout',  to: 'sessions#destroy'
	
	post 'races/assign_race_permission/:id' => 'races#assign_race_permission', :as => :assign_race_permission	
	get 'races/delete_race_permission/:id/:race_permission_id' => 'races#delete_race_permission', :as => :delete_race_permission	
  
end
