module Admin
	class TaskListsController < ::TaskListsController
		def index
			sort = (params[:sort] || "name") + " " + (params[:dir] || "asc")

			query = "#{(params[:query] || "").downcase}%"
			conds = ["LOWER(name) LIKE ?", query]

			@task_lists = TaskList.paginate(page: params[:page] || 1, per_page: 10).where(conds).order(sort)
		end
	end
end