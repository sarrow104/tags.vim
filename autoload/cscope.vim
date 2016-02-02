" Some command and menu settings for cscope-tool
" Sarrow:2011-12-07
" ~/.vim/autoload/cscope.vim

function! cscope#Search_cs_link(cs_db_fname, prepend_path) " CsCope Database suppliment function {{{1
    " NOTE:
    " :redir => viriable
    " :cs show
    " :redir END
    " 重置所有的cscope数据库链接——不更新？
    " :cs reset

    redir => _x_
    silent cs show
    redir END
    let _x_ .= "\n"
    let prepend_path = escape(a:prepend_path, ' .')
    let cs_db_fname =  escape(a:cs_db_fname, ' .')
    let pattern = '\d\+\(\s\+\d\+\s\+'.cs_db_fname.'\s\+'.prepend_path.'\s\+\n\)\@='
    " echoerr "pattern = ".pattern
    let rt = matchstr(_x_, pattern)
    if rt == ""
        return -1
    else
        return str2nr(rt)
    endif
endfunction
" }}}

function! cscope#Create_cscope_files(recurs) "{{{1
    let files = []
    if a:recurs
	let pattern = '**/*'
    else
	let pattern = '*'
    endif
    let files = split(glob(pattern), "\n")
    call filter(files, '!isdirectory(v:val)')
    call map(files, '"./".substitute(v:val, "\\", "/", "g")')
    let pattern = escape(g:csfiles_wildcard, '.')
    let pattern = substitute(pattern, ' \+', '\\|', 'g')
    let pattern = substitute(pattern, '?', '.', 'g')
    let pattern = substitute(pattern, '\*', '.*', 'g')
    let pattern = '/\%('.pattern.'\)$'
    call filter(files, 'v:val =~ pattern')
    "echon join(files, "\n")
    call writefile(files, "cscope.files")
endfunction

" Build or Update cscope.out database, and link
function! cscope#Update_cscope_data_file()	" {{{1
    if !filereadable("./cscope.files")
        call Create_cscope_files(0)
    endif
    " filereadable("./cscope.out") && !filewritable("./cscope.out")
    if cscope_connection(4, "cscope.out", ".") == 1
	let cs_connect_id = cscope#Search_cs_link("cscope.out", ".")
	" echoerr "id = ".cs_connect_id
	if cs_connect_id != -1
	    execute "cs kill ".cs_connect_id
	endif
    endif
    call system("cscope -Rb")
    if filereadable("./cscope.out")
        silent cs add cscope.out .
        " NOTE:
        " 	the 1st arg "./cscope.out" 	--> the cscope database file
        " 	the 2nd arg "."			--> for the source file root directory
    endif
endfunction

function! cscope#Update_reference_data_file()	" {{{1
    call cscope#Update_cscope_data_file()
    call tags#Update_ctags_data_file()
endfunction

function! cscope#find_tag()	" {{{1
    silent execute ":cstag ". expand("<cword>")
endfunction

function! cscope#find_function_call_me()	" {{{1
    :cs find c <cword>
endfunction

function! cscope#find_function_call_by_me()	" {{{1
    :cs find d <cword>
endfunction

function! cscope#find_egrep_mode()	" {{{1
    :cs find e <cword>
endfunction

function! cscope#find_file_by_name()	" {{{1
    :cs find f <cword>
endfunction

function! cscope#find_definition_of()	" {{{1
    :cs find g <cword>
endfunction

function! cscope#find_who_include_me()	" {{{1
    :cs find i <cword>
endfunction

function! cscope#find_who_include_me_relative()	" {{{1
    silent execute "cs find i ".fnamemodify(expand("%"), ":p:.")
endfunction

function! cscope#find_c_symbol()	" {{{1
    :cs find s <cword>
endfunction

function! cscope#find_text()	" {{{1
    :cs find t <cword>
endfunction
