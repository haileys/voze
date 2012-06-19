return false if not do $('section.torrents').size

$('#art input[type=file]').css opacity: 0
do $('#art button').show

$('#art button').click (e) ->
	do e.preventDefault
	do $('#art input[type=file]').click

$('#art input[type=file]').change (e) ->
	file = e.target.files[0]
	reader = new FileReader
	reader.onloadend = (e) ->
		data = e.target.result
		$('#art').addClass 'image'
		$('#art img').attr 'src', data
	reader.readAsDataURL file

$('#art .close').click ->
	$('#art img').attr 'src', ''
	$('#art').removeClass 'image'
	$('#art input[type=file]').val ''
