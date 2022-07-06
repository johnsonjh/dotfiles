" vim: set ts=2 sw=2 tw=78 et :

filetype on
filetype indent on
filetype plugin on
syntax on

set nocp
set t_ut=
if has('nvim')
  set termguicolors
endif
set autoindent
set background=dark
set conceallevel=0
set foldlevel=9999
set hlsearch
set modeline
set noexpandtab
set nofoldenable
set number
set ruler
set shiftwidth=4
set showcmd
set smartcase
set tabstop=4

let c_space_errors = 1
let g:ale_enabled = 0
let g:CCTreeDisplayMode = 1
let g:CCTreeEnhancedSymbolProcessing = 1
let g:CCTreeUseUTF8Symbols = 1
let g:codedark_italics = 1
let g:deoplete#enable_at_startup = 0
let g:enfocado_style = 'neon'
let g:enfocado_plugins = [
  \   'ale',
  \   'fzf',
  \   'gitgutter',
  \   'nerdtree',
  \   'netrw',
  \   'plug',
  \ ]
let g:gitgutter_enabled = 0
let g:Gtags_No_Auto_Jump = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:jellybeans_overrides = {
  \   'background': {
  \     'guibg': '000000'
  \   },
  \ }
let g:jellybeans_use_term_italics = 1
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }
let g:pandoc#after#modules#enabled = [
  \   "ultisnips"
  \ ]
let g:rehash256 = 1
let g:UltiSnipsEditSplit = "vertical"
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1

call plug#begin()
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', {
       \   'do': ':UpdateRemotePlugins'
       \ }
    Plug 'https://github.com/folke/todo-comments.nvim'
  else
"   Plug 'https://github.com/roxma/nvim-yarp'
"   Plug 'https://github.com/roxma/vim-hug-neovim-rpc'
"   Plug 'https://github.com/Shougo/deoplete.nvim'
  endif
  Plug 'https://github.com/airblade/vim-gitgutter'
  Plug 'https://github.com/ctrlpvim/ctrlp.vim'
  Plug 'https://github.com/dense-analysis/ale'
  Plug 'https://github.com/direnv/direnv.vim'
  Plug 'https://github.com/godlygeek/tabular'
  Plug 'https://github.com/habamax/vim-asciidoctor'
  Plug 'https://github.com/hari-rangarajan/CCTree'
  Plug 'https://github.com/honza/vim-snippets'
  Plug 'https://github.com/jremmen/vim-ripgrep'
  Plug 'https://github.com/junegunn/gv.vim'
  Plug 'https://github.com/junegunn/vim-easy-align'
  Plug 'https://github.com/mhinz/vim-janah'
  Plug 'https://github.com/mhinz/vim-startify'
  Plug 'https://github.com/nanotech/jellybeans.vim'
  Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
  Plug 'https://github.com/NLKNguyen/papercolor-theme'
  Plug 'https://github.com/ntpeters/vim-better-whitespace'
  Plug 'https://github.com/preservim/nerdtree'
  Plug 'https://github.com/preservim/vim-markdown'
  Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
  Plug 'https://github.com/SirVer/ultisnips'
  Plug 'https://github.com/tomasiser/vim-code-dark'
  Plug 'https://github.com/tomasr/molokai'
  Plug 'https://github.com/vim-latex/vim-latex'
  Plug 'https://github.com/vim-pandoc/vim-pandoc'
  Plug 'https://github.com/vim-pandoc/vim-pandoc-after'
  Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax'
  Plug 'https://github.com/wuelnerdotexe/vim-enfocado'
  Plug 'https://tpope.io/vim/commentary.git'
  Plug 'https://tpope.io/vim/eunuch.git'
  Plug 'https://tpope.io/vim/fugitive.git'
  Plug 'https://tpope.io/vim/repeat.git'
  Plug 'https://tpope.io/vim/sensible.git'
  Plug 'https://tpope.io/vim/surround.git'
call plug#end()

source /usr/share/gtags/gtags.vim
source /usr/share/gtags/gtags-cscope.vim

function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

augroup enfocado_customization
  autocmd!
    autocmd ColorScheme enfocado highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme enfocado highlight NormalNC ctermbg=NONE guibg=NONE
augroup END

augroup janah_customization
  autocmd!
    autocmd ColorScheme janah highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme janah highlight NormaNC ctermbg=NONE guibg=NONE
augroup END

augroup cctree_customization
  autocmd!
    autocmd BufWinEnter CCTreeOptsEnable DynamicTreeHiLights
    autocmd BufWinEnter CCTreeOptsEnable UseConceal
augroup END

augroup gitgutter_customization
  autocmd!
    autocmd BufWinEnter CCTreeOptsEnable DynamicTreeHiLights
    autocmd BufWinEnter CCTreeOptsEnable UseConceal
augroup END

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

colorscheme PaperColor
