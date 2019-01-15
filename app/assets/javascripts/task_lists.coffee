toggle_view_mode = (isViewMode, id) ->
	view = $("##{id}.task-display-view")
	edit = $("##{id}.task-display-edit")
	if isViewMode
		view.show()
		edit.hide()
	else 
		view.hide()
		edit.show()
	return

create_resource = (method) ->
	fromForm = !$(this).attr('data-href') # true if no 'data-href' attr, false otherwise
	url = ""

handle_clicks = -> 
	$('.task-display-edit').hide()

	# Handle edit/cancel edit events
	$('.edit-task').click ->
		id = $(this).attr('data-id')
		toggle_view_mode(false, id)
	
	$('.cancel-edit').click ->
		id = $(this).attr('data-id')
		toggle_view_mode(true, id)

	# Handle move up request
	$('a.move-up, a.move-down').click ->
		move_data = 
			task:
				count: $(this).attr('data-count')
		$.ajax({
			url: $(this).attr('data-href'),
			method: 'put',
			data: move_data
		})
		.done ->
			$('#notice').html("Successfully moved the task")
		.fail (xhr, status, err) ->
			console.error(xhr)
			$('#notice').html("#{status} #{err} - #{xhr.responseText}")

	# Update completion status check boxes (AJAX)
	$('input.status-checkbox').click ->
		form = $(this).closest('form')
		form_data = form.serializeArray()
		checked = $(this).prop('checked')

		if not checked
			form_data.push({ name: "task[status]", value: "created"})

		$.ajax({
			url: form.attr('action'),
			method: 'put', # form.attr('method') # Should this be set to PATCH, remove _method hidden field?
			data: form_data,
		})
		.done ->
			$('#notice').html("Successfully updated task status!")
		.fail (xhr, status, err) ->
			console.error(xhr)
			$('p#notice').html("#{status} #{err} - #{xhr.responseText}")
	
	$('.create').click ->
		

	


	###
	$('form.task-completed').submit (e) ->
		e.preventDefault()
		console.log('30: form submitted')
		console.dir(e)
		console.dir(this)
		data = $(this).serializeArray()
		console.log("34: data array:")
		console.dir(data)
		console.log('36: checked?')
		console.log( $(this).closest('input.status-checkbox').attr('checked') )
		if not $(this).closest('input.status-checkbox').attr('checked')
			console.log('39: not checked')
			data.push({ name: "task[status]", value: "created"})
		
		$.ajax({
			url: $(this).attr('action'),
			method: 'POST' # Should this be set to PATCH, remove _method hidden field?
			data: data

		})
		.done ->
			$('#notice').html("Successfully updated task status!")
		.fail (xhr, status, err) ->
			console.error(xhr)
			$('p#notice').html("#{status} #{err} - #{xhr.responseText}")

		return;
		###



document.addEventListener("turbolinks:load", handle_clicks)
		
	
