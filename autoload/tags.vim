" autoload\tags.vim
" Sarrow: 2011-10-22
" Sarrow: 2011-11-17
" 	修改tags搜索路径

function tags#GetBase()
    if MySys() == 'windows'
	return $MINGW . '\..\share\ctags\'
    else
	return $HOME . '/ctags/'
    endif
endfunction

function tags#AddCtags(path)
    let new_tag = tags#GetBase().a:path
    if !filereadable(new_tag)
	return
    endif
    if &tags !~ '\<'.escape(new_tag, '\').'\>'
	let &tags.=(",".new_tag)
    endif
    echomsg &tags
endfunction

function tags#DelCtags(path)
    if &tags =~ '\<'.escape(a:path, '\').'\>'
	let &tags = strpart(substitute(','.&tags, ',\<'.escape(a:path, '\.').'\>', '', 'g'), 1)
    endif
    echomsg &tags
endfunction

function tags#ListTagsFile(A, L, P)
    let flist = split(globpath(tags#GetBase(), a:A.'*'),"\n")
    call map(flist, 'fnamemodify(v:val, ":t")')
    return flist
endfunction

function tags#ListAddedTagsFile(A, L, P)
    return split(&tags, ',')
endfunction

" Sarrow:2011-12-07
"~/plugin/ctags.vim
function! tags#Update_ctags_data_file()	" {{{1
    " NOTE:
    " 在对C++文件进行补全时，OmniCppComplete插件需要在标签文件中包含C++的额外信息
    " ，因此上面的ctags命令不同于以前我们所使用的，它专门为C++语言生成一些额外的信
    " 息，上述选项的含义如下：
    "	--c++-kinds=+p  : 为C++文件增加函数原型的标签
    "	--fields=+iaS   : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)
    "	--extra=+q      : 为标签增加类修饰符。注意，如果没有此选项，将不能对类成员补全
    let cmd = g:ctags_command
    if filereadable("./cscope.files")
        let cmd .= " -L ./cscope.files"
    else
        let cmd .= " ."
    endif
    if MySys() == "linux"
	let cmd .= " &"
    endif
    echomsg "!".cmd
    silent execute "!".cmd
    "call system(cmd)
endfunction

