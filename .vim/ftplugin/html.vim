inoremap <buffer> < <><left>

" Here will be the testing grounds for the tag highlighting
syntax match openTag "\v<[^/!][^>]*>"
syntax match closeTag "\v<[/!][^>]*>"
