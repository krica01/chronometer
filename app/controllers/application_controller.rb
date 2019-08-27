class ApplicationController < ActionController::Base

	layout "chron_layout"

   http_basic_authenticate_with name: "standa", password: "shredak", except: :hello

end
