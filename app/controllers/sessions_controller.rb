class SessionsController < ApplicationController
	def new
	end

	def create
		respond_to do |format|
			logger.debug "\n\nsessions#create hit\n\n"
			sessions_params = params.require(:session).permit(:login, :password)
			begin
			@user = User.find_by login: sessions_params[:login]
			rescue
			end
			if !@user
				logger.debug "no user found"
				format.html do 
					flash[:error] = "User not found"
					render :new
				end
				format.json { render :json, "no user found"}
				return
			end

			logger.debug @user.inspect
			logger.debug sessions_params[:password]
			if @user.authenticated? sessions_params[:password]
				current_user= @user
				format.html do  
					logger.info "logged in"
					redirect_to task_lists_url, notice: "Successfully logged in!"
				end
			else
				format.html do 
					logger.info "incorrect password"
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