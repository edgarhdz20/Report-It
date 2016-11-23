class WelcomeController < ApplicationController
	before_filter :authenticate_user!
  	
  	def index
  		if current_user.is_admin?
  			@reports = Report.all.order(created_at: :desc).limit(10)
  		elsif current_user.is_jmas?
  			@reports = Report.where(:report_type_id => 1).order(created_at: :desc).limit(10)
  		elsif current_user.is_municipio?
  			@reports = Report.where(:report_type_id => 2).order(created_at: :desc).limit(10)
  		elsif current_user.is_cfe?
  			@reports = Report.where(:report_type_id => 3).order(created_at: :desc).limit(10)
  		end
  	end
end
