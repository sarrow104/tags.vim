" Some command and menu settings for cscope-tool
" Sarrow:2011-12-07
" ~/.vim/plugin/cscope.vim
" Cscope.Setting	- cscope_maps.vim; cscope_win.vim -	{{{1
""""""""""""""""""""""""""""""
"runtime plugin\cscope_maps.vim          " source $VIMRUNTIME\plugin\cscope_maps.vim
"======================================================================
if has("cscope")
    if MySys() == 'linux'
	" set csprg=/usr/local/bin/cscope
	set csprg=cscope
    elseif MySys() == 'windows'
	set csprg=cscope
    endif

    " use cscope db-file and tag db-file the same time
    set cscopetag

    " cscope db-file first
    set cscopetagorder=0

    " no verbose information, when connect to a cscope db-file.
    set nocscopeverbose

    " when more than one matched, you can use ":cw" to view them
    set cscopequickfix=s-,c-,d-,i-,t-,e-

    " add any database in current directory
    "cs add ~/project/cscope.out
    "if filereadable("cscope.out")
    "    cs add cscope.out .
    "    " else add database pointed to by environment
    "elseif $CSCOPE_DB != ""
    "    cs add $CSCOPE_DB
    "endif
endif

function! CscopeShortCut_start()	" {{{1
    nmap <buffer> <C-C>] :call cscope#find_tag()<CR>
    nmap <buffer> <C-C>c :call cscope#find_function_call_me()<CR>
    nmap <buffer> <C-C>d :call cscope#find_function_call_by_me()<CR>
    nmap <buffer> <C-C>e :call cscope#find_egrep_mode()<CR>
    nmap <buffer> <C-C>f :call cscope#find_file_by_name()<CR>
    nmap <buffer> <C-C>t :call cscope#find_text()<CR>
    nmap <buffer> <C-C>g :call cscope#find_definition_of()<CR>
    nmap <buffer> <C-C>i :call cscope#find_who_include_me()<CR>
    nmap <buffer> <C-C>% :call cscope#find_who_include_me_relative()<CR>
    nmap <buffer> <C-C>s :call cscope#find_c_symbol()<CR>

    " other old setting {{{2
    " map <buffer> <C-_>  :cstag <C-R>=expand("<cword>")<CR><CR>
    "nmap <buffer> <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <buffer> <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <buffer> <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <buffer> <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <buffer> <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <buffer> <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <buffer> <C-_>i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <buffer> <C-_>% :cs find i <C-R>=fnamemodify(expand("%"), ":p:.")<CR><CR>
    "nmap <buffer> <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    "" Using 'CTRL-spacebar' then a search type makes the vim window
    "" split horizontally, with search result displayed in
    "" the new window.
    "nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    "
    "" Hitting CTRL-space *twice* before the search type does a vertical
    "" split instead of a horizontal one
    "nmap <C-Space><C-Space>s \:vert scs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>g \:vert scs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>c \:vert scs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>t \:vert scs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>e \:vert scs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-Space><C-Space>i \:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <C-Space><C-Space>d \:vert scs find d <C-R>=expand("<cword>")<CR><CR>
endfunction

function! s:Add_CScope_Menu(menu_clear)	" {{{1
"2009-02-19 12:12:03 四 ~/.vim/plugin  
"☎ cat  cscopemenu-exp.vim 
" Add_Cscope_Menu
"   Adds a cscope menu
"   All the commands work on the word that is under the cursor
    if has("gui_running")
	if (a:menu_clear)
	    silent! unmenu &Cscope
	    silent! unmenu! &Cscope
	    amenu <silent> &Cscope.用cscope来查找tag<tab>^C] :call cscope#find_tag()<CR>
	    amenu <silent> &Cscope.查找调用本函数的函数<tab>^Cc :call cscope#find_function_call_me()<CR>
	    amenu <silent> &Cscope.查找本函数调用的函数<tab>^Cd :call cscope#find_function_call_by_me()<CR>
	    amenu <silent> &Cscope.查找egrep模式<tab>^Ce :call cscope#find_egrep_mode()<CR>
	    amenu <silent> &Cscope.查找并打开文件<tab>^Cf :call cscope#find_file_by_name()<CR>
	    amenu <silent> &Cscope.查找指定的字符串<tab>^Ct :call cscope#find_text()<CR>
	    amenu <silent> &Cscope.查找本标识符定义的位置<tab>^Cg :call cscope#find_definition_of()<CR>
	    amenu <silent> &Cscope.查找包含此名文件的文件<tab>^Ci :call cscope#find_who_include_me()<CR>
	    amenu <silent> &Cscope.查找包含本文件的文件<tab>^C% :call cscope#find_who_include_me_relative()<CR>
	    amenu <silent> &Cscope.查找C语言符号<tab>^Cs :call cscope#find_c_symbol()<CR>
	endif
    endif
endfunction

call s:Add_CScope_Menu(1)	" {{{1

"autocmd BufEnter * call s:Add_CScope_Menu(1)
