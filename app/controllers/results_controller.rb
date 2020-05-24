class ResultsController < ApplicationController
	before_action :logged_in_user
	
	# SHOW start races list
    #races/start-races
  	def list_races
  		@races = Race.all
  	
    	render action: "startraces.html.erb"
	end

	def show_results
		@race = Race.find_by(:id => params[:id])
	
	
		render action: "showresults.html.erb"
	end
	
	#races/live-races
  	def live_races
  		@races = Race.all
  	
    	render action: "liveraces.html.erb"
	end
	
	#results/live/:id
	def live_results
		@race = Race.find_by(:id => params[:id])

	
		render action: "liveresults.html.erb"
	end

	#results/live/rz/:id
	def live_results_rz
		@rz = Rz.find_by(:id => params[:id])

	
		render action: "liveresults_rz.html.erb"
	end
	
	def refresh_live_results
		@rz = Rz.find_by(:id => params[:id])
		
		respond_to do |format|
        	format.js {render action: "refresh_live.html.erb"}
    	end
	end
end
