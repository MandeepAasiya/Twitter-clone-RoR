class RegistrationsController < Devise::RegistrationsController 
	before_action :authenticate_user!

	private

	def sign_up_params 
		params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
	end

	def acount_update_params 
		params.require(:user).permit(:name, :username, :bio, :email, :password, :password_confirmation, :current_password)
	end


end