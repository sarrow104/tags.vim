function! C_Cpp_command()
    command! -buffer -nargs=0 TagsUpdate     call tags#Update_ctags_data_file()
    command! -buffer -nargs=0 CsUpdate       call cscope#Update_cscope_data_file()
    command! -buffer -nargs=0 CsFiles        call cscope#Create_cscope_files(0)
    command! -buffer -nargs=0 RCsFiles       call cscope#Create_cscope_files(1)
endfunction

au FileType c,cpp
	    \ call C_Cpp_command()
