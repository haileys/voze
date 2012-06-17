$('section.sessions').css
    'margin-top': (do $('section.sessions').height / 2) * -1
.fadeIn()

$('section.sessions form').bind "ajax:success", (ev, response) ->
    if response.success
        alert "welcome!"
        location.href = "/"
    else
        alert "bad password"