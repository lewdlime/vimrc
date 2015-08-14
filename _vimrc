" My Vimrc file
" Maintainer: Lee Savide
" License: http://apache.org/licenses/LICENSE-2.0.html
" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
" Also, set for Vim to not back up file(s) before saving.
set nocompatible nobackup
" USE THE OLD REGEX ENGINE
set re=1
" Vundle Init {{{
" Vundle Startup {{{
" Filetype MUST be off for vundle!
filetype off
" Load pathogen
call pathogen#infect()
" Add vundle to the runtimepath
if has('win32' || 'win64')
    set runtimepath+=$VIM\vimfiles\bundle\Vundle.vim\
else
    set runtimepath+=~/.vim/bundle/Vundle.vim/
endif
call vundle#rc()
call vundle#begin()
" Required
Plugin 'gmarik/Vundle.vim'
" Only use this fork for Windows.
"Plugin 'laughingman182/Vundle.vim'
" }}}
" Bundles {{{
" Powerline fonts are required for Powerline to be useful to Vim
Plugin 'powerline/fonts'
" Snippets {{{
" Snippets 'engine'
Plugin 'honza/vim-snippets'
" Snippets controller
Plugin 'SirVer/ultisnips'
" Second snippets controller
"Plugin 'msanders/snipmate.vim'
" }}}
" Original Bundles {{{
if has("mac")
    Plugin 'rizzatti/dash.vim'
endif
" See also: https://github.com/google/vroom.git
Plugin 'ervandew/supertab'
"Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'chiphogg/vim-vtd'
Plugin 'chrisbra/csv.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'edkolev/promptline.vim'
Plugin 'gcmt/taboo.vim'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-coverage'
Plugin 'google/vim-ft-vroom'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-syncopate'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'klen/python-mode'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/gist-vim'
Plugin 'mileszs/ack.vim'
Plugin 'mitechie/pyflakes-pathogen'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'neowit/vim-force.com'
Plugin 'othree/vim-autocomplpop'
Plugin 'reinh/vim-makegreen'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'sukima/xmledit'
Plugin 'swaroopch/vim-markdown-preview'
Plugin 'syngan/vim-vimlint'
Plugin 'szw/vim-ctrlspace'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/quickfixsigns_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-flagship'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'triglav/vim-visual-increment'
Plugin 'weierophinney/vimwiki'
Plugin 'wesleyche/Trinity'
Plugin 'weynhamz/vim-plugin-minibufexpl'
Plugin 'wincent/Command-T'
Plugin 'wincent/ferret'
Plugin 'wincent/terminus'
" 'Addons' {{{
Plugin 'glts/vim-magnum'
Plugin 'glts/vim-radical'
" }}}
" }}}
" Themes {{{
Plugin 'Colour-Sampler-Pack'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'google/vim-colorscheme-primary'
Plugin 'itchyny/landscape.vim'
" }}}
" vim-scripts Plugins {{{
"Plugin 'AutoComplPop'
"Plugin 'L9'
"Plugin 'changeColorScheme.vim'
Plugin 'AfterColors.vim'
Plugin 'Conque-Shell'
Plugin 'Csound-compiler-plugin'
Plugin 'DirDiff.vim'
Plugin 'DrawIt'
Plugin 'TaskList.vim'
Plugin 'Txtfmt-The-Vim-Highlighter'
Plugin 'c.vim'
Plugin 'cecutil'
Plugin 'cppcomplete'
Plugin 'gist.vim'
Plugin 'matchit.zip'
Plugin 'taglist.vim'
Plugin 'utl.vim'
Plugin 'vim_faq'
" }}}
" Non-Github Repos {{{

" }}}
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
" Vim Settings {{{
syntax on
" Terminal colors to 256 colors
set t_Co=256
" Statusline characters
set fillchars+=stl:\ ,stlnc:\
" Embedded terminal as UTF-8, regardless of terminal
set termencoding=utf-8
" Sessions to save open tabs and globals
set sessionoptions+=tabpages,globals
" Load 'matchit.vim'
runtime macros/matchit.vim
" Let window redrawing take it's time
set lazyredraw
" Sets buffers to be hidden when abandoned, not unloaded
set hidden
" Modeline on so files with a modeline comment open with assigned settings
"set modeline
" Syntax-based omnicomplete, omnicomplete options
set omnifunc=syntaxcomplete#Complete completeopt=menu,menuone,longest,preview
" Tabs converted to 4 spaces
set shiftwidth=4 tabstop=4 backspace=indent,eol,start expandtab smarttab
" Text and file encoding to Unicode, line endings to UNIX \n
set encoding=utf-8 fileencodings=utf-8 fileformat=unix
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
" right align remainder
set statusline+=%=
" character value
set statusline+=0x%-8B
" line, character
set statusline+=%-14(%l,%c%V%)
" file position
set statusline+=%<%P
" }}}
" foldmethod is marker by default
set foldmethod=marker
" Position of cursor & commands that have been entered
set ruler showcmd
" Incremental search & ignore case during searches
set incsearch ignorecase
" Make /g flag default when doing :s
set gdefault
" line numbers, enable wildmenu, completion mode to list all matches
set number wildmenu wildmode=list:longest
" Warnings/errors visually and audibly
set visualbell
" Ignore certain filetypes when doing filename completion
set wildignore=*.sw*,*.pyc,*.bak
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
" Disable spellcheck & editing mode display by default
" (vim-airline handles mode display)
set nospell noshowmode
" diff setting
set diffexpr=MyDiff()
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
" }}}
" Functions {{{
" neocomplete_cr() {{{
"function! s:neocomplete_cr()
"  return neocomplete#close_popup() . '\<CR>'
"  return pumvisible() ? neocomplete#close_popup() : '\<CR>'
"endfunction
" }}}
" SmartTabComplete() {{{
"function! SmartTabComplete()
"  let line=getline('.')                         " current line
"  let substr=strpart(line, -1, col('.')+1)      " from the start of the current
                                                " line to one character right
                                                " of the cursor
"  let substr=matchstr(substr, "[^ \t]*$")       " word till cursor
"  if(strlen(substr)==0)                         " nothing to match on empty string
"    return '\<tab>'
"  endif
"  let has_period=match(substr, '\.') != -1      " position of period, if any
"  let has_slash=match(substr, '\/') != -1       " position of slash, if any
"  if (!has_period && !has_slash)
"    return '\<C-X>\<C-P>'                       " existing text matching
"  elseif(has_slash)
"    return '\<C-X>\<C-F>'                       " file matching
"  else
"    return '\<C-X>\<C-O>'                       " plugin matching
"  endif
"endfunction
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
" SuperTab
"inoremap <expr> <Space> pumvisible() ? '\<C-y>' : ' '
" neocomplete
inoremap <silent> <CR> <C-r>=<SID>neocomplete_cr()<CR>
inoremap <expr><TAB>  pumvisible() ? '\<C-n>' : '\<TAB>'
inoremap <expr><C-h> neocomplete#smart_close_popup().'\<C-h>'
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" ide-popup.vim
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
snoremap <expr> <C-p> pumvisible() ? '<C-n>' : '<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<CR>'
" Sort word in a line with <F2>
vnoremap <F4> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F2>
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
" Airline theme
let g:airline_theme='light'
" Let there be neat symbols; Requires Powerline patched fonts
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
let g:airline#extensions#tabline#enabled=0
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
" ag.vim
let g:ackprg='ag --vimgrep'
" Pyflakes
let g:pyflakes_use_quickfix=0
" Ultisnips {{{
" let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'
" }}}
" AutoComplPop {{{
" This needs to be off for neocomplete to work.
"let g:acp_enableAtStartup=0
" }}}
" neocomplete (Requires lua support.) {{{
"let g:neocomplete#enable_at_startup=1
"let g:neocomplete#enable_smart_case=1
"let g:neocomplete#enable_auto_select=1
"let g:neocomplete#enable_multibyte_completion=1
"if !exists('g:neocomplete#keyword_patterns')
"  let g:neocomplete#keyword_patterns={}
"endif
"let g:neocomplete#keyword_patterns['default']='\h\w*'
"if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns={}
"endif
"let g:neocomplete#sources#omni#input_patterns.php='[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
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
let g:syntastic_mode_map={ 'mode': 'active', 'passive_filetypes': ['java'] }
" Taboo.vim
let g:taboo_tab_format=' %n %f%m '
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
" vim-force.com {{{
if has('gui_macvim')
  let g:apex_backup_folder='$HOME/Documents/Projects/sources/sf_backup'
  let g:apex_temp_folder='$HOME/Documents/Projects/sources/sf_backup/temp'
  let g:apex_properties_folder='$HOME/Documents/Projects/sources/sf_backup/resources'
  let g:apex_tooling_force_dot_com_path='/Library/Java/Extensions'
endif
" }}}
" }}}
" Filetype {{{
" Turn on the filetype features, filetype plugins, and filetype indent now that
" vundle is done loading
filetype on
filetype plugin indent on
" }}}
" vim: fdm=marker ft=vim
