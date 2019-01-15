class WelcomeController < ApplicationController
	def index
		if self.logged_in?
			respond_to do |format|
				format.html { redirect_to task_lists_url }
				format.json { render 'task_lists/index', status: :ok }
			end
		end
	end
end