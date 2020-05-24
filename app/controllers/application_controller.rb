class ApplicationController < ActionController::Base

	include SessionHelper
	layout "chron_layout"

	#http_basic_authenticate_with name: "standa", password: "shredak", except: :hello
   
	private
	def logged_in_user
		unless logged_in?
		  store_location
		  flash[:danger] = "Please log in."
		  redirect_to login_url
		end
	end
end
