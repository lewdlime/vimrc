" My Vimrc file
" Maintainer: Lee Savide
" License: http://apache.org/licenses/LICENSE-2.0.html
" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
" Also, set for Vim to not back up file(s) before saving.
set nocompatible nobackup
" Vundle Init {{{
" Filetype MUST be off for vundle!
filetype off
" Load pathogen
call pathogen#infect()
call vundle#rc()
" Add vundle to the runtimepath
if has('win32' || 'win64')
    set runtimepath+=$VIM\vimfiles\bundle\Vundle.vim\
    call vundle#begin('$VIM/vimfiles/bundle')
else
    set runtimepath+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
endif
Plugin 'gmarik/Vundle.vim'
" Required
" Bundles {{{
" Powerline
" NOTE: This is only added for the fonts it pulls, do not use powerline
" itself.
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'powerline/fonts'
" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Original Bundles
if has("mac")
    Plugin 'rizzatti/dash.vim'
endif
Plugin 'Lokaltog/vim-easymotion'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/unite.vim'
Plugin 'alfredodeza/pytest.vim'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'chrisbra/csv.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ervandew/supertab'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'fs111/pydoc.vim'
Plugin 'garbas/vim-snipmate'
Plugin 'gcmt/taboo.vim'
Plugin 'gmarik/ide-popup.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'klen/python-mode'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mattn/gist-vim'
Plugin 'mileszs/ack.vim'
Plugin 'mitechie/pyflakes-pathogen'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'nvie/vim-flake8'
Plugin 'reinh/vim-makegreen'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'sukima/xmledit'
Plugin 'swaroopch/vim-markdown-preview'
Plugin 'szw/vim-ctrlspace'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/quickfixsigns_vim'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-flagship'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'triglav/vim-visual-increment'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'vim-scripts/pep8'
Plugin 'weierophinney/vimwiki'
Plugin 'wesleyche/Trinity'
Plugin 'wincent/Command-T'
Plugin 'wincent/ferret'
Plugin 'wincent/terminus'
"Plugin 'laughingman182/abc-vim'
" Themes
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/vim-tomorrow-theme'
" vim-scripts Bundles
Plugin 'AfterColors.vim'
Plugin 'Align.vim'
Plugin 'AnsiEsc.vim'
Plugin 'AutoComplPop'
Plugin 'Csound-compiler-plugin'
Plugin 'Txtfmt-The-Vim-Highlighter'
Plugin 'a.vim'
Plugin 'asciitable.vim'
Plugin 'changeColorScheme.vim'
Plugin 'taglist.vim'
Plugin 'utl.vim'
" non-github repos

call vundle#end()
" }}}
" This helps correct the duplicate help tags.
call pathogen#helptags()
" }}}
" Python Segments {{{
" Assumes Python >= 2.6
if has('python')
" Quick way to open a filename under the cursor in a new tab
" (or URL in a browser)
function! Open()
python <<EOF
import re
import platform
import vim

def launch(uri):
    if platform.system() == 'Darwin':
        vim.command('!open {}'.format(uri))
    elif platform.system() == 'Linux':
        vim.command('!firefox -new-tab {}'.format(uri))

def is_word(text):
    return re.match(r'^[\w./?%:#&=~+-]+$', text) is not None

filename_start = filename_end = vim.current.window.cursor[1] # (row, col)

while filename_start >= 0 and is_word(vim.current.line[filename_start:filename_start+1]):
    filename_start -= 1
filename_start += 1

while filename_end <= len(vim.current.line) and is_word(vim.current.line[filename_end:filename_end+1]):
    filename_end += 1

filename = vim.current.line[filename_start:filename_end]

if filename.endswith('.md') or filename.endswith('.txt'):
    vim.command('tabedit {0}'.format(filename))

elif filename.lower().startswith('http') or filename.lower().startswith('www.'):
    if filename.lower().startswith('www.'):
        filename = 'http://{0}'.format(filename)
    filename = filename.replace('#', r'\#').replace('%', r'\%').replace('~', r'\~')
    launch(filename)

else:
    launch(filename)
EOF

endfunction



" Add the virtualenv's site-packages to vim path
python << EOF
import os.path
import sys
import vim

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))

EOF
endif
" }}}
" AutoCommands {{{
" Set Python scripts to use Python autocompletion
au FileType python setlocal omnifunc=pythoncomplete#Complete
" Make normal text not break up long lines, fold on markers
au FileType txt,none setlocal textwidth=0 foldmethod=marker
" Make XML fold on markers and not wrap
au FileType xml,xhtml,svg,xsl,xslt,fo,rng setlocal textwidth=0 foldmethod=marker
" Make Java and C code fold on syntax
au FileType java,c setlocal textwidth=0 foldmethod=syntax
" Make XML/HTML files have a wrap with tag command using \w
if has("mac") || has("gui_gtk") || has("gui_x11")
    au Filetype html,xml source $HOME/.vim/plugin/wrapwithtag.vim
elseif has("win32") || has("win64")
    au Filetype html,xml source $VIM\vimfiles\plugin\wrapwithtag.vim
endif
" jsbeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" }}}
" Vim Settings {{{
" Set terminal colors to 256 colors
set t_Co=256
" Set statusline characters
set fillchars+=stl:\ ,stlnc:\
" Set embedded terminal as UTF-8, regardless of terminal
set termencoding=utf-8
" Set sessions to save open tabs and globals
set sessionoptions+=tabpages,globals
" 'spellcheck' is disabled by default
" To enable again, use:
"setlocal spell spelllang=en_us
" Load 'matchit.vim'
runtime macros/matchit.vim
" Set leader character to ','
let mapleader=','
" Let window redrawing take it's time
set lazyredraw
" Sets buffers to be hidden when abandoned, not unloaded.
set hidden
" Turn modeline on so files with a modeline comment open with assigned
" settings
set modeline
" Turn syntax on. 'Highlight colors are overruled but links are kept'
syntax on
" Use syntax-based omnicomplete, set omnicomplete options
set omnifunc=syntaxcomplete#Complete completeopt=menuone,longest,preview
" Tabs converted to 4 spaces
set shiftwidth=4 tabstop=4 backspace=indent,eol,start expandtab smarttab
" Set text and file encoding to Unicode, set line endings to UNIX
set encoding=utf-8 fileencodings=utf-8 fileformat=unix
" GUI settings {{{
if has('gui_running')
    if has('gui_macvim')
        " because MacVim is mean
        set background=dark
        colorscheme earendel
        set lines=48 columns=180
        " Set windows to be slightly see-through; MacVim-only
        set transparency=8
        nmap <D-s> :w<CR>
        imap <D-s> <Esc>:w<CR>
        set macmeta
    endif
    runtime! plugin/google_python_style.vim
    set background=dark
    colorscheme earendel
    let do_syntax_sel_menu=1
    runtime! synmenu.vim
    if has('gui_win32')
        aunmenu &Syntax.&Show\ filetypes\ in\ menu
    endif
else
    " Sets window to have a title
    set title
    runtime! plugin/google_python_style.vim
    "colorscheme nuvola
    " Color scheme for music editing
    set background=dark
    "colorscheme brookstream
    colorscheme earendel
    aunmenu &Syntax.&Show\ filetypes\ in\ menu
endif
" }}}
set laststatus=2
" Status line {{{
" clear last format of status line
set statusline=""
" buffer number
set statusline+=%-3.3n\
" filename
set statusline+=%f\
" status flags
set statusline+=%h%m%r%w
" git status
if isdirectory(expand('~/.vim/bundle/fugitive', ':p'))
    set statusline+=%{fugitive#statusline()}
endif
" Syntastic status - makes sense with :Errors
if isdirectory(expand('~/.vim/bundle/syntastic', ':p'))
    set statusline+=%{SyntasticStatuslineFlag()}
endif
" file type
set statusline+=\[%{strlen(&ft)?&ft:'none'}]
" right align remainder
set statusline+=%=
" character value
set statusline+=0x%-8B
" line, character
set statusline+=%-14(%l,%c%V%)
" file position
set statusline+=%<%P
" }}}
" Set foldmethod to marker by default
set foldmethod=marker
" Show position of cursor & show commands that have been entered
set ruler showcmd
" Incremental search & ignore case during searches
set incsearch ignorecase
" Make /g flag default when doing :s
set gdefault
" Show line numbers, enable wildmenu, set completion mode to list all matches
set number wildmenu wildmode=list:longest
" Show current editing mode & show warnings/errors visually and audibly
set showmode visualbell
" Ignore certain filetypes when doing filename completion
set wildignore=*.sw*,*.pyc,*.bak
" Show matching brackets, bracket blinking
set showmatch matchtime=2
" Split new window below current one
set splitbelow
" Automatically read files which have been changed outside of Vim, if we
" haven't changed it already.
set autoread
" Have vim scroll like Linux, not Windows
set scrolloff=1
" Reformatting options. See `:help fo-table`
set formatoptions+=lnor1
" Disable spellcheck by default
set nospell
" diff setting
set diffexpr=MyDiff()
" Set colors for omnicompletion popup menu
highlight Pmenu guibg=brown gui=bold
highlight Pmenu ctermbg=238 gui=bold
" }}}
" Functions {{{
" SmartTab completion
function! SmartTabComplete()
  let line=getline('.')                         " current line
  let substr=strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr=matchstr(substr, "[^ \t]*$")       " word till cursor
  if(strlen(substr)==0)                           " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period=match(substr, '\.') != -1      " position of period, if any
  let has_slash=match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif(has_slash)
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction
" HighlightRepeats
function! HighlightRepeats() range
  let lineCounts={}
  let lineNum=a:firstline
  while lineNum <= a:lastline
    let lineText=getline(lineNum)
    if lineText != ""
      let lineCounts[lineText]=(has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum=lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
" diff function {{{
function! MyDiff()
  let opt='-a --binary '
  if &diffopt =~ 'icase' | let opt=opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt=opt . '-b ' | endif
  let arg1=v:fname_in
  if arg1 =~ ' ' | let arg1='"' . arg1 . '"' | endif
  let arg2=v:fname_new
  if arg2 =~ ' ' | let arg2='"' . arg2 . '"' | endif
  let arg3=v:fname_out
  if arg3 =~ ' ' | let arg3='"' . arg3 . '"' | endif
  let eq=''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd='""' . $VIMRUNTIME . '\diff"'
      let eq='"'
    else
      let cmd=substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd=$VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunc
" }}}
" }}}
" Mappings {{{
" Vim Airline
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" To save, press ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
" Move cursor up and down by displayed lines when wrapping
" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk
" Move between windows with Ctrl + [jklh]
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" Move between tabs with Alt + j / k for right / left tabs
noremap <A-j> :tabN<CR>
noremap <D-j> :tabN<CR>
noremap <A-k> :tabn<CR>
noremap <D-k> :tabn<CR>
" Move to marks so that you jump to the line & cursor the mark was made at
" http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '
" Control the viewport (Ctrl + [ey])
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
" Remove the Windows ^M (\d)
map <Leader>d mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Time Stamp (F3)
nmap <F3> a<C-R>=strftime("%b %d %Y")<CR><Esc>
imap <F3> <C-R>=strftime("%b %d %Y")<CR>
" Ack (\a)
nmap <leader>a <Esc>:Ack!
" Gundo (\g)
map <leader>g :GundoToggle<CR>
" Rope (\[jr])
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
" NERDTree (\n)
map <Leader>n :NERDTreeToggle<CR>
" MakeGreen
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
" TaskList (\td)
map <leader>td <Plug>TaskList
" Pytest (\[tf,tc,tm,tb,tp,te])
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>
" Python-based mappings (:O \o)
command! O call Open()
map <Leader>o :call Open()<CR>
" }}}
" Plugin Options {{{
" Vim Airline {{{
let g:airline_theme='kalisi'
let g:airline_powerline_fonts=1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_detect_iminsert=1
let g:airline_inactive_collapse=1
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.branch=''
let g:airline_symbols.readonly=''
let g:airline_symbols.linenr=''
let g:airline#extensions#quickfix#quickfix_text='Quickfix'
let g:airline#extensions#quickfix#location_text='Location'
let g:airline#extensions#bufferline#enabled=1
let g:airline#extensions#bufferline#overwrite_variables=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message=''
let g:airline#extensions#branch#displayed_head_limit=10
let g:airline#extensions#branch#format=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#ctrlp#color_template='insert'
let g:airline#extensions#ctrlp#show_adjacent_modes=1
" NOTE: only change tabline to enabled if on Linux or Windows, where the
" tabline is ugly enought to want it to be controlled by airline. On MacVim,
" keep the tabline the default.
if has('win32') || has('win64') || has('gui_gtk2') || has('x11')
  let g:airline#extensions#tabline#enabled=1
endif
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#show_tab_nr=1
let g:airline#extensions#tabline#formatter='default'
let g:airline#extensions#tabline#show_close_button=1
let g:airline#extensions#tabline#close_symbol='X'
let g:airline#extensions#tmuxline#enabled=1
let airline#extensions#tmuxline#color_template='normal'
let g:airline#extensions#promptline#enabled=1
let airline#extensions#promptline#color_template='normal'
let g:airline#extensions#ctrlspace#enabled=1
" }}}
" Ultisnips
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Pyflakes
let g:pyflakes_use_quickfix=0
" PEP8
let g:pep8_map='<leader>8'
" SuperTab {{{
"let g:SuperTabDefaultCompletionType='<C-P>'
"let g:SuperTabDefaultCompletionType='<C-X><C-V>'
"let g:SuperTabDefaultCompletionType='<C-X><C-O>'
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='context'
let g:SuperTabCompletionContexts=['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence=['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery=["&completefunc:<C-X><C-U>", "&omnifunc:<c-x><c-o>"]
let g:SuperTabRetainCompletionDuration='insert'
let g:SuperTabNoCompleteAfter=['^', '\s', '\t']
let g:SuperTabCompleteCase='ignorcase'
" }}}
" XML.vim: Fold XML tags, enable XML plugin on editing HTML,
"     set XML tag syntax prefixes,
let g:xml_use_html=1
let g:xml_syntax_folding=1
" VimClojure
let g:vimclojure#ParenRainbow=1
" NERDTree
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
" Syntastic
let g:syntastic_enable_signs=1
" Taboo.vim
let g:taboo_tab_format=" %n %f%m "
" Rainbow Parentheses {{{
let g:rbpt_colorpairs=[
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'], ]
let g:rbpt_max=16
" }}}
" }}}
" Filetype {{{
" Turn on the filetype features, filetype plugins, and filetype indent now that
" vundle is done loading
filetype on
filetype plugin indent on
" }}}
" vim: ft=vim fdm=marker
