class WelcomeController < ApplicationController
	def index
		logger.debug current_user
		logger.debug logged_in?
	end
end