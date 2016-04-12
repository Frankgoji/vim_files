inoremap <buffer> <leader>c //<Space>
inoremap <buffer> <leader>dc /** */<Esc>hi
vnoremap <buffer> <leader>co <Esc>`<i/* <Esc>`>a */<Esc>

" Change so that it does the Test one when name ends with Test
function! New_Java()
    let filename = expand('%:t:r')
    let result = append(0, "public class " . filename . " {")
    let result = append(1, "\tpublic static void main(String[] args) {")
    let result = append(2, "\t}")
    let result = append(3, "}")
    $ delete
    if match(filename, "Test") != -1 || match(filename, "test") != -1
        call JUnit_Test()
    endif
endfunction

function! JUnit_Test()
    %delete
    let filename = expand('%:t:r')
    0 read ~/.vim/templates/JUNIT_TEMPLATE.java
    %s/JUNIT_TEMPLATE/\=filename/
    $ delete
endfunction
