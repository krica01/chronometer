class ChronometerController < ApplicationController
	
	before_action :logged_in_user, :only => [:homepage]
	
	def hello
		@message = "Hello"
		render :layout => 'application'
	end
	
	def homepage

	
	end
end
