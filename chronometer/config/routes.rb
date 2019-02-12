Rails.application.routes.draw do
  resources :races
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
	get 'chronometer/hello' => 'chronometer#hello'
	get 'chronometer/homepage' => 'chronometer#homepage'
  
end
