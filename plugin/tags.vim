let g:ctags_command='ctags -R --sort=1 --c++-kinds=+p --fields=+iaSl --extra=+q'
"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ cpp_src -f ~/.vim/tags/stl
"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/GL/  -f ~/.vim/tags/gl
"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/SDL/ -f ~/.vim/tags/sdl
"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ /usr/include/qt4/ -f ~/.vim/tags/qt4

let g:csfiles_wildcard = "*.cpp *.c *.h *.hpp *.cc"

function! C_Cpp_command()
    command! -buffer -nargs=0 CTUpdate       call tags#Update_ctags_data_file()<bar>call cscope#Update_cscope_data_file()
    command! -buffer -nargs=0 TagsUpdate     call tags#Update_ctags_data_file()
    command! -buffer -nargs=0 CsUpdate       call cscope#Update_cscope_data_file()
    command! -buffer -nargs=0 CsFiles        call cscope#Create_cscope_files(0)
    command! -buffer -nargs=0 RCsFiles       call cscope#Create_cscope_files(1)
    command! -buffer -nargs=1 -complete=customlist,tags#ListTagsFile	    TagsAddCtags	call tags#AddCtags(<q-args>)
    command! -buffer -nargs=1 -complete=customlist,tags#ListAddedTagsFile	TagsDelCtags	call tags#DelCtags(<q-args>)
endfunction

au FileType c,cpp
	    \ call C_Cpp_command()

