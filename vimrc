"-- initial setup
set nocompatible             " vim, not vi
" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
"behave mswin

filetype off
" filetype is enabled in the next section


"-- bundle related stuff (for plugins)
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'FormatBlock'
Bundle 'scrooloose/nerdtree'
Bundle 'Valloric/YouCompleteMe'
Bundle 'matchit.zip'
Bundle 'IndexedSearch'
Bundle 'jdschw/filetype_overrides'
Bundle 'FormatComment.vim'
Bundle 'jdschw/SimpylFold'
" Bundle 'L9'
" Bundle 'FuzzyFinder'

" YCM options
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_min_num_of_chars_for_completion = 3

"-- Set some filetype defaults
set viewoptions-=options
augroup filetype_defaults
  au!
  au BufNewFile,BufRead *.ahk setf ahk
  au BufNewFile,BufRead *.otgm set filetype=matlab
augroup END

"-- operational settings
filetype indent plugin on     " Enable filetype detection, indenting, plugins

"compiler ruby                 " Enable compiler support for ruby
syntax on
"set lines=50 columns=100      " sets the initial size of the gvim window
set undofile                    " keep backups ...
set undodir=~/.backup//,/var/tmp//,/tmp//,.
set backup                    " keep backups ...
set backupdir=~/.backup//,/var/tmp//,/tmp//,.
                              " ...but in a different, dedicated directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.  " Same with swap files.
set mouse=nvi                 " allows the mouse to move the cursor in vim
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
set hidden                    " permits hidden buffers
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode                  " Shows the current mode on the command bar
set showcmd
set autoindent smartindent    " auto/smart indent
set expandtab                 " expand tabs to spaces
set smarttab                  " tab and backspace are smart
set tabstop=2
set shiftwidth=2
set ignorecase                " searches will be case insensitive
set smartcase                 " searches with Capital Letters will override
                              " the above option and be case-sensitive
setglobal scrolloff=5         " keep at least 5 lines above/below
setglobal sidescrolloff=5     " keep at least 5 lines left/right
setglobal sidescroll=2        " when word wrap is off, scroll sideways by
                              " 2 lines at a time
set backspace=indent,eol,start
set showfulltag               " show full completion tags
set noerrorbells              " no error bells please
set report=0                  " show number of substitutions when > 0 (i.e. always)
set linebreak                 " when wrap is on, only wrap at reasonable characters
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " save every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
"set wildmode=list:longest
"set wildmode=longest:full
set wildmode=full
set   listchars=tab:>-,trail:- " show tabs and trailing spaces

set switchbuf=usetab          " when using :sb, if a tab with the given buffer
                              " is already open, sb will switch to it
set wildignore+=*.o,*~,.lo    " ignore object files
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
let mapleader=','             " all my macros start with ,
set fillchars=vert:\|,fold:\  " get rid of the annoying dashes after fold text
set foldcolumn=2              " 2 lines of column for fold showing, always
" set modelines=0               " modelines have security exploits
set pastetoggle=<F11>
set textwidth=79              " sets the textwidth, used for formatting
set colorcolumn=+1,+2,+3      " colors the column past the textwidth as
                              " a visual 'warning track'
set nowrap                    " prevents textwrapping
set fo=cqrn1                  " format options.  type :help fo-table for more info.
set hlsearch                  " highlight search results
set showmatch                 " when typing a brace or parens, show the matching brace/parens
set incsearch                 " show search results as you type
set number                    " show the line number
"set relativenumber            " makes the line number relative to the current line
set guifont=Monospace\ 9

"-- autocommands for various things
augroup vimrc_autocmds
  au!
  au ColorScheme * highlight ExtraWhitespace ctermbg=darkgrey guibg=#294929
  au BufEnter,FocusGained * :setlocal relativenumber " makes the line number relative to the current line
  au BufWinEnter * match ExtraWhitespace /\s\+$/
  au BufLeave,FocusLost * :setlocal norelativenumber
  au InsertEnter * :setlocal norelativenumber
  au InsertLeave * :setlocal relativenumber
  "autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  "autocmd BufEnter * match OverLength /\%80v.*/
augroup END

"-- subtle remapping of basic keys
" Y yanks from cursor to $
nnoremap Y y$
" for yankring to work with previous mapping:
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction
" make j and k move by screen line instead of file line.
nnoremap j gj
nnoremap k gk
" turn the 'help' key into another escape key.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" allow the semicolon ';' key to start commands in normal mode
nnoremap ; :
" allow a faster way to get back into normal mode
inoremap jj <ESC>
" Lets you search for text selected in visual mode using the word search keys
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"-- Neat operator-pending mappings
" easier way to operate inside parens
:onoremap p i(
" easier way to operate inside quotes
:onoremap q i"

"-- tabs
" (Leader is ",")
" create a new tab
nnoremap <Leader>tc :tabnew
" close a tab
nnoremap <Leader>td :tabclose<cr>
" next tab
nnoremap <Leader>tn :tabnext<cr>
" next tab
nnoremap <A-n> :tabnext<cr>
" previous tab
nnoremap <Leader>tp :tabprev<cr>
" previous tab
nnoremap <A-p> :tabprev<cr>
" move a tab to a new location
nnoremap <Leader>tm :tabmove

"-- buffers
" open all buffers into their own tabs
" nnoremap <Leader>bt :tab sball<cr>
" list buffers and prepare to open a buffer
nnoremap <Leader>b :buffers<cr>:b<space>
nnoremap <Leader>bb :buffers<cr>:b<space>
nnoremap <Leader>B :buffers<cr>:b<space>
" list buffers and prepare to open a buffer or edit a new file
nnoremap <Leader>be :buffers<cr>:e<space>#
nnoremap <Leader>bs :buffers<cr>:vert rightbelow sbuffer<space>
" list buffers and prepare to delete a buffer
" nnoremap <Leader>bd :buffers<cr>:bdelete<space>
com! DeleteCurrentBuffer execute "bp|bd #"
nnoremap <Leader>bd :DeleteCurrentBuffer<cr>
nnoremap <Leader>bD :buffers<cr>:bdelete<space>

"-- splits
" allows for fast opening of the gvimrc into a split
nnoremap <leader>sv :rightbelow vsplit<cr>:e ~/.vimrc<cr>
nnoremap <leader>ev :e ~/.vimrc<cr>

" create a vertical split and move into it
nnoremap <leader>sj :rightbelow split<cr>
nnoremap <leader>sk :leftabove split<cr>
" create a horizontal split and move into it
nnoremap <leader>sh :leftabove vsplit<cr>
nnoremap <leader>sl :rightbelow vsplit<cr>
" same as above commands, but new split spans the whole window.
nnoremap <leader>swj :botright split<cr>
nnoremap <leader>swk :topleft split<cr>
nnoremap <leader>swh :topleft vsplit<cr>
nnoremap <leader>swl :botright vsplit<cr>
" moving around sdlits using ctrl + standard keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"-- Changing the size of the gvim window
nnoremap <Leader>ww :set columns=300<cr>:set lines=82<cr>
nnoremap <Leader>wl :set columns=180<cr>
nnoremap <Leader>wh :set columns=100<cr>
nnoremap <Leader>wk :set lines=25<cr>
nnoremap <Leader>wj :set lines=50<cr>

"-- Changing the size of the current split
nnoremap <S-Left> <C-W>5<
nnoremap <S-Right> <C-W>5>
nnoremap <S-Down> <C-W>5-
nnoremap <S-Up> <C-W>5+
nnoremap <F9> <C-W>=
nnoremap <F8> :resize<cr>:vertical resize<cr>

"-- comments
function! CommentMyLine()
  s/^/%\ /e
endfunction
function! UncommentMyLine()
  s/^%\ //e
endfunction

nnoremap <Leader>c :call CommentMyLine()<cr><cr>
nnoremap <Leader>x :call UncommentMyLine()<cr><cr>
vnoremap <Leader>c :call CommentMyLine()<cr><cr>
vnoremap <Leader>x :call UncommentMyLine()<cr><cr>

"-- ctags
nnoremap <Leader>tt :!ctags -R .<cr>
" open the new tag in a vertical split
nnoremap <C-\> :belowright vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" open the new tag in a horizontal split
nnoremap <C-M-\> :belowright sp <CR>:exec("tag ".expand("<cword>"))<CR>

"-- run a shell command and see the output in a new buffer
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright 10new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell

" make specific projects and put the results into a buffer
nnoremap <leader>mz :Shell make -C ~/src/ng_gv_3d/src/fake_zbox/build --no-print-directory<cr>
nnoremap <leader>mf :Shell make -C ~/src/ng_gv_3d/src/pt_cloud_fusion/build --no-print-directory<cr>
nnoremap <leader>mv :Shell make -C ~/src/ng_gv_3d/src/fake_viz/build --no-print-directory<cr>
nnoremap <leader>ms :Shell make -C ~/src/ng_gv_3d/src/stereo_vision --no-print-directory<cr>

"-- folding
" map <Leader>z zf/%%<cr>j
noremap <C-n> zj
noremap <C-m> zk
noremap <Leader>z4 :set foldnestmax=4<cr>
noremap <Leader>z3 :set foldnestmax=3<cr>
noremap <Leader>z2 :set foldnestmax=2<cr>
noremap <Leader>z1 :set foldnestmax=1<cr>

" Experimenting with a different format for fold text
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%5s", lines_count) . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

"-- colorscheme & formatting
" This colorscheme is easy on the eyes, plus I prefer to set an inconspicuous
" color for the warning track
colorscheme marklar
highlight ColorColumn guibg=#06443a
highlight ColorColumn ctermbg=darkgrey
" handy shortcut for formatting a paragraph in normal mode
nnoremap <Leader>q :call FormatComment()<CR>
" handy shortcuts for converting a word to uppercase
nnoremap <Leader>~ gUawe
inoremap <F2> <ESC>bgUawea
nnoremap <Leader>` guawe
" same as above in visual mode
vnoremap Q gq
" formatting the whole document
nnoremap <Leader>QQ gggqG
" turn on the cursorline highlighting
nnoremap <Leader>vc :set cursorcolumn!<cr>
" remove all paragraph carriage returns in document, i.e. format to paste to
" word or wordpad.  Note that I assume your default textwidth is 79.
nnoremap <Leader>QZ :set textwidth=1000000<cr>gggqG:set textwidth=79<cr>
" a shortcut to remove highlighting from a search.
nnoremap <Leader><Space> :noh<cr>
" eliminate all trailing whitespace from a file
function! ElimTrailingWhitespace()
  silent! %s/\s\+$//
endfunction
nnoremap <Leader>QS :call ElimTrailingWhitespace()<cr>:w<cr>

function! g:ToggleNuMode()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

map <leader>vn :call g:ToggleNuMode()<CR>


"-- misc useful mappings
" source the vimrc file
nnoremap <leader>S :source ~/.vimrc<cr>
" save and build
nnoremap <Leader>wm :w<cr>:make<cr>
" ,nn will toggle NERDTree on and off
nnoremap <Leader>nn :NERDTreeToggle<cr>
" add a semicolon at the end of the line I'm on
com! AddSemicolon execute "normal! mqA;\<Esc>`q"
nnoremap <Leader>; :AddSemicolon<cr>
" swap the two sides of an assignment call, leave the semicolon alone
nnoremap <Leader>es :s/\v(\S+) \= (\S*);@=/\2 = \1/<cr>:noh<cr>
" spread a conditional expression onto four lines (for C++)
nnoremap <Leader>ec :s/^\(\s*\)\(.*\) { \(.*\) }.*$/\1\2\r\1{\r\1  \3\r\1}/<cr>:noh<cr>

"-- abbreviations
" some F6-specific keywords that are handy to speed up typing.
iabbrev f6 F6
iabbrev fdk FDK
iabbrev ngas NGAS



