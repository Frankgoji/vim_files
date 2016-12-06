" inoremap <buffer> < <><left>
inoremap <buffer> > ><esc>:call Tag_complete()<cr>a
inoremap <buffer> <leader># <!-----><esc>2hi

function! New_html()
    0 read ~/.vim/templates/HTML_TEMPLATE.html
    $ delete
endfunction

function! Tag_complete()
    let line = getline('.')
    let cur_pos = getpos('.')
    let c = col('.') - 1
    let char = matchstr(line, '\%' . c . 'c.')
    while (c > 0 && char != '<')
        if (char == '>')
            call setpos('.', cur_pos)
            return
        endif
        let c -= 1
        let char = matchstr(line, '\%' . c . 'c.')
    endwhile
    if (char == '<')
        call setpos('.', [0, cur_pos[1], c + 1, 0])
        normal "ayw
        if (@a !~ ">")
            let tag = substitute(tolower(@a), " ", "", "")
            if (index(["br", "hr", "img", "input"], tag) == -1)
                call setpos('.', cur_pos)
                let @b = "</" . tag . ">"
                normal "bp
            endif
        endif
    endif
    call setpos('.', cur_pos)
endfunction
