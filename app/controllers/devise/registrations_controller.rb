class Devise::RegistrationsController < DeviseController  
    respond_to :json
  	skip_before_action :verify_authenticity_token

  def create
		user = User.create(user_params)
		if user.save
      render json: {:login => "OK", :user => user.id}
		else
			render json: {:login => user.errors}
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password, :role_id, :email)
	end	
end  