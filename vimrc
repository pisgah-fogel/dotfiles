set mouse=r " 
set history=500

" filetype plugins
filetype plugin on
filetype indent on

" use ,w to save
let mapleader = ","
nmap <leader>w :w!<cr>

" :W to save the file as sudo
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

set so=7 " set 7 lines to the cursor when moving with j/k

set wildmenu " turn the wildmenu

" Ignore some files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Height of the command bar
set cmdheight=1

" Ignore case when searching
"set ignorecase
" When searching try to be smart about cases 
"set smartcase

" Highlight search results
set hlsearch

" turn magic for regular expression
set magic

"Enable syntax highlighting
syntax enable 

"Enable 256 color palette
if $COLORTERM == 'truecolor'
    set t_Co=256
endif

" Set theme
"colorscheme desert
colorscheme industry
"set background=dark

set fileencoding=utf8
set encoding=utf8
set bomb

" Turn off backup
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
"set expandtab

" Be smart when using tabs
set smarttab

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
"set wrap "Wrap lines

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
"vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
"vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
" Close all the buffers
map <leader>ba :bufdo bd<cr>
" Move around buffer
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
" Opens a new tab with the current buffer's path
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/
map <leader>tn :tabnew<cr>
map <S-Tab> :tabnext<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>tt :tab terminal<cr>
map <leader>t<leader> :tabnext<cr> 
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
" terminal mode mappings
tnoremap <S-Tab> <C-W>:tabnext<CR>
" Stop forwarding the keystrokes (a or i to go back to bash / sh / shell)
tnoremap <C-N>   <C-W>N

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Delete trailing spaces on saving
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Shows white spaces
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:×
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" To use it
"set list

" Render all spaces in red
"set syntax=whitespace

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Add symtax for verilog
au BufNewFile,BufRead *.sv,*.v so ~/.vim/verilog.vim

" Avoid UTF-8 problem
set nobomb
