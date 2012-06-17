$('form.new').bind 'ajax:before', ->
    $('input[type=submit]').attr 'disabled', true
    do $('.icon.loading').show

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
        $(error).hide().insertAfter('strong').slideDown(300).delay(5000).slideUp 300, ->
            do $(this).remove
        do $('form .input:first-child input').focus