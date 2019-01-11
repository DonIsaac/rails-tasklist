class WelcomeController < ApplicationController
	def index
		if logger.debug logged_in?
			session[:user_id] = nil
		end
	end
end