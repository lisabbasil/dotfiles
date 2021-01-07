"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Allow saving of files as sudo when
cmap w!! w !sudo tee > /dev/null %

inoremap jj <ESC>
noremap <leader>q :qa<cr>

" Bash shortcut
set shell=bash\ --rcfile\ ~/.vimbashrc
noremap <leader>bh :shell<cr>

noremap <leader><cr> @:
nmap <leader>bc <Plug>Kwbd
" Replace grep command with user function smartgrep as old grep doesn't support --exclude-dir option
noremap <leader>gr :!bash -c ". ~/.alias; smartgrep "
"noremap <leader>gr :!grep -ir --color --exclude="*\.svn/*" --exclude="*obj/"
noremap <leader>nt :NERDTreeToggle<cr>

" Open the python interpreter
noremap <leader>py :!ipython<cr>

" Check for differences between file in buffer and on disk
command Wdiff :w !diff -u % -

let MRU_File=expand('$HOME/.vim/temp/mru.txt')

" yankstack key mappings
let g:yankstack_map_keys = 0
nmap <C-p> <Plug>yankstack_substitute_older_paste
xmap <C-p> <Plug>yankstack_substitute_older_paste
imap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste
xmap <C-n> <Plug>yankstack_substitute_newer_paste
imap <C-n> <Plug>yankstack_substitute_newer_paste

" Use Vim defaults instead of 100% vi compatibility
set nocompatible
" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
set nomodeline

" Sets how many lines of history vim has to remember
set history=100

" Set this, so the background color will not change inside tmux (http://snk.tuxfamily.org/log/vim-256color-bce.html)
set t_ut=

" Use Pathogen to install vim plugins
call pathogen#infect()
call pathogen#helptags()

" Search pattern and list it (sl stands for search/list, for lack of a better name)
" See, for info about the global (search) command:
" http://vim.wikia.com/wiki/Power_of_g
" See, for info about the 
" https://vi.stackexchange.com/q/18737/
:command! -nargs=1 SL g/<args>/z#.1
" Since nargs is equal to 1, whitespaces are allowed in the search pattern

" Add empty line before or after cursor, jump to last location (i.e. pretend that cursor doesn't move at all)
nnoremap <leader>o o<ESC>k``
nnoremap <leader>O O<ESC>j``

" F keys
" F1: Toggle paste mode and get visual feedback (http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste)
nnoremap <F1> :set invpaste paste?<CR>
set pastetoggle=<F1>
set showmode
" F2: Toggle wrap
nnoremap <F2> :set wrap!<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set number of lines to the cursor - when moving vertically using j/k
set so=8
" and horizontally using h/l
set sidescrolloff=8

" Turn on the WiLd menu
set wildmenu
set wildmode=list:longest

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*.aux

"Always show current position
set ruler

" Height of the command bar
"set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Map * and # to itself but prevent jumping to next (last) occurrence
nnoremap * *``
nnoremap # #``

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set vb t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Show partial command in commandline
set showcmd

" When splitting jump to new splitted window (below or right)
set splitbelow
set splitright

" Toggle horizontal/vertical split; especially useful in vimdiff
function! ToggleWindowHorizontalVerticalSplit()
	if !exists('t:splitType')
		let t:splitType = 'vertical'
	endif

	if t:splitType == 'vertical' " vertical: switch to horizontal
		windo wincmd K
		let t:splitType = 'horizontal'

	else " horizontal: switch to vertical
		windo wincmd H
		let t:splitType = 'vertical'
	endif
endfunction

nnoremap <leader>hv :call ToggleWindowHorizontalVerticalSplit()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LaTeX suite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
" Use a makefile; define target in .vimrcPrivat
let g:Tex_UseMakefile=1
" Don't jump to error
let g:Tex_GotoError=0
" Output all warnings (This doesn't seem to work, so we use TCLevel,
" this doesn't work either, so make a function (see below))
"let g:Tex_IgnoreLevel=0
"autocmd FileType tex TCLevel 1
" For pdflatex
let g:Tex_DefaultTargetFormat='pdf'
" Define what to fold (.= for appending!)
let g:Tex_FoldedEnvironments=',itemize,sideways'
" Turn off <++> placeholder
let g:Imap_UsePlaceHolders=0

" Compiling LaTeXSuite with <leader>ll does change the directory (only for pdflatex) and can't find the log file afterwards, so we cd back to vimHomeDir
function! CompileLaTeXSuite()
    " Set TCLevel here, otherwise it won't work (it's a bug, I guess)
    TCLevel 0
    call Tex_RunLaTeX()
    cd `=g:vimHomeDir`
endfunction

" For tex files, overwrite compile shortcut <leader>m with the one from LaTeX suite
autocmd FileType tex noremap <buffer> <leader>m :call CompileLaTeXSuite()<CR>

" Quickly reformat paragraph
map <leader>gq mz{gq}`z
" Quickly indent complete document
map <leader>= mzgg=G`z

" Compile with XeLaTeX
function CompileXeTex()
    let oldCompileRule=g:Tex_CompileRule_pdf
    let g:Tex_CompileRule_pdf = 'xelatex -aux-directory=F:/Vim/my_latex_doc/temp --synctex=-1 -src-specials -interaction=nonstopmode $*'
    call Tex_RunLaTeX()
    let g:Tex_CompileRule_pdf=oldCompileRule
endfunction
map <Leader>xl :<C-U>call CompileXeTex()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable 

" Use peaksea as graphical highlighting
" When activating 256 colors, no bold fonts are shown
set t_Co=256 

" feel free to choose :set background=light for a different style 
set background=dark 
colors peaksea

" Show line numbers
set number

" Use mouse for all (a)
set mouse=a

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set colors for tabbar
hi TabLineFill ctermbg=240
hi TabLine ctermbg=22
hi TabLineSel ctermbg=58

" Make warnings more visible
hi WarningMsg ctermfg=white ctermbg=red

" Set style of cursor line/column
" See here for color codes:
" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
hi CursorLine cterm=NONE ctermbg=26 ctermfg=154
hi CursorColumn cterm=NONE ctermbg=124 ctermfg=16


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" Shortcut for undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Turn persistent undo on 
" means that you can undo even when you close a buffer/VIM
"try
    set undodir=~/.vim/temp/undo
    set undofile
"catch
"endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Wrap lines - not anymore
"set wrap
set nowrap

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" only 2 spaces for tex files!
autocmd FileType tex setlocal shiftwidth=2 tabstop=2
autocmd FileType text setlocal shiftwidth=2 tabstop=2
" only 2 spaces for some specific files
autocmd BufRead ~/todo setlocal shiftwidth=2 tabstop=2
autocmd BufRead ~/notes/* setlocal shiftwidth=2 tabstop=2

" Linebreak on 80 characters
set lbr
set tw=80

" No linebreak for HTML files
autocmd FileType html set tw=0
autocmd FileType css set tw=0

set ai "autoindent
"set si "smartindent
"set cindent

" Smartindent removes indent when lines starting with '#', turn it off
" (https://stackoverflow.com/a/2360284/1945981)
inoremap # X#

" Don't treat # as special (otherwise it ignores indenting)
set cinkeys-=0#

map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
map <leader>0 10gt


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk


" Smart way to move between windows (deactivated as I use those shortcuts in tmux)
nmap <leader>j <C-W>j
nmap <leader>k <C-W>k
nmap <leader>h <C-W>h
nmap <leader>l <C-W>l

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
"autocmd BufWrite *.py :call DeleteTrailingWS()
nmap <leader>tr :call DeleteTrailingWS()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle spell checking
map <leader>ss :setlocal spell! spelllang=en_us<cr>

" Colors for words that failed spell check
" Word not recognized
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=blue
" Word not capitalized
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=red
" Word is rare
hi clear SpellRare
hi SpellRare cterm=underline ctermfg=green
" Wrong spelling for selected region
hi clear SpellLocal
hi SpellLocal cterm=underline ctermfg=yellow

"" Shortcuts using <leader>
"map <leader>sn ]s
"map <leader>sp [s
"map <leader>sa zg
"map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quickly open a buffer for scribble
map <leader>bu :tabnew ~/Downloads/vim-buffer<cr>
noremap <leader>ch :!eog ~/Pictures/vi-vim-cheat-sheet.gif &<cr><cr>
map <leader>to :tabnew ~/todo<cr>
"map <leader>pr :!evince 201*.pdf<cr>

" Turn on digraph, to e.g. use the following shortcuts
" See http://vim.wikia.com/wiki/Entering_special_characters
" a<BS>: : ä
" e<BS>> : ê
" e<BS>! : è
" e<BS>' : é
"set digraph


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Programming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"noremap <leader>tl :TlistToggle<cr>:wincmd j<cr>:wincmd l<cr> 
noremap <leader>al :A<cr>

" Path (command) to ctags
"let Tlist_Ctags_Cmd = "ctags"
"let Tlist_WinWidth = 50

" This command builds (updates) the ctags file for the SusyNt project, it can be enhanced (or split) later to account for other projects
"map <leader>tu :!ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ --exclude=.svn -f ~/.vim/ctags/SusyNt ~/SusyNt/SusyNtuple/Root/ ~/SusyNt/SusyNtuple/SusyNtuple/<cr><cr>
"set tags=~/.vim/ctags/SusyNt

" Taglist should be on the right to not interfere with NERDTree
"let Tlist_Use_Right_Window = 1

" Define paths for alternate to look for its partner files (sfr means the path is relative)
let g:alternateSearchPath = 'sfr:.,sfr:../source,sfr:../src,sfr:../include,sfr:../Root,sfr:../inc,sfr:../interface,sfr:../../src/common'

" If there is no partner file, do nothing
let g:alternateNoDefaultAlternate = 1 

" Taglist gets updated when saving
"autocmd BufWritePost * :TlistUpdate

if getcwd() =~ '/analysis/xAODNtuple$'
    set makeprg=cat\ build.out
elseif getcwd() =~ '/tracking/InDetPhysValMonitoring$'
    set makeprg=cat\ build.out
else
    set makeprg=./vim-make
endif

" make and jump to warning/error if any
"map <leader>m :make<cr>
map <leader>m :make!<cr>
" make without jump to warning/error
"map <leader>n :make!<cr>

" Omni completion
set omnifunc=syntaxcomplete#Complete
imap <leader>cp <C-X><C-O>

" Quickfix window
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Arduino
"autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino
"autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_mode_map = { 'mode': 'passive'}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" C++
let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_no_include_search = 1
"let g:syntastic_cpp_no_default_include_dirs = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" HTML
let g:syntastic_html_checkers = ['validator', 'w3']

nmap <leader>sy :SyntasticToggleMode<CR>

" Show tabs and trailing spaces
set list listchars=tab:>-,trail:·


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Sessions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Check if file exists
function! FileExists(file)
   if filereadable(a:file)
       return 1
   endif
endfunction

" Some plugins change directory. Store directory where vim was opened in a variable
let g:vimHomeDir=getcwd()

" Restore session
function! RestoreSession()
    if argc() == 0 "vim called without arguments
        if FileExists('.Session.vim')
            execute 'source .Session.vim'
        endif
   endif
endfunction

" Before writing .Session.vim, change to directory where vim was opened (to not mix up different sessions)
function! MakeSession()
    cd `=g:vimHomeDir`
    mksession! .Session.vim
endfunction

" If available, source .vimrcPrivate with some directory specific settings
if FileExists('.vimrcPrivate')
    execute 'source .vimrcPrivate'
endif

" Restore session at startup (if available), write session at end
autocmd VimEnter * call RestoreSession()
"autocmd VimLeave * call MakeSession()
nmap <leader>sn :call MakeSession()<CR>

" Store foldings
"au BufWinLeave ?* mkview
"au BufWinEnter ?* silent loadview
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

"From http://vim.1045645.n5.nabble.com/Custom-tabline-Non-gui-vim-td1190544.html
"if exists("+guioptions") 
"        set go-=a go-=e go+=tc 
"        " remove a  no autoselect to * register 
"        " remove e  always use text-style tabs 
"        " add    t  include tearoff menu items if possible 
"        " add    c  avoid popup dialogs for small choices 
"endif 

" define our text-style tabline 
" this is adapted (with some enhancements) from the example 
" at :help setting-tabline 
if exists("+showtabline") 
     function MyTabLine() 
         let s = '' 
         let t = tabpagenr() 
         let i = 1 
         while i <= tabpagenr('$') 
             let buflist = tabpagebuflist(i) 
             let winnr = tabpagewinnr(i) 
             let s .= '%' . i . 'T' 
             let s .= (i == t ? '%1*' : '%2*') 
             let s .= ' ' 
             let s .= i . ':' 
"             let s .= winnr . '/' . tabpagewinnr(i,'$') 
             let s .= ' %*' 
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#') 
             let file = bufname(buflist[winnr - 1]) 
             let file = fnamemodify(file, ':p:t') 
             if file == '' 
                 let file = '[No Name]' 
             endif 
             "let s .= file 
             let s .= (getbufvar(buflist[winnr - 1], "&mod")?'+ ':'')
             let s .= file
             let s .= (getbufvar(buflist[winnr - 1], "&mod")?' +':'')
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%=' 
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X') 
         return s 
     endfunction 
     set stal=2 
     set tabline=%!MyTabLine() 
"   map     <F10>    :tabnext<CR> 
"   map!    <F10>    <C-O>:tabnext<CR> 
"   map     <S-F10>  :tabprev<CR> 
"   map!    <S-F10>  <C-O>:tabprev<CR> 
endif 

