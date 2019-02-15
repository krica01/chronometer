Rails.application.routes.draw do
  
  
  
  get 'races/start-races' => 'races#start_races'
  
  resources :races
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
	get 'chronometer/hello' => 'chronometer#hello'
	get 'chronometer/homepage' => 'chronometer#homepage'
	get 'races/:id/show-rzs' => 'races#show_rzs'
	get 'races/:id/start-rz/:rzid' => 'races#start_rz'
	
  root :to => 'chronometer#hello'
end
