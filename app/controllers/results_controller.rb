class ResultsController < ApplicationController

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

end
