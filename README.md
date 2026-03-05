# VIM para Sistemas Embarcados — Arch Linux

Configuração de VIM focada em desenvolvimento embarcado com C/C++, Assembly ARM,
Makefiles, OpenOCD e GDB remoto. Inclui explorador de arquivos, terminal integrado
e LSP via clangd.

---

## Instalação rápida

```bash
# Dependências
sudo pacman -S vim arm-none-eabi-gcc arm-none-eabi-gdb \
               clang ctags cscope picocom nodejs npm
yay -S ttf-jetbrains-mono-nerd   # necessário para os icones do NERDTree

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copiar config e instalar plugins
cp .vimrc ~/.vimrc
vim +PlugInstall +qall

# Ativar LSP (dentro do VIM)
:CocInstall coc-clangd
```

A pasta padrão ao abrir o VIM é `/home/luiz/Área de trabalho/Projetos`.
Para mudar, edite a linha abaixo no `.vimrc`:

```vim
autocmd VimEnter * cd /home/luiz/Área\ de\ trabalho/Projetos
```

---

## Atalhos

### Janelas

| Atalho | Ação |
|---|---|
| `Ctrl+W` | Foca janela acima |
| `Ctrl+S` | Foca janela abaixo |
| `Ctrl+A` | Foca janela à esquerda |
| `Ctrl+D` | Foca janela à direita |
| `Alt+Setas` | Redimensiona a janela ativa |
| `Space sv` | Split vertical |
| `Space sh` | Split horizontal |

Esses atalhos funcionam nos modos normal, insert e dentro do terminal.

### Terminal

| Atalho | Ação |
|---|---|
| `Ctrl+J` | Abre / fecha o terminal (toggle) |
| `Esc` ou `Ctrl+J` dentro do terminal | Volta ao editor |

O terminal abre como split horizontal na parte inferior e persiste entre aberturas.

### Explorador de arquivos (NERDTree)

| Atalho | Ação |
|---|---|
| `Space e` | Abre / fecha a árvore lateral |
| `Space ef` | Revela o arquivo atual na árvore |

Dentro da árvore: `o` abre, `s` abre em split vertical, `i` em split horizontal,
`m` abre o menu de operações (criar, renomear, deletar).

### Build e embarcados

| Atalho | Ação |
|---|---|
| `Space m` | `make` |
| `Space mc` | `make clean` |
| `Space mf` | `make flash` |
| `Space md` | `make debug` |
| `Space co` | Abre quickfix (erros de compilação) |
| `Space cn / cp` | Próximo / anterior erro no quickfix |
| `Space oo` | Abre OpenOCD (STLink + STM32F4) |
| `Space og` | GDB remoto conectado na porta 3333 |
| `Space sc` | Monitor serial com picocom (115200) |
| `Space sm` | Monitor serial com minicom (115200) |

### LSP (clangd via CoC)

| Atalho | Ação |
|---|---|
| `gd` | Ir para definição |
| `gr` | Ver referências |
| `gi` | Ir para implementação |
| `K` | Documentação hover |
| `Space rn` | Renomear símbolo |
| `Space ca` | Code action |

### ctags / cscope

| Atalho | Ação |
|---|---|
| `Space ct` | Gerar ctags do projeto |
| `Ctrl+]` | Ir para definição (ctags) |
| `Ctrl+T` | Voltar |
| `Space cs` | Buscar símbolo (cscope) |
| `Space cd` | Buscar definição (cscope) |

---

## Plugins incluídos

| Plugin | Função |
|---|---|
| morhetz/gruvbox | Tema |
| vim-airline | Statusline |
| preservim/nerdtree | Explorador de arquivos lateral |
| vim-devicons | Icones por tipo de arquivo (requer Nerd Font) |
| ctrlpvim/ctrlp.vim | Fuzzy finder de arquivos |
| neoclide/coc.nvim | LSP (autocompletar, definição, hover) |
| tpope/vim-surround | Manipular delimitadores |
| tpope/vim-commentary | Comentar com `gc` |
| jiangmiao/auto-pairs | Fecha parênteses e colchetes automaticamente |
| ARM9/arm-syntax-vim | Syntax highlight para Assembly ARM |
| vim-scripts/ld.vim | Syntax highlight para Linker Scripts |

---

## Personalizações comuns

### Trocar a porta serial padrão

Procure por `/dev/ttyUSB0` e substitua pela sua porta:

```vim
nnoremap <leader>sc :vsplit \| terminal picocom -b 115200 /dev/ttyACM0<CR>
```

### Trocar o baud rate

```vim
nnoremap <leader>sc :vsplit \| terminal picocom -b 9600 /dev/ttyUSB0<CR>
```

### Trocar o alvo do OpenOCD

```vim
nnoremap <leader>oo :vsplit \| terminal openocd -f interface/jlink.cfg -f target/stm32l4x.cfg<CR>
```

### Alterar o tamanho do terminal integrado

O número `12` define a altura em linhas:

```vim
nnoremap <C-j> :call TermToggle(12)<CR>
```

### Alterar o tema

```vim
let g:gruvbox_contrast_dark = 'medium'   " soft / medium / hard
silent! colorscheme gruvbox
```

### Usar apenas ctags sem LSP

Comente o plugin CoC e rode `:PlugClean`:

```vim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

### Adicionar um novo tipo de arquivo

```vim
autocmd BufRead,BufNewFile *.ext set filetype=nome
```

### Desativar números relativos

```vim
set norelativenumber
```

---

## Requisitos

- VIM 8.1+ com suporte a `+terminal` — verifique com `vim --version | grep terminal`
- Node.js 14+ para o CoC/clangd
- Nerd Font configurada no terminal para os icones do NERDTree e Airline
- `arm-none-eabi-gcc` e `arm-none-eabi-gdb` da toolchain ARM
l
