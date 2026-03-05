" ============================================================
"  _   _ ___ __  __   _____           _            _     _
" | | | |_ _|  \/  | | ____|_ __ ___ | |__   ___  | |   | |
" | | | || || |\/| | |  _| | '_ ` _ \| '_ \ / _ \ | |   | |
" | |_| || || |  | | | |___| | | | | | |_) |  __/ | |___| |___
"  \___/|___|_|  |_| |_____|_| |_| |_|_.__/ \___| |_____|_____|
"
"  VIM — Sistemas Embarcados (Arch Linux)
"  Suporte: C/C++, Assembly, Makefiles, Device Tree, OpenOCD,
"           GDB, UART/Serial, CMSIS, FreeRTOS, Zephyr, etc.
" ============================================================

" ------------------------------------------------------------
" GERAL
" ------------------------------------------------------------
set nocompatible
filetype plugin indent on
syntax enable

set encoding=utf-8
set fileformats=unix,dos
set hidden
set autoread
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir

" Diretório padrão de trabalho
autocmd VimEnter * cd /home/luiz/Área\ de\ trabalho/Projetos

" ------------------------------------------------------------
" INTERFACE
" ------------------------------------------------------------
set number
set relativenumber
set cursorline
set colorcolumn=80,120
set ruler
set showcmd
set showmatch
set laststatus=2
set scrolloff=8
set sidescrolloff=5
set signcolumn=yes
set wildmenu
set wildmode=longest:full,full

" ------------------------------------------------------------
" INDENTAÇÃO
" ------------------------------------------------------------
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set cindent

autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4

" ------------------------------------------------------------
" BUSCA
" ------------------------------------------------------------
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <silent> <Esc> :nohlsearch<CR>

" ------------------------------------------------------------
" CLIPBOARD & MOUSE
" ------------------------------------------------------------
set clipboard=unnamedplus
set mouse=a

" ------------------------------------------------------------
" CORES / TEMA
" ------------------------------------------------------------
set termguicolors
set background=dark
colorscheme desert              " Fallback; gruvbox ativo após :PlugInstall

" ============================================================
"  LEADER
" ============================================================
let mapleader = " "

" ============================================================
"  NAVEGAÇÃO DE JANELAS — Ctrl + W/A/S/D
" ============================================================
nnoremap <C-w> <C-w>k
nnoremap <C-s> <C-w>j
nnoremap <C-a> <C-w>h
nnoremap <C-d> <C-w>l

inoremap <C-w> <Esc><C-w>k
inoremap <C-s> <Esc><C-w>j
inoremap <C-a> <Esc><C-w>h
inoremap <C-d> <Esc><C-w>l

" Redimensionar janelas com Alt+setas
nnoremap <M-Up>    :resize +2<CR>
nnoremap <M-Down>  :resize -2<CR>
nnoremap <M-Left>  :vertical resize -2<CR>
nnoremap <M-Right> :vertical resize +2<CR>

" Splits
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>

" ------------------------------------------------------------
" BUFFERS
" ------------------------------------------------------------
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bl :buffers<CR>

" ------------------------------------------------------------
" SALVAR / FECHAR
" ------------------------------------------------------------
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" ============================================================
"  TERMINAL INTEGRADO — Ctrl+J toggle
" ============================================================
let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call term_start($SHELL, {"curwin": 1, "term_finish": "close"})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <C-j> :call TermToggle(12)<CR>
inoremap <C-j> <Esc>:call TermToggle(12)<CR>
tnoremap <C-j> <C-\><C-n>:call TermToggle(12)<CR>

" Sair do modo terminal com Esc
tnoremap <Esc> <C-\><C-n>

" Navegar janelas estando no terminal
tnoremap <C-w> <C-\><C-n><C-w>k
tnoremap <C-s> <C-\><C-n><C-w>j
tnoremap <C-a> <C-\><C-n><C-w>h
tnoremap <C-d> <C-\><C-n><C-w>l

" ============================================================
"  EXPLORADOR DE ARQUIVOS — NERDTree
" ============================================================
let g:NERDTreeRootDir        = '/home/luiz/Área de trabalho/Projetos'
let NERDTreeShowHidden        = 1
let NERDTreeMinimalUI         = 1
let NERDTreeDirArrows         = 1
let NERDTreeShowLineNumbers   = 0
let NERDTreeAutoDeleteBuffer  = 1
let NERDTreeWinSize           = 30
let NERDTreeIgnore = [
  \ '\.o$', '\.elf$', '\.bin$', '\.hex$',
  \ '\.d$', '\.a$', '\.map$', '\.lst$',
  \ 'build$[[dir]]', '\.git$[[dir]]',
  \ '__pycache__[[dir]]', '\.pyc$'
  \ ]

nnoremap <leader>e  :NERDTreeToggle<CR>
nnoremap <leader>ef :NERDTreeFind<CR>

" Fecha VIM se NERDTree for a última janela
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree")
  \ && b:NERDTree.isTabTree()) | q | endif

" ============================================================
"  GIT — Visualização e Operações
" ============================================================

" ----- vim-gitgutter -----
let g:gitgutter_enabled               = 1
let g:gitgutter_realtime              = 1
let g:gitgutter_eager                 = 1
let g:gitgutter_sign_added            = '▎'
let g:gitgutter_sign_modified         = '▎'
let g:gitgutter_sign_removed          = '▾'
let g:gitgutter_sign_modified_removed = '▸'

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)

" ----- vim-fugitive -----
nnoremap <leader>gs  :Git<CR>
nnoremap <leader>gd  :Gdiffsplit<CR>
nnoremap <leader>gl  :0Gclog<CR>
nnoremap <leader>gb  :Git blame<CR>
nnoremap <leader>gc  :Git commit<CR>
nnoremap <leader>ga  :Git commit --amend<CR>
nnoremap <leader>gp  :Git push<CR>
nnoremap <leader>gP  :Git pull<CR>
nnoremap <leader>gf  :Git fetch<CR>
nnoremap <leader>gm  :Git merge<CR>
nnoremap <leader>gco :Git checkout<Space>

" Branch atual na statusline
set statusline=%<%f\ %h%m%r%{exists('*FugitiveStatusline')?FugitiveStatusline():''}%=%-14.(%l,%c%V%)\ %P

" Resolver conflitos de merge
nnoremap <leader>gdt :diffget //2<CR>
nnoremap <leader>gdm :diffget //3<CR>

" ----- vim-flog (grafo visual) -----
nnoremap <leader>gG  :Flog<CR>
nnoremap <leader>gFf :Flog -path=%<CR>

" ----- GV (log visual simples) -----
nnoremap <leader>gv  :GV<CR>
nnoremap <leader>gvf :GV!<CR>

" ============================================================
"  BUILD & MAKE
" ============================================================
nnoremap <leader>m  :make<CR>
nnoremap <leader>mc :make clean<CR>
nnoremap <leader>mf :make flash<CR>
nnoremap <leader>md :make debug<CR>

nnoremap <leader>co :copen<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
nnoremap <leader>cc :cclose<CR>

if filereadable("build/Makefile")
    set makeprg=make\ -C\ build\ -j$(nproc)
elseif filereadable("CMakeLists.txt")
    set makeprg=cmake\ --build\ build\ --parallel
else
    set makeprg=make\ -j$(nproc)
endif

set errorformat=%f:%l:%c:\ %t%*[^:]:\ %m
set errorformat+=%f:%l:\ %t%*[^:]:\ %m

" ============================================================
"  DEPURAÇÃO / SERIAL
" ============================================================
nnoremap <leader>og :vsplit \| terminal arm-none-eabi-gdb -q -ex "target remote :3333" %:r.elf<CR>
nnoremap <leader>oo :vsplit \| terminal openocd -f interface/stlink.cfg -f target/stm32f4x.cfg<CR>
nnoremap <leader>sc :vsplit \| terminal picocom -b 115200 /dev/ttyUSB0<CR>
nnoremap <leader>sm :vsplit \| terminal minicom -D /dev/ttyUSB0 -b 115200<CR>

" ============================================================
"  TIPOS DE ARQUIVO — Embarcados
" ============================================================
autocmd BufRead,BufNewFile *.dts,*.dtsi  set filetype=dts
autocmd BufRead,BufNewFile *.ld,*.lds    set filetype=ld
autocmd BufRead,BufNewFile *.cfg         set filetype=tcl
autocmd BufRead,BufNewFile *.s,*.S,*.asm set filetype=asm
autocmd BufRead,BufNewFile Kconfig*      set filetype=kconfig

" ============================================================
"  C/C++ — Embarcados
" ============================================================
augroup embedded_c
    autocmd!
    autocmd FileType c,cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType c,cpp setlocal path+=/usr/arm-none-eabi/include
    autocmd FileType c,cpp setlocal path+=./include,./Inc,./Core/Inc,./Drivers/**
    autocmd FileType c,cpp setlocal foldmethod=syntax foldlevel=99
    autocmd FileType c,cpp syn keyword cType uint8_t uint16_t uint32_t uint64_t
    autocmd FileType c,cpp syn keyword cType int8_t int16_t int32_t int64_t
    autocmd FileType c,cpp syn keyword cType size_t ssize_t uintptr_t ptrdiff_t
    autocmd FileType c,cpp syn keyword cStorageClass volatile register
    autocmd FileType c,cpp syn keyword cStatement __attribute__ __asm__ __volatile__
augroup END

nnoremap <leader>cf :!clang-format -i %<CR>:edit<CR>
vnoremap <leader>cf :!clang-format<CR>

" ============================================================
"  COMPLETAR
" ============================================================
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,noinsert,noselect
set shortmess+=c
inoremap <C-Space> <C-x><C-o>

set tags=./tags,tags;/
nnoremap <leader>ct :!ctags -R --c-kinds=+p --fields=+iaS --extras=+q .<CR>

if has("cscope")
    set cscopetag
    set csto=0
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    nnoremap <leader>cs  :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <leader>cd  :cs find d <C-R>=expand("<cword>")<CR><CR>
    nnoremap <leader>ccf :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <leader>cff :cs find f <C-R>=expand("<cfile>")<CR><CR>
endif

" ============================================================
"  PLUGINS — vim-plug
"
"  Instalar o gerenciador:
"    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"  Dependências no Arch:
"    sudo pacman -S arm-none-eabi-gcc arm-none-eabi-gdb clang \
"                   ctags cscope picocom git nodejs npm
"    yay -S nerd-fonts-jetbrains-mono   (ícones NERDTree)
"
"  Ativar tudo:  vim +PlugInstall +qall
" ============================================================
call plug#begin('~/.vim/plugged')

" Tema
Plug 'morhetz/gruvbox'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Explorador de arquivos
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'     " Status git na árvore
Plug 'ryanoasis/vim-devicons'           " Ícones (requer Nerd Font)

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " :CocInstall coc-clangd

" Git
Plug 'tpope/vim-fugitive'              " Operações git completas
Plug 'airblade/vim-gitgutter'          " Diff em tempo real no gutter
Plug 'rbong/vim-flog'                  " Grafo visual do histórico
Plug 'junegunn/gv.vim'                 " Log visual simples (:GV)

" Edição
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" Embarcados
Plug 'ARM9/arm-syntax-vim'
Plug 'vim-scripts/ld.vim'

call plug#end()

" ============================================================
"  CONFIGURAÇÕES PÓS-PLUGINS
" ============================================================

" Gruvbox
let g:gruvbox_contrast_dark = 'hard'
silent! colorscheme gruvbox

" Airline
let g:airline_powerline_fonts                 = 1
let g:airline#extensions#coc#enabled         = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#gitgutter#enabled   = 1
let g:airline_theme                           = 'gruvbox'
let g:airline_section_b                       = '%{FugitiveHead()}'

" Devicons
let g:webdevicons_enable_nerdtree = 1

" NERDTree git status — ícones por estado
let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Deleted'   : '✖',
  \ 'Dirty'     : '✗',
  \ 'Clean'     : '✔',
  \ 'Ignored'   : '☒',
  \ 'Unknown'   : '?'
  \ }
let g:NERDTreeGitStatusShowIgnored = 1

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers      = ['Makefile', 'CMakeLists.txt', '.git']
let g:ctrlp_custom_ignore     = {
  \ 'dir':  '\v[\/](build|\.git|\.svn)$',
  \ 'file': '\v\.(o|elf|bin|hex|d|a|map|lst)$'
  \ }

" CoC — clangd
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> K  :call CocActionAsync('doHover')<CR>
nmap <leader>rn  <Plug>(coc-rename)
nmap <leader>ca  <Plug>(coc-codeaction)

" ============================================================
"  UTILITÁRIOS FINAIS
" ============================================================
nnoremap <leader>sr :source $MYVIMRC<CR>

set list
set listchars=tab:→\ ,trail:·,nbsp:␣

autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p", 0700)
endif

autocmd BufWritePre * if &ft !=# 'make' | %s/\s\+$//e | endif

" ============================================================
"  MAPA DE ATALHOS RÁPIDOS
" ============================================================
"
"  JANELAS
"  Ctrl+W/S/A/D      → cima / baixo / esquerda / direita
"  Alt+Setas         → redimensionar janela ativa
"  <leader>sv / sh   → split vertical / horizontal
"
"  TERMINAL
"  Ctrl+J            → abrir / fechar terminal (toggle)
"  Esc ou Ctrl+J     → sair do modo terminal de volta ao editor
"
"  EXPLORADOR (NERDTree)
"  <leader>e         → toggle árvore lateral
"  <leader>ef        → focar arquivo atual na árvore
"
"  GIT
"  <leader>gs        → status interativo (fugitive)
"  <leader>gd        → diff do arquivo atual (split)
"  <leader>gb        → git blame linha a linha
"  <leader>gl        → log do arquivo atual
"  <leader>gc / ga   → commit / commit --amend
"  <leader>gp / gP   → push / pull
"  <leader>gf        → fetch
"  <leader>gG        → grafo visual completo (Flog)
"  <leader>gv        → log visual (GV — todos os commits)
"  <leader>gvf       → log visual do arquivo atual (GV!)
"  ]h / [h           → próximo / anterior hunk (gitgutter)
"  <leader>hs        → stage hunk
"  <leader>hu        → undo hunk
"  <leader>hp        → preview hunk (diff inline)
"
"  BUILD
"  <leader>m         → make
"  <leader>mc / mf / md → clean / flash / debug
"
"  DEPURAÇÃO
"  <leader>oo        → OpenOCD
"  <leader>og        → GDB remoto (porta 3333)
"  <leader>sc / sm   → picocom / minicom serial
"
" ============================================================
