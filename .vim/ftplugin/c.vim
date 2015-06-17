set tabstop=2
set shiftwidth=2
set softtabstop=2

inoremap <buffer> <leader>co /* */<Esc>hi
inoremap <buffer> <leader>; <Esc>mqA;<Esc>`qa
vnoremap <buffer> <leader>co <Esc>`<i/* <Esc>`>a */<Esc>

" Function initializing a new C program
function! New_C()
    let result = append(0, "#include <stdio.h>")
    let result = append(2, "int main()")
    let result = append(3, "{")
    let result = append(4, "    return 0;")
    let result = append(5, "}")
    call cursor(5, 5)
endfunction
