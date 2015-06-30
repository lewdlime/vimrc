" My Vimrc file
" Maintainer: Lee Savide
" License: http://apache.org/licenses/LICENSE-2.0.html
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Also, set for vim to not back up file(s) before saving.
set nocompatible nobackup
" Vundle Init {{{
" Filetype MUST be off for vundle!
filetype off
" Load pathogen
call pathogen#infect()
" Add vundle to the runtimepath
<<<<<<< HEAD
if has("win32" || "win64")
=======
if has("win32")
<<<<<<< HEAD
>>>>>>> fd1686901d735b8111c481bb2aa63addf9a7168d
=======
>>>>>>> 129a2b18f8d7696ef86cd6130ddc0092c2033a47
    set runtimepath+=$VIM\vimfiles\bundle\Vundle.vim\
else
    set runtimepath+=~/.vim/bundle/Vundle.vim/
endif
call vundle#rc()
Bundle 'gmarik/Vundle.vim'
" Required
" Bundles {{{
" Snippets
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
" Original Bundles
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sukima/xmledit'
Bundle 'swaroopch/vim-markdown-preview'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'gmarik/ide-popup.vim'
Bundle 'juvenn/mustache.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'nvie/vim-flake8'
Bundle 'benmills/vimux'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-cucumber'
Bundle 'tomtom/quickfixsigns_vim'
Bundle 'mattn/gist-vim'
Bundle 'msanders/snipmate.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'wesleyche/Trinity'
Bundle 'weierophinney/vimwiki'
Bundle 'rstacruz/sparkup', {'runtimepath': 'vim/'}
<<<<<<< HEAD
<<<<<<< HEAD
Bundle 'ervandew/supertab'
=======
Bundle 'Valloric/YouCompleteMe'
>>>>>>> fd1686901d735b8111c481bb2aa63addf9a7168d
=======

"Bundle 'ervandew/supertab'
>>>>>>> 129a2b18f8d7696ef86cd6130ddc0092c2033a47
Bundle 'fholgado/minibufexpl.vim'
Bundle 'wincent/Command-T'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/pep8'
Bundle 'alfredodeza/pytest.vim'
Bundle 'reinh/vim-makegreen'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'klen/rope-vim'
Bundle 'maksimr/vim-jsbeautify'
"Bundle 'laughingman182/abc-vim'
" Themes
Bundle 'chriskempson/vim-tomorrow-theme'
" vim-scripts Bundles
Bundle 'Csound-compiler-plugin'
" non-github repos

" }}}
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
au Filetype html,xml source $VIM\vimfiles\plugin\wrapwithtag.vim
" jsbeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" }}}
" Settings {{{

" 'spellcheck' is disabled by default
" To enable again, use:
" setlocal spell spelllang=en_us

" Load 'matchit.vim'
runtime macros/matchit.vim
" Set leader character to ','
"let mapleader = ','
" Sets buffers to be hidden when abandoned, not unloaded.
set hidden
" Turn syntax on. 'Highlight colors are overruled but links are kept'
syntax on
" Use syntax-based omnicomplete, set omnicomplete options
set omnifunc=syntaxcomplete#Complete completeopt=menuone,longest,preview
" Set folding options
set foldmethod=indent foldlevel=99 foldcolumn=3
" Tabs converted to 4 spaces
set shiftwidth=4 tabstop=4 backspace=indent,eol,start expandtab smarttab
" Set text and file encoding to Unicode, set line endings to UNIX
set encoding=utf-8 fileencodings=utf-8 fileformat=unix
if has('gui_running')
    if has('mac')
        " because MacVim is mean
        set background=dark
        colorscheme earendel
        set macmeta
    endif
    runtime! plugin/google_python_style.vim
    "colorscheme nuvola
    " Color scheme for music editing
    set background=dark
    colorscheme earendel
    let do_syntax_sel_menu = 1
    runtime! synmenu.vim
    aunmenu &Syntax.&Show\ filetypes\ in\ menu
else
    " Sets window to have a title
    set title
    runtime! plugin/google_python_style.vim
    "colorscheme nuvola
    " Color scheme for music editing
    set background=dark
    colorscheme brookstream
    aunmenu &Syntax.&Show\ filetypes\ in\ menu
endif
" Status line
set laststatus=2
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
" diff function {{{
func MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunc
" }}}
" }}}
" Mappings {{{
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
command O call Open()
map <Leader>o :call Open()<CR>
" }}}
" Plugin Options {{{
" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Pyflakes
let g:pyflakes_use_quickfix = 0
" PEP8
let g:pep8_map='<leader>8'
" SuperTab
"let g:SuperTabDefaultCompletionType = '<C-X><C-V>'
"let g:SuperTabDefaultCompletionType = '<C-X><C-O>'
let g:SuperTabDefaultCompletionType = 'context'
" XML.vim: Fold XML tags, enable XML plugin on editing HTML,
"          set XML tag syntax prefixes,
let g:xml_use_html=1
let g:xml_syntax_folding=1
" VimClojure
let g:vimclojure#ParenRainbow = 1
" NERDTree
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
" Syntastic
let g:syntastic_enable_signs=1
" }}}
" Filetype {{{
" Turn on the filetype features, filetype plugins, and filetype indent now that
" vundle is done loading
filetype on
filetype plugin indent on
" }}}
" vim: ft=vim
