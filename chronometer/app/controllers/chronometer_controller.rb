class ChronometerController < ApplicationController
	
	layout "chron_layout"
	
	def hello
		@message = "Hello"
		render :layout => 'application'
	end
	
	def homepage

	
	end
end
