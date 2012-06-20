$('html').removeClass('no-js').addClass 'js'

marked.setOptions
    gfm: false
    pedantic: false
    sanitize: true

$('a[href=#]').click -> false
