$('html').removeClass('no-js').addClass 'js'

$('html').addClass 'ie' if $.browser.msie

marked.setOptions
    gfm: false
    pedantic: false
    sanitize: true

$('a[href=#]').click -> false

$.fn.flash = (times=2, lag=350, opacity=0.5, time=75) ->
    next = =>
        $(@).stop(true).delay(lag).animate opacity: opacity, time, ->
            $(@).animate opacity: 1, time, ->
                do next if --times isnt 0
    do next
    @
