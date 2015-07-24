" My gvimrc file
" Author: Lee Savide <laughingman182@gmail.com>
" Set the toolbar & scrollbar settings
set guioptions+=bT
" OS-dependent options {{{
if has("win32") || has("win64")
    setlocal lines=200 columns=200
    " Set GUI font to DejaVu Sans Mono for Powerline
    " so Windows can actually use a functional font
    set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
    set guifontwide=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
    " To save, press ctrl-s.
    nmap <c-s> :w<CR>
    imap <c-s> <Esc>:w<CR>a
else
    if has("gui_macvim")
        " Set Powerline font for symbols in Airline
        set guifont=DejaVu_Sans_Mono_for_Powerline:h11
        set guifontwide=DejaVu_Sans_Mono_for_Powerline:h11
        " Because MacVim is mean
        set background=dark
        colorscheme earendel
        set lines=48 columns=180
        " Set windows to be slightly see-through; MacVim-only
        set transparency=8
        nmap <D-s> :w<CR>
        imap <D-s> <Esc>:w<CR>
        set macmeta
    elseif has("gui_gtk2")
        set guifont=Source\ Code\ Pro\ for\ Powerline
        set guifontwide=Source\ Code\ Pro\ for\ Powerline
        set lines=40 columns=180
    endif
    "set guifont=Inconsolata_for_Powerline:h15
    "set guifontwide=Inconsolata_for_Powerline:h15
endif
" }}}
" GuiTabLabel {{{
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, '&modified')
            let label = '[+] '
            break
            break
        endif
    endfor
    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(v:lnum, '$')
    if wincount > 1
        let label .= wincount
    endif
    if label != ''
        let label .= ' '
    endif
    return label
endfunction
" See ':help setting-guitablabel'
set guitablabel=%{GuiTabLabel()}\ %t
" }}}
" vim: ft=vim fdm=marker
