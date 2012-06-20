return false if not do $('section.torrents').size

$('#art input[type=file]').css opacity: 0
do $('#art button').show

$('#art button').click (e) ->
	do e.preventDefault
	do $('#art input[type=file]').click

$('#art input[type=file]').change (e) ->
	return unless window.FileReader
	file = e.target.files[0]
	reader = new FileReader
	reader.onloadend = (e) ->
		data = e.target.result
		$('#art img').attr 'src', data
		$('#art').fadeOut 250, ->
			do $('#art img').show
			do $('#art').addClass('preview').show
			$('#art .preview').fadeIn 250
	reader.readAsDataURL file

$('#art .close').click ->
	$('#art input[type=file]').val ''
	$('#art .preview').fadeOut 250, ->
		$('#art img').attr 'src', ''
		$('#art').hide().removeClass('preview').fadeIn 250
