augroup PlayNice_Autoswap
    autocmd!
    autocmd SwapExists *  call s:PlayNice_Autoswap(expand('<afile>:p'), v:swapname)
augroup END

" Lifted from this history of <https://github.com/gioele/vim-autoswap>.
function! s:PlayNice_Autoswap (filename, swapname)
    " if swapfile is older than file itself, just get rid of it
    if getftime(v:swapname) < getftime(a:filename)
        call delete(v:swapname)
        let v:swapchoice = 'e'
    endif
endfunction
augroup PlayNice_SwapFileModified
    autocmd!
    autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
      \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
augroup END

augroup PlayNice_checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * 
         \ checktime
    endif
augroup END
