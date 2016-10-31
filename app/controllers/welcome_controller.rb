class WelcomeController < ApplicationController
	before_filter :authenticate_user!
  	
  	def index
  		if current_user.is_admin?
  			@reports = Report.all
  		end
  	end
end
