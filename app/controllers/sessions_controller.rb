class SessionsController < ApplicationController
	def new
	end

	def create
		respond_to do |format|
			logger.debug 'create called'
			sessions_params = params.require(:session).permit(:login, :password)
			begin
				@user = User.find_by login: sessions_params[:login]
			rescue
			end
			if !@user
				format.html do 
					flash[:error] = "User not found"
					render :new
				end
				format.json { render :json, "no user found"}
				return
			end

			if @user.authenticated? sessions_params[:password]
				logger.debug 'user authenticated'
				logger.debug @user.inspect
				logger.debug current_user=(@user).inspect
				logger.debug session[:user_id]
				logger.debug current_user().inspect
				logger.debug @current_user.inspect
				format.html do  
					redirect_to task_lists_url(user_id: @user[:id]), notice: "Successfully logged in!"
				end
			else
				logger.debug 'user authenticated'
				format.html do 
					flash.now[:error] =  ["Incorrect password."]
					render :new
				end
			end
		end
	end

	def destroy
		session[:user_id] = nil

		respond_to do |format|
			format.html { redirect_to tasks_url, notice: "You have been logged out." }
		end
	end
end