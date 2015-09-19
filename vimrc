" My Vimrc file
" Maintainer: Lee Savide
" License: http://apache.org/licenses/LICENSE-2.0.html
" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
" Also, set for Vim to not back up file(s) before saving.
set nocompatible nobackup
" Use the old regex engine
set re=1
" HUZZAH! BAP UN-BRONDO c(●▽● c)
set magic
" Vim-Plug {{{
" Vim-Plug Startup {{{
" Load pathogen
call pathogen#infect()
call plug#begin('$VIM\vimfiles\plugged')
" }}}
" Bundles {{{
" Original Bundles {{{
Plug 'tomtom/enabler_vim'
" Completions {{{
Plug 'ervandew/supertab'
Plug 'dirkwallenstein/vim-autocomplpop'
" }}}
" Snippets {{{
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'msanders/snipmate.vim'
Plug 'mustache/vim-mustache-handlebars'
" }}}
"Plug 'powerline/fonts'
" Generic Plugins {{{
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimshell.vim'
Plug 'benmills/vimux'
Plug 'gcmt/taboo.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow'
Plug 'mileszs/ack.vim'
Plug 'reinh/vim-makegreen'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'sjl/gundo.vim'
Plug 'syngan/vim-vimlint'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomtom/quickfixsigns_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'triglav/vim-visual-increment'
Plug 'weierophinney/vimwiki'
Plug 'wesleyche/Trinity'
Plug 'weynhamz/vim-plugin-minibufexpl'
Plug 'wincent/terminus'
" }}}
" Movement and Marks {{{
Plug 'gcmt/breeze.vim'
Plug 'easymotion/vim-easymotion'
Plug 'kien/ctrlp.vim'
Plug 'kshenoy/vim-signature'
Plug 'szw/vim-ctrlspace'
Plug 'wincent/Command-T'
" }}}
" Cross Platform {{{
" Specific to Mac OS X
if has('mac')
  Plug 'rizzatti/dash.vim'
endif
" All BUT Windows
if has(!'win32') || has(!'win64')
  Plug 'chiphogg/vim-vtd'
  Plug 'wincent/ferret'
  Plug 'rking/ag.vim'
endif
" }}}
" Status Line {{{
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'edkolev/promptline.vim'
" }}}
" Syntax and Filetypes {{{
Plug 'chrisbra/csv.vim'
Plug 'dag/vim-fish'
Plug 'kchmck/vim-coffee-script'
Plug 'klen/python-mode'
Plug 'mattn/emmet-vim'
Plug 'mitechie/pyflakes-pathogen'
Plug 'neowit/vim-force.com'
Plug 'scrooloose/syntastic'
Plug 'sukima/xmledit'
Plug 'swaroopch/vim-markdown-preview'
" }}}
" Google {{{
" See also: https://github.com/google/vroom.git
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
Plug 'google/vim-codefmt'
Plug 'google/vim-coverage'
Plug 'google/vim-ft-vroom'
Plug 'google/vim-glaive'
Plug 'google/vim-maktaba'
Plug 'google/vim-syncopate'
" }}}
" Git {{{
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv'
Plug 'mattn/gist-vim'
Plug 'rdolgushin/gitignore.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
" }}}
" Themes {{{
Plug 'Colour-Sampler-Pack'
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'google/vim-colorscheme-primary'
Plug 'itchyny/landscape.vim'
Plug 'tpope/vim-vividchalk'
" }}}
" vim-scripts {{{
"Plugin 'AutoComplPop'
"Plugin 'L9'
"Plugin 'changeColorScheme.vim'
Plug 'AfterColors.vim'
Plug 'Conque-Shell'
Plug 'Csound-compiler-plugin'
Plug 'DirDiff.vim'
Plug 'DrawIt'
Plug 'TaskList.vim'
Plug 'Txtfmt-The-Vim-Highlighter'
Plug 'c.vim'
Plug 'cecutil'
Plug 'cppcomplete'
Plug 'listmaps.vim'
Plug 'matchit.zip'
Plug 'taglist.vim'
Plug 'utl.vim'
Plug 'vim_faq'
" }}}
" }}}
" Non-Github Repos {{{

" }}}
call plug#end()
" This helps correct the duplicate help tags.
call pathogen#helptags()
" }}}
" }}}
" Vim Settings {{{
" GUI settings {{{
if has('gui_running')
  if has('gui_macvim')
    set background=dark
    colorscheme earendel
    set lines=48 columns=180
    set transparency=8
    nmap <D-s> :w<CR>
    imap <D-s> <Esc>:w<CR>
    set macmeta
  endif
  runtime! indent/google_python_style.vim
  set background=dark
  colorscheme earendel
  let do_syntax_sel_menu=1
  runtime! synmenu.vim
else
  " Sets window to have a title
  set title
  runtime! plugin/google_python_style.vim
  "colorscheme nuvola
  set background=dark
  "colorscheme brookstream
  colorscheme earendel
  aunmenu &Syntax.&Show\ filetypes\ in\ menu
endif
" }}}
" Status line {{{
" Show extra info in status line
set laststatus=2
" clear last format of status line
set statusline=''
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
" right align remainder: character value, line, character, file position
set statusline+=%=0x%-8B%-14(%l,%c%V%)%<%P
" }}}
" Syntax highlighting on
syntax on
" Set leader key to be able to use special mappings
let mapleader=','
let g:mapleader=','
let maplocalleader=','
let g:maplocalleader=','
" Terminal colors to 256 colors
set t_Co=256
" Disable spellcheck & do not show editing mode
" (vim-airline handles mode display)
set nospell noshowmode
" Statusline characters
set fillchars+=stl:\ ,stlnc:\
" Embedded terminal as UTF-8, regardless of terminal
set termencoding=utf-8
" Sessions to save open tabs and globals
set sessionoptions+=tabpages,globals
" Load 'matchit.vim'
runtime macros/matchit.vim
" Let window redraw take it's time
set lazyredraw
" Sets buffers to be hidden when abandoned, not unloaded
set hidden
" Files with a modeline parse as intended
set modeline
" Set command height
set cmdheight=2
" Syntax-based omnicomplete, omnicomplete options
set omnifunc=syntaxcomplete#Complete completeopt=menu,menuone,longest,preview
" Tabs converted to 4 spaces
set shiftwidth=4 tabstop=4 backspace=indent,eol,start whichwrap+=<,>,h,l expandtab smarttab
" Text and file encoding to Unicode, line endings to UNIX \n
set encoding=utf-8 fileencodings=utf-8 fileformat=unix
" foldmethod is marker by default
set foldmethod=marker
" Position of cursor & commands that have been entered
set ruler showcmd
" Incremental search & ignore case during searches
set incsearch ignorecase
" Make /g flag default when doing :s
set gdefault
" line numbers, gutter width, enable wildmenu, completion mode to list all matches,
" ignore certain filetypes for filename completions
set number numberwidth=5 wildmenu wildmode=list:longest wildignore=*.sw*,*.pyc,*.bak
" Warnings/errors visually and audibly
set visualbell
" Matching brackets, bracket blinking
set showmatch matchtime=2
" Split new window below current one
set splitbelow
" Automatically read files changed outside of Vim
set autoread
" Have vim scroll like Linux, not Windows
set scrolloff=1
" Reformatting options, see :help fo-table
set formatoptions+=lnor1
" Colors for omnicompletion popup menu
highlight Pmenu guibg=brown gui=bold
highlight Pmenu ctermbg=238 gui=bold
" }}}
" AutoCommands {{{
" autocompletion
au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Normal text not break up long lines, fold on markers
au FileType txt,none setlocal foldmethod=marker textwidth=0
" XML fold on markers and not wrap
au FileType xml,xhtml,svg,xsl,xslt,fo,rng setlocal foldmethod=marker textwidth=0
" Java and C code fold on syntax
au FileType java,c setlocal foldmethod=syntax textwidth=0
" VimL fold on markers and have tab at 2 spaces
au FileType vim setlocal foldmethod=marker tabstop=2 shiftwidth=2
" Make XML/HTML files have a wrap with tag command using \w
if has("mac") || has("gui_gtk") || has("gui_x11")
    au Filetype html,xml source $HOME/.vim/plugin/wrapwithtag.vim
elseif has("win32") || has("win64")
    au Filetype html,xml source $VIM\vimfiles\plugin\wrapwithtag.vim
endif
" jsbeautify
au FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
au FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
au FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}
" Functions {{{
" SmartTabComplete() {{{
function! SmartTabComplete()
  let line = getline('.')                    " current line
  let substr = strpart(line, -1, col('.')+1) " from the start of the current
                                             " line to one character right
                                             " of the cursor
  let substr = matchstr(substr, '[^ \t]*$')  " word till cursor
  if (strlen(substr)==0)                     " nothing to match on empty string
    return '\<tab>'
  endif
  let has_period = match(substr, '\.') != -1 " position of period, if any
  let has_slash = match(substr, '\/') != -1  " position of slash, if any
  if (!has_period && !has_slash)
    return '\<C-X>\<C-P>' " existing text matching
  elseif ( has_slash )
    return '\<C-X>\<C-F>' " file matching
  else
    return '\<C-X>\<C-O>' " plugin matching
  endif
endfunction
" }}}
" HighlightRepeats() {{{
function! HighlightRepeats() range
  let lineCounts={}
  let lineNum=a:firstline
  while lineNum <= a:lastline
    let lineText=getline(lineNum)
    if lineText != ''
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
" }}}
" MyDiff() {{{
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
" diff setting 
set diffexpr=MyDiff()
" }}}
" }}}
" Mappings {{{
" Completions {{{
inoremap <tab> <c-r>=SmartTabComplete()<CR>
" ide-popup.vim
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
snoremap <expr> <C-p> pumvisible() ? '<C-n>' : '<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<CR>'
" }}}
" Jdl mapping - Ctrl-J
noremap <D-J> <Esc>:normal Jdl<CR>
" Sort words in a line with <F2>
vnoremap <F2> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>
" Insert time stamp with <F3>
nmap <F3> a<C-R>=strftime("%b %d %Y")<CR><Esc>
imap <F3> <C-R>=strftime("%b %d %Y")<CR>
" Paste mode mappings. They work the same way.
set pastetoggle=<F4>
nnoremap <F4> :set invpaste paste?<CR>
" Ctrl-S = Write buffer
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
" Remove the Windows ^M (,d)
map <Leader>d mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Visual selection searches with * or #
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" Vim Airline {{{
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" }}}
" Movement Mappings {{{
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
" }}}
" Plugin Mappings {{{
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
" }}}
" Python-based mappings (:O \o)
command! O call Open()
map <Leader>o :call Open()<CR>
" }}}
" Plugin Options {{{
" Completions {{{
" AutoComplPop {{{
let g:acp_enableAtStartup=1
let g:acp_mappingDriven=0
" }}}
" SuperTab {{{
let g:SuperTabDefaultCompletionType='<C-P>'
let g:SuperTabDefaultCompletionType='<C-X><C-U>'
let g:SuperTabDefaultCompletionType='<C-X><C-O>'
let g:SuperTabNoCompleteAfter=['^', '\s', '\t']
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='<C-X><C-U>'
let g:SuperTabCompletionContexts=['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence=['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery=["&completefunc:<C-X><C-U>", "&omnifunc:<C-X><C-O>"]
let g:SuperTabRetainCompletionDuration='insert'
let g:SuperTabCompleteCase='ignorcase'
" }}}
" }}}
" Ultisnips {{{
" let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'
" }}}
" Vim Airline {{{
" Theme for airline to use
let g:airline_theme='light'
" Requires Powerline patched fonts
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
if has('gui_running')
  let g:airline#extensions#tabline#enabled=0
else
  let g:airline#extensions#tmuxline#enabled=1
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
" vim-gitgutter {{{
let g:gitgutter_max_signs = 500
" }}}
" Rainbow Parentheses {{{
" oblitum/rainbow
let g:lisp_rainbow=1
let g:rainbow_active=0
let g:rainbow_conf={ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
                   \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
                   \ 'operators': '_,_',
                   \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
                   \ 'separately': {
                   \     '*': {},
                   \     'tex': { 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'], },
                   \     'lisp': { 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'], },
                   \     'vim': { 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'], },
                   \     'html': { 'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'], },
                   \     'css': 0,
                   \ } }
" klen/rainbow_parentheses.vim
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
let g:rbpt_loadcmd_toggle = 0
" }}}
" vim-force.com {{{
if has('gui_macvim')
  let g:apex_backup_folder='$HOME/Documents/Projects/sources/sf_backup'
  let g:apex_temp_folder='$HOME/Documents/Projects/sources/sf_backup/temp'
  let g:apex_properties_folder='$HOME/Documents/Projects/sources/sf_backup/resources'
  let g:apex_tooling_force_dot_com_path='/Library/Java/Extensions'
endif
" }}}
" ag.vim
let g:ackprg='ag --vimgrep'
" Pyflakes
let g:pyflakes_use_quickfix=0
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
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['java']}
" Taboo.vim
let g:taboo_tab_format=' %n %f%m '
" }}}
" Filetype {{{
" Turn on the filetype features, filetype plugins, and filetype indent now that
" vundle is done loading
filetype on
filetype plugin indent on
" }}}
" vim: fdm=marker ft=vim
