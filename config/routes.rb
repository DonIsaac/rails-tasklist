Rails.application.routes.draw do
	# Admin routes
	namespace :admin do
		resources :task_lists, :tasks, :categories

		put '/tasks/:id/move/:dir', to: 'tasks#move', as: 'move_task'
		patch'/tasks/:id/move/:dir', to: 'tasks#move'

	end

	# User routes
	resources :task_lists, :tasks, :categories
	
	put '/tasks/:id/move/:dir', to: 'tasks#move', as: 'move_task'
	patch'/tasks/:id/move/:dir', to: 'tasks#move'

	get '/user/new', to: 'users#new', as: 'new_user'
	post '/user', to: 'users#create', as: 'users'

	get '/user/sign_in', to: 'sessions#new', as: 'new_session'
	post '/user/session', to: 'sessions#create', as: 'sessions'
	delete '/user/sign_out', to: 'sessions#destroy', as: 'session'


	#root 'task_lists#index'
	root to: 'welcome#index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
