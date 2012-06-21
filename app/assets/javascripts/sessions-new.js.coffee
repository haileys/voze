return false if not do $('section.sessions form.new').size

error = (msg) ->
    elem = """
        <div class="error">
            #{msg}.
        </div>
    """
    $(elem).hide().insertAfter('strong').delay(150).slideDown 150

$('form').bind 'ajax:before', ->
    $('input[type=submit]').attr 'disabled', true
    do $('.icon.loading').show
    $('.error').slideUp 150, ->
        do $(@).remove
.bind 'ajax:complete', ->
    do $('.icon.loading').hide
    $('input[type=submit]').attr 'disabled', false
.bind 'ajax:error', (xhr, err) ->
    $('section.sessions').flash 4
    console.log err
    error "Server returned #{err.status} #{err.statusText}"
.bind 'ajax:success', (ev, response) ->
    if response.success
        location.href = '/'
    else
        error 'Incorrect username or password'
        do $('section.sessions').flash
        do $('form div.input:first input').focus
