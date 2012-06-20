return false if not do $('section.torrents').size

$('a.preview-markdown').click (e) ->
    do e.preventDefault
    do $('.preview-markdown').toggle

$('textarea').keyup ->
    $('div.preview-markdown').html marked do $(this).val

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
            do $('#art').addClass('preview-art').show
            $('#art .preview-art').fadeIn 250
    reader.readAsDataURL file

$('#art .close').click ->
    $('#art input[type=file]').val ''
    $('#art .preview-art').fadeOut 250, ->
        $('#art img').attr 'src', ''
        $('#art').hide().removeClass('preview-art').fadeIn 250
