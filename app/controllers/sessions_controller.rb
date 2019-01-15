class SessionsController < ApplicationController
	def new
	end

	def create
		
		sessions_params = params.require(:session).permit(:login, :password)
		begin
			@user = User.find_by login: sessions_params[:login]
		rescue
		end
		respond_to do |format|
			if !@user
				format.html do 
					flash[:error] = "User not found"
					render :new
				end
				format.json { render :json, "no user found"}
				return
			end

			if @user.authenticated? sessions_params[:password]
				self.current_user=(@user)
				format.html do  
					redirect_to task_lists_url, notice: "Successfully logged in"
				end
			else
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
			format.html { redirect_to root_url, notice: "You have been logged out." }
		end
	end
end