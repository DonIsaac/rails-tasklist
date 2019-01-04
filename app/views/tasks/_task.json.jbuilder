json.extract! task, :id, :task_list, :status, :name, :description, :created_at, :updated_at
json.url task_url(task, format: :json)
