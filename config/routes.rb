Rails.application.routes.draw do
  
  
  
	get 'races/start-races' => 'races#start_races'
	get 'races/finish-races' => 'races#finish_races'
  
	resources :races
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
	get 'chronometer/hello' => 'chronometer#hello'
	get 'chronometer/homepage' => 'chronometer#homepage'
	get 'races/:id/show-rzs' => 'races#show_rzs'
	get 'races/:id/finish-rzs' => 'races#finish_rzs'
	get 'races/:id/show-rzs-finish' => 'races#show_rzs_finish'
	get 'races/:id/start-rz/:rzid' => 'races#start_rz'
	
	get 'races/:id/finish-rz/:rzid' => 'races#finish_rz'
	
  root :to => 'chronometer#hello'
  
  get 'race/:raceId/start/:rzId/racer/:racerId' => 'rz#start_racer', :as => :start_racer
  get 'race/:raceId/finish/:rzId/racer/:racerId' => 'rz#finish_racer', :as => :finish_racer
  
end
