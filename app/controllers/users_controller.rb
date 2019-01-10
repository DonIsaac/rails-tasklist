class UsersController < ApplicationController
	#GET 
	def new
	end

	# POST
	def create
		@user = User.new(user_params)
		user.encrypt_password
		
	end

	private

	def user_params
		params.require(:user).permit(:login, :password, :email, :firstname, :lastname)
	end
end