require 'authenticated_system'

class ApplicationController < ActionController::Base
	# layout 'main'
	
	SESSION_TTL = 60
	
	include AuthenticatedSystem
		
	# before_action :check_session_expiration

protected

	def check_session_expiration
		# Don't check the session expiration for the logout action
		return true if params[:controller] == 'sessions' && params[:action] == 'destroy'
		logger.debug "\nsession:"
		session[:expires_at]
		logger.debug Time.parse(session[:expires_at])
		logger.debug Time.now
		logger.debug (Time.parse(session[:expires_at]) - Time.now).to_i
		logger.debug session[:user_id]
		# If the user is logged in make sure their session hasn't expired
		if logged_in?
			if session.has_key?(:expires_at) && (session[:expires_at] - Time.current).to_i <= 0
				if User.guest_user_authorized?(params[:controller], params[:action]) # TODO: this needs to be changed
					# If the guest user is authorized for the current action,
					# we need to let the request go through without the session data
					# This happens when a users session expires and they try to punchout
					# to the application
					# destroy_session()
					return true
				else
					# Session has expired
					redirect_to(root_url(:expired => 1))
					return false
				end
			else
				# Extend the session expiration
				ttl = SESSION_TTL.minutes
				session[:expires_at] = ttl.from_now if params[:_extend_session] != '0' 
			end
		end
		return true
	end

	def destroy_session()
		cookies.delete :auth_token
		reset_session
	end

end