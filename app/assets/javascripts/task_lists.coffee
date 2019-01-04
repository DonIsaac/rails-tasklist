# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
console.log('dis boi called :D')
edit_form = (id, name) -> 
			"""
			<form action="/tasks/#{id}" method="post" data-remote="true">
			<input name="_method" type="hidden" value="put" />
			<div class="input-group">
				<input type="text" class="form-control" value="#{name}" autofocus name="name">
      			<span class="input-group-btn">
        			<button class="btn btn-default submit-edit" type="submit" role="submit-changes">
						<span class="glyphicon glyphicon-ok"></span>
					</button>
					<button class="btn btn-default cancel-edit" type="button" role="cancel-changes" data-og-name="#{name}">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
      			</span>
			</div>
			</form>
			"""

original_innerHTML = (id, name, url) ->
	"""
	<span class="task-name">#{name}</span>
    <span class="dropdown manage-task">
        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            <span class="glyphicon glyphicon-menu-hamburger"></span>
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
            <li>
                <a class="move-up" data-id="#{id}"><span class="glyphicon glyphicon-triangle-top"></span> Move Up</a>
            </li>
            <li>
                <a class="move-down" data-id="#{id}" href="#"><span class="glyphicon glyphicon-triangle-bottom"></span> Move Down</a>
            </li>
            <li>
                <a class="edit-task" data-id="#{id}"><span class="glyphicon glyphicon-cog"></span> Edit</a>
            </li>
            <li role="separator" class="divider"></li>
            <li>
              <a href="#{url}" data-confirm="Are you sure you want to delete this task?" data-remote="true" rel="nofollow" data-method="delete">
                <span class="glyphicon glyphicon-trash"></span> Delete
              </a>
            </li>
        </ul>
    </span>
	"""

task_crud = () ->
	# Handle task > dropdown > delete link
	$('.delete-task').click ->
		console.log('delete task clicked')
		return

	$('.edit-task').click ->
		console.log('edit clicked')
		task_id = $(this).attr('data-id')
		# Get the task as a jQuery object
		task = $('#task-' + task_id)
		# Get the name of the task
		name = task.children('.task-name').html()
		delete_url = task.find('.task-delete-link').attr('href')
		# Set the inner HTML of the task to the form
		task.html( edit_form(task_id, name) )  
		task.find('.cancel-edit').click -> 
			task.html( original_innerHTML(task_id, name, delete_url) )
		
		return 

	return

document.addEventListener("turbolinks:load", task_crud)