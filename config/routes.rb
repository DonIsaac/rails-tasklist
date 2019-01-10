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

  root 'task_lists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
