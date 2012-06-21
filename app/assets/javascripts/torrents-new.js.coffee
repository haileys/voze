return false if not do $('section.torrents.new').size

$('a.preview-markdown').click (e) ->
    do e.preventDefault
    do $('a.preview-markdown').toggle
    $('div.preview-markdown').slideToggle 250

$('textarea').keyup ->
    $('div.preview-markdown').html marked do $(@).val

$('#art button').click (e) ->
    do e.preventDefault
    do $('#art input[type=file]').click

$('#art input[type=file]').change (e) ->
    return unless window.FileReader
    file = e.target.files[0]
    filename = do $(@).val().split(/(\\|\/)/g).pop
    extension = do filename.split('.').pop
    extensions = ['jpg', 'jpeg', 'png', 'gif']
    if extension not in extensions
        $('#art input[type=file]').val ''
        alert 'Invalid file, not a picture!'
    else
        reader = new FileReader
        reader.onloadend = (e) ->
            data = e.target.result
            $('#art img').attr 'src', data
            $('#art').fadeOut 250, ->
                do $('#art img').show
                do $('#art').addClass('preview-art').show
                $('#art .preview-art').fadeIn 250
        reader.readAsDataURL file

$('#art .close').click ->
    $('#art input[type=file]').val ''
    $('#art .preview-art').fadeOut 250, ->
        $('#art img').attr 'src', ''
        $('#art').hide().removeClass('preview-art').fadeIn 250

$('.torrent-file button').click (e) ->
    do e.preventDefault
    do $('.torrent-file input[type=file]').click

$('.torrent-file input[type=file]').change ->
    filename = do $(@).val().split(/(\\|\/)/g).pop
    extension = do filename.split('.').pop
    if extension is 'torrent'
        $('.torrent-file input[type=text]').val filename
    else
        $('.torrent-file input[type=file]').val ''
        $('.torrent-file input[type=text]').val 'Invalid file, not a torrent!'
