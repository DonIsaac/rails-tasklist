module Admin
	class TaskListsAdminController < TaskListsController
		def index
			@task_lists = TaskList.all
		end
	end
end