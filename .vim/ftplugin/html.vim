inoremap <buffer> < <><left>

" Here will be the testing grounds for the tag highlighting
syntax match openTag "\v<[^/!][^>]*>"
syntax match closeTag "\v<[/!][^>]*>"

function! New_html()
    0 read ~/.vim/templates/HTML_TEMPLATE.html
    $ delete
endfunction
