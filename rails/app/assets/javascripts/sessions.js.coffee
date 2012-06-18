return false if not do $('section.sessions').size

flash = (elem, opacity=0.5, times=1, time=200) ->
    next = ->
        elem.animate opacity: opacity, time, ->
            elem.animate opacity: 1, time, ->
                do next if --times isnt 0
    do next

$('form.new').bind 'ajax:before', ->
    $('input[type=submit]').attr 'disabled', true
    do $('.icon.loading').show
    $('.error').slideUp 250, ->
        do $(this).remove

$('form.new').bind 'ajax:success', (ev, response) ->
    do $('.icon.loading').hide
    $('input[type=submit]').attr 'disabled', false
    if response.success
        location.href = "/"
    else
        error = """
            <div class="error">
                Incorrect username or password.
            </div>
        """
        $(error).hide().insertAfter('strong').slideDown 250
        flash $ 'section.sessions'
        do $('form.new div.input:first input').focus
