class UsersController < ApplicationController
	#GET 
	def new
		@user = User.new
	end

	# POST
	def create
		@user = User.new(user_params)
		password = params.require(:user)[:password]
		@user.encrypt_password password

		respond_to do |format|
			if @user.save
				current_user= @user
				session[:user_id] = @user.id
				format.html { redirect_to task_lists_url, notice: 'Successfully created a new user account.' }
			else
				format.html { render :new }
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:login, :email, :firstname, :lastname)
	end
end