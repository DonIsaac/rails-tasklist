Rails.application.routes.draw do
  # Admin routes
  namespace :admin do
    resources :task_lists, :tasks, :categories
  end

  # User routes
  resources :task_lists, :tasks, :categories
  

  root 'task_lists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
