scriptencoding utf-8
set encoding=utf-8

set shell=fish
set nocompatible
set number
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list
set relativenumber
set wildignore+=node_modules/**,dist/**
set splitright
set splitbelow
set autoread
set colorcolumn=80
set shiftwidth=2
set smartindent
set clipboard=unnamed " Use system clipboard
set laststatus=2
set noshowmode
set updatetime=250
set timeoutlen=1000
set ttimeoutlen=0
set backspace=indent,eol,start
set completeopt=menu,menuone,preview,noselect,noinsert
set diffopt+=iwhite

if has('mouse')
  set mouse=a
endif

if has('mouse_sgr')
  set ttymouse=sgr
endif

let g:netrw_liststyle = 3 " Tree view
let g:netrw_sort_sequence = '[\/]$,*' " Show directories first
let g:netrw_browse_split = 4 " Use the previous window for the new file
let g:netrw_winsize = -28 " Absolute width of the netrw window
let g:netrw_banner = 0 " Disable the banner

let g:ackprg = 'rg --files --hidden --follow --glob "!{.git,node_modules}/*"' " Use RipGrep to search

silent! syntax enable
filetype plugin on
filetype plugin indent on

" Mappings
let mapleader = "\<Space>"

" Keys in all modes
map <C-P> :FZF<CR>
map <C-n> :Lexplore<CR>

" Keys in normal mode
nmap <leader>n :cnext<CR>
nmap <leader>N :cprev<CR>
nmap <leader>c :tabedit \| term ++curwin<CR>
nmap <leader>x :bd!<CR>
nmap <leader>q :q<CR>
nmap <leader><ESC> :noh<CR>
nmap gd :ALEGoToDefinition<CR>
nmap gN :ALERename<CR>

" Replace mappings for keys in normal mode
nnoremap <C-T> :Buffers<CR>
nnoremap <leader>\| :vsp \| term ++curwin<CR>
nnoremap <leader>- :sp \| term ++curwin<CR>
nnoremap <leader><CR> :call <End> <SID>SyntaxFold('zA')<CR>
noremap \\ :call NERDComment(0,"toggle")<CR>
noremap ; :Commands<CR>

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

autocmd CursorHold * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

autocmd BufWritePost * GitGutter

" Linting
let g:ale_fixers = {
      \   'javascript': ['eslint', 'remove_trailing_lines'],
      \   'json': ['prettier'],
      \}

let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint', 'tsserver'],
    \ 'typescriptreact': ['eslint', 'tsserver'],
    \}

let g:ale_sign_error = '😰'
let g:ale_sign_warning = '😕'
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_fix_on_save = 1
set omnifunc=ale#completion#OmniFunc

" Statusline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction"

" Theming
silent! colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE
hi Visual term=reverse cterm=reverse guibg=NONE ctermbg=NONE
