document.addEventListener("turbolinks:load", () => {
	$('#sign-out').click(function (e) {
		$.ajax({
			url: $(this).attr('data-href'),
			method: 'delete',
			beforeSend: () => { console.log($(this).attr('data-href')); console.log('signing out...') }
		})
		.fail((xhr, status, err) => {
			console.error(`Failed to sign out\nstatus: ${xhr.status}\message: ${status}\nerror: ${err}`)
		})
	})

	$(this).keydown(function(event) {
		if(event.key.toLowerCase() === "escape") {
			$('.alert').alert('close')
		}
			
		console.log(event)

		// $().alert('close')
	})
})