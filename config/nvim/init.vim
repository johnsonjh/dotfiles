" vim: set ts=2 sw=2 tw=79 expandtab colorcolumn=79 :
" SPDX-License-Identifier: FSFAP

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Copyright (c) 2022 Jeffrey H. Johnson <trnsz@pobox.com>
"
" Copying and distribution of this file, with or without modification,
" are permitted in any medium without royalty provided the copyright
" notice and this notice are preserved.  This file is offered "AS-IS",
" without any warranty.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocp

if isdirectory(expand('$HOME/go/bin'))
  let s:EnableVimGolangPlugins = 1
else
  let s:EnableVimGolangPlugins = 0
endif

set background=dark

set autoindent
set autoread
set belloff=all
set browsedir=buffer
set conceallevel=0
set cscopeverbose
set cscopetag
set csto=0
set foldlevel=9999
set fsync
set hlsearch
set incsearch
set laststatus=2
set modeline
set noexpandtab
set nofoldenable
set noshowmode
set number
set hidden
set encoding=utf-8
set ruler
set shiftwidth=4
set showcmd
try
  set signcolumn=number
  catch
endtry
set smartcase
set smarttab
try
  set switchbuf=uselast
  catch
endtry
set tabstop=4
set termguicolors
set t_ut=
set timeoutlen=350
set updatetime=100
set wildignore=*.a,*.so,*.o,*.obj,*.lib,*.dll,a.out,core,*.bak,*.exe,*~
set wildmenu

try
  set autoshelldir
catch
endtry

try
  set cdhome
catch
endtry

try
  set wildoptions+=fuzzy
catch
endtry

try
  set wildoptions+=pum
catch
endtry

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

try
  filetype on
  filetype indent on
  filetype plugin on
catch
endtry

try
  syntax on
catch
endtry

let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"

let c_gnu                        = 1
let c_minlines                   = 300
let c_space_errors               = 1
let dtd_ignore_case              = 1
let dtd_no_tag_errors            = 1
let eiffel_ise                   = 1
let fortran_more_precise         = 1
let highlight_function_names     = 1
let macvim_skip_cmd_opt_movement = 1
let sh_minlines                  = 300

let g:ale_enabled = 0

let g:asterisk#keeppos = 1

let g:CCTreeDisplayMode              = 1
let g:CCTreeEnhancedSymbolProcessing = 1
let g:CCTreeUseUTF8Symbols           = 1

let g:changelog_spacing_errors = 0

let g:choosewin_overlay_enable = 1

let g:codedark_italics = 1

let g:context_enabled = 1

let g:ctrlp_user_command = [
  \   '.git', 'cd %s && git ls-files -co --exclude-standard'
  \ ]

let g:deoplete#enable_at_startup = 0

let g:gitgutter_enabled = 1

let g:Gtags_No_Auto_Jump = 1

let g:indent_guides_enable_on_vim_startup = 0

let g:jellybeans_overrides = {
  \   'background': {
  \     'guibg': '000000'
  \   },
  \ }

let g:jellybeans_use_term_italics = 1

let g:tagbar_case_insensitive = 1
let g:tagbar_sort             = 0
let g:tagbar_compact          = 2
let g:tagbar_indent           = 1
let g:tagbar_show_tag_count   = 1
let g:tagbar_foldlevel        = 2

let g:line_no_indicator_chars = [
  \   '   ', '▏  ', '▎  ', '▍  ', '▌  ',
  \   '▋  ', '▊  ', '▉  ', '█  ', '█▏ ',
  \   '█▎ ', '█▍ ', '█▌ ', '█▋ ', '█▊ ',
  \   '█▉ ', '██ ', '██▏', '██▎', '██▍',
  \   '██▌', '██▋', '██▊', '██▉', '███'
  \ ]

let g:lightline = {
  \   'enable': {
  \     'statusline': 1,
  \     'tabline':    0
  \   }
  \ }

let g:lightline = {
  \   'colorscheme': 'PaperColor',
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'fugitive', 'readonly', 'filename', 'modified' ]
  \     ],
  \     'right': [
  \       [ 'lineinfo' ],
  \       [ 'percent', 'indicator' ],
  \       [ 'fileformat', 'fileencoding', 'filetype', 'charvalue' ]
  \     ]
  \   },
  \   'component_function': {
  \     'fugitive':  'FugitiveHead',
  \     'readonly':  'LightlineReadonly'
  \   },
  \   'component': {
  \     'indicator': '%{LineNoIndicator()}',
  \     'charvalue': '%b | 0x%B'
  \   },
  \ }

let g:NERDTreeHijackNetrw = 1

let g:obvious_resize_run_tmux = 1

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }

try
  if !exists('g:osenv')
    if has('win64') || has('win32') || has('win16')
      let g:osenv = 'WINDOWS'
    else
      let g:osenv = toupper(substitute(system(
        \   'uname 2> /dev/null'), '\n', '', '')
        \ )
    endif
  endif
catch
  let g:osenv = 'UNKNOWN'
endtry

if (g:osenv != 'AIX')
  let g:pandoc#after#modules#enabled = [
    \   "ultisnips"
    \ ]
endif

let g:plug_threads = 32
let g:plug_timeout = 120
let g:plug_retries = 3
let g:plug_shallow = 1
let g:plug_window = 'new'

let g:rainbow_active = 1

let g:rainbow_conf = {
  \	  'guifgs': [
  \     'lightblue',
  \     'lightyellow',
  \     'lightcyan',
  \     'lightmagenta'
  \   ],
  \	  'ctermfgs': [
  \     'lightblue',
  \     'lightyellow',
  \     'lightcyan',
  \     'lightmagenta'
  \   ],
  \ }

let g:rehash256 = 1

let g:shfmt_extra_args  = '-s -i 2 -ci -sr -fn'
let g:shfmt_fmt_on_save = 0

let g:shellcheck_directive_highlight = 1

let g:task_rc_override = 'rc.defaultheight=0'
let g:task_rc_override = 'rc.defaultwidth=0'

if (g:osenv != 'AIX')
  let g:UltiSnipsEditSplit = "vertical"
endif

let g:vim_markdown_conceal             = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled    = 1

let g:EasyMotion_smartcase        = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_use_upper        = 1

let g:git_messenger_no_default_mappings = 1

let g:maximizer_default_mapping_key   = '<F3>'
let g:maximizer_set_default_mapping   = 1
let g:maximizer_set_mapping_with_bang = 1

let g:suda_smart_edit = 1

let g:filebeagle_suppress_keymap = 0
let g:filebeagle_check_gitignore = 1
let g:filebeagle_show_hidden     = 1

let g:committia_open_only_vim_starting = 1

let g:lastplace_ignore_buftype =
  \  "quickfix,nofile,help,nerdtree,tagbar,context,"
  \   ."buffergator,filebeagle,fugitiveblame,diff,vim"

if !has('nvim')
  let   html_use_css      = 1
  let   c_comment_strings = 1
  unlet c_comment_strings
endif

if !exists("*SourceIfExists")
  function! SourceIfExists(file)
    if filereadable(expand(a:file))
      exe 'source' a:file
    endif
  endfunction
endif

function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
    \   &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no'
    \ )
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

if has("persistent_undo")
  if has('nvim')
    let target_path = expand('$HOME/.vimundo')
  else
    let target_path = expand('$HOME/.nvimundo')
  endif
  if !isdirectory(target_path)
    call mkdir(target_path, "p", 0700)
  endif
  let g:undotree_WindowLayout    = 1
  let g:undotree_ShortIndicators = 1
  let &undodir                   = target_path
  set undofile
endif

autocmd SwapExists * let v:swapchoice = "o"

call plug#begin()
  if has('nvim')
    Plug 'https://github.com/chentoast/marks.nvim.git'
    Plug 'https://github.com/folke/todo-comments.nvim.git'
    Plug 'https://github.com/lambdalisue/pastefix.vim.git'
    Plug 'https://github.com/nvim-lua/plenary.nvim.git'
    Plug 'https://github.com/sindrets/diffview.nvim.git'
    Plug 'https://github.com/vimlab/split-term.vim'
    Plug 'https://github.com/windwp/nvim-spectre.git'
    Plug 'https://github.com/Shougo/deoplete.nvim.git', {
       \   'do': ':UpdateRemotePlugins'
       \ }
    Plug 'https://github.com/Xuyuanp/scrollbar.nvim'
  else
    Plug 'https://github.com/noahfrederick/vim-neovim-defaults.git'
    Plug 'https://github.com/roxma/nvim-yarp.git'
    Plug 'https://github.com/roxma/vim-hug-neovim-rpc.git'
    Plug 'https://github.com/Shougo/deoplete.nvim.git'
  endif
  Plug 'https://github.com/a5ob7r/shellcheckrc.vim.git'
  Plug 'https://github.com/airblade/vim-gitgutter.git'
  Plug 'https://github.com/brooth/far.vim.git'
  Plug 'https://github.com/chumakd/scratch.vim.git'
  Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
  Plug 'https://github.com/dbmrq/vim-ditto.git'
  Plug 'https://github.com/dense-analysis/ale.git'
  Plug 'https://github.com/direnv/direnv.vim.git'
  Plug 'https://github.com/drzel/vim-line-no-indicator.git'
  Plug 'https://github.com/easymotion/vim-easymotion.git'
  if (s:EnableVimGolangPlugins)
    Plug 'https://github.com/fatih/vim-go.git', {
       \   'do': ':GoUpdateBinaries'
       \ }
  endif
  Plug 'https://github.com/bfrg/vim-cpp-modern.git'
  Plug 'https://github.com/farmergreg/vim-lastplace.git'
  Plug 'https://github.com/glts/vim-magnum.git'
  Plug 'https://github.com/glts/vim-radical.git'
  Plug 'https://github.com/glts/vim-textobj-comment.git'
  Plug 'https://github.com/godlygeek/tabular.git'
  Plug 'https://github.com/habamax/vim-asciidoctor.git'
  Plug 'https://github.com/hari-rangarajan/CCTree.git'
  Plug 'https://github.com/haya14busa/is.vim.git'
  Plug 'https://github.com/haya14busa/vim-asterisk.git'
  Plug 'https://github.com/honza/vim-snippets.git'
  Plug 'https://github.com/int3/vim-extradite.git'
  Plug 'https://github.com/itchyny/lightline.vim.git'
  Plug 'https://github.com/itchyny/vim-gitbranch.git'
  Plug 'https://github.com/janet-lang/janet.vim.git'
  Plug 'https://github.com/jeetsukumaran/vim-buffergator.git'
  Plug 'https://github.com/jeetsukumaran/vim-filebeagle.git'
  Plug 'https://github.com/jeffkreeftmeijer/vim-numbertoggle.git'
  Plug 'https://github.com/jremmen/vim-ripgrep.git'
  Plug 'https://github.com/junegunn/gv.vim.git'
  Plug 'https://github.com/junegunn/vim-easy-align.git'
  Plug 'https://github.com/junegunn/vim-plug.git'
  Plug 'https://github.com/jvirtanen/vim-octave.git'
  Plug 'https://github.com/kana/vim-operator-user.git'
  Plug 'https://github.com/kana/vim-textobj-datetime.git'
  Plug 'https://github.com/kana/vim-textobj-entire.git'
  Plug 'https://github.com/kana/vim-textobj-function.git'
  Plug 'https://github.com/kana/vim-textobj-user.git'
  Plug 'https://github.com/Konfekt/vim-alias.git'
  Plug 'https://github.com/lambdalisue/askpass.vim.git'
  Plug 'https://github.com/lambdalisue/guise.vim.git'
  Plug 'https://github.com/lambdalisue/suda.vim.git'
  Plug 'https://github.com/liuchengxu/graphviz.vim.git'
  Plug 'https://github.com/luochen1990/rainbow.git'
  Plug 'https://github.com/mbbill/undotree.git'
  Plug 'https://github.com/mhinz/vim-startify.git'
  Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
  Plug 'https://github.com/nanotech/jellybeans.vim.git'
  Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
  Plug 'https://github.com/NLKNguyen/papercolor-theme.git'
  Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
  Plug 'https://github.com/preservim/nerdtree.git'
  Plug 'https://github.com/preservim/tagbar.git'
  Plug 'https://github.com/preservim/vimux.git'
  Plug 'https://github.com/preservim/vim-markdown.git'
  Plug 'https://github.com/preservim/vim-textobj-quote'
  Plug 'https://github.com/rbgrouleff/bclose.vim.git'
  Plug 'https://github.com/rhysd/committia.vim.git'
  Plug 'https://github.com/rhysd/conflict-marker.vim.git'
  Plug 'https://github.com/rhysd/git-messenger.vim.git'
  Plug 'https://github.com/rickhowe/diffchar.vim.git'
  Plug 'https://github.com/shumphrey/fugitive-gitlab.vim.git'
  if (g:osenv != 'AIX')
    if has ('python3')
      Plug 'https://github.com/SirVer/ultisnips.git'
    endif
  endif
  Plug 'https://github.com/skywind3000/vim-preview.git'
  Plug 'https://github.com/sodapopcan/vim-twiggy.git'
  Plug 'https://github.com/szw/vim-maximizer.git'
  Plug 'https://github.com/t9md/vim-choosewin.git'
  Plug 'https://github.com/talek/obvious-resize.git'
  Plug 'https://github.com/tmux-plugins/vim-tmux.git'
  Plug 'https://github.com/tomasiser/vim-code-dark.git'
  Plug 'https://github.com/tomasr/molokai.git'
  Plug 'https://github.com/vim-pandoc/vim-pandoc-after.git'
  Plug 'https://github.com/vim-pandoc/vim-pandoc.git'
  Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
  Plug 'https://github.com/vim-scripts/autoload_cscope.vim.git'
  Plug 'https://github.com/vim-scripts/UniCycle.git'
  Plug 'https://github.com/voldikss/vim-mma.git'
  Plug 'https://github.com/wateret/ifdef-heaven.vim.git'
  Plug 'https://github.com/weilbith/nerdtree_choosewin-plugin.git'
  Plug 'https://github.com/wellle/context.vim.git'
  Plug 'https://github.com/wellle/targets.vim.git'
  Plug 'https://github.com/wellle/tmux-complete.vim.git'
  Plug 'https://github.com/xarthurx/taskwarrior.vim.git'
  Plug 'https://github.com/xu-cheng/brew.vim.git'
  Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
  Plug 'https://github.com/z0mbix/vim-shfmt.git', {
     \   'for': 'sh'
     \ }
  Plug 'https://tpope.io/vim/commentary.git'
  Plug 'https://tpope.io/vim/dispatch.git'
  Plug 'https://tpope.io/vim/eunuch.git'
  Plug 'https://tpope.io/vim/fugitive.git'
  Plug 'https://tpope.io/vim-obsession.git'
  Plug 'https://tpope.io/vim/repeat.git'
  Plug 'https://tpope.io/vim/rhubarb.git'
  Plug 'https://tpope.io/vim/sensible.git'
  Plug 'https://tpope.io/vim/speeddating.git'
  Plug 'https://tpope.io/vim/surround.git'
  Plug 'https://tpope.io/vim/tbone.git'
  Plug 'https://tpope.io/vim/unimpaired.git'
call plug#end()

if !has('nvim')
  silent! runtime! plugin/neovim_defaults.vim
endif

call SourceIfExists('/usr/share/asymptote/asy.vim')
call SourceIfExists('/usr/share/asymptote/asy_filetype.vim')

call SourceIfExists('/usr/share/gtags/gtags.vim')
call SourceIfExists('/usr/share/gtags/gtags-cscope.vim')

if has('nvim')
  call SourceIfExists(expand(
     \  '$HOME/.local/share/nvim/plugged/ifdef-heaven.vim/ifdef-heaven.vim')
     \ )
else
  try
    call SourceIfExists(expand(
       \  '$HOME/.vim/plugged/ifdef-heaven.vim/ifdef-heaven.vim')
       \ )
  catch
  endtry
endif

function! LightlineReadonly()
  return &readonly && &filetype !=# '\v(help)' ? 'RO' : ''
endfunction

augroup CCTree_Customization
  autocmd!
    autocmd BufWinEnter CCTreeOptsEnable DynamicTreeHiLights
    autocmd BufWinEnter CCTreeOptsEnable UseConceal
augroup END

try
  colorscheme PaperColor
catch
  try
    colorscheme industry
    catch
  endtry
endtry

highlight Normal guibg=black

highlight nonascii guibg=darkred ctermbg=1 term=standout

autocmd BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

command! ColorTest call SourceIfExists('$VIMRUNTIME/syntax/colortest.vim')

function! s:gitModifiedFileList()
  let files =
    \  systemlist('git ls-files -m 2> /dev/null')
  return map(files, "{
       \   'line': v:val,
       \   'path': v:val
       \ }")
endfunction

function! s:gitUntrackedFileList()
  let files =
    \  systemlist('git ls-files -o --exclude-standard 2> /dev/null')
  return map(files, "{
       \   'line': v:val,
       \   'path': v:val
       \ }")
endfunction

function! s:nerdTreeBookmarks()
  let bookmarks =
    \  systemlist("cut -d ' ' -f 2- ~/.NERDTreeBookmarks 2> /dev/null")
  let bookmarks = bookmarks[0:-2]
  return map(bookmarks, "{
       \   'line': v:val,
       \   'path': v:val
       \ }")
endfunction

function! s:gitCommitList()
  let gclquiet = 'exec 2> /dev/null;'
  let git      = 'git'
  let gclfmt   = ' log --date=relative --pretty=format:"%h%x09[%ad]%x09%s" .'
  let gcllimit = '|head -n 25|column -ts "$(printf \\t)"|sed "s/ \[/\[/g"'
  let commits  = systemlist(gclquiet . git . gclfmt . gcllimit)
  let git      = 'G'. git[1:]
  return map(commits, '{
       \   "line": matchstr(v:val, "\\s\\zs.*"),
       \    "cmd":  "'. git .' show ". matchstr(v:val, "^\\x\\+")
       \ }')
endfunction

try
  let g:vimversion_pretty =
    \  matchstr(execute('version'),
    \   '[^\n.]\?[Vv][Ii][Mm][^\n]*')
catch
  try
    let g:vimversion_pretty =
      \  "Vim-compatible editor (version ".v:versionlong.")"
  catch
    try
      let g:vimversion_pretty =
        \  "Vim-compatible editor (version ".v:version.")"
    catch
      let g:vimversion_pretty =
        \  "Vim-compatible editor (unknown version)"
    endtry
  endtry
endtry

let g:startify_custom_header = split(system(
  \   ("(exec 2> /dev/null;printf '[%s@%s] %s\\n%s\\n'
  \    \"$( whoami )\" \"$( hostname )\" \"$( uname -mrs )\"
  \     \"$( printf '%s\\n' '".vimversion_pretty."' )\")")
  \      ."| awk '{ $1=$1 };1' 2> /dev/null | grep -v '^$' 2> /dev/null"
  \       ."| awk '{ print \"   \"$0 }' 2> /dev/null"), '\n'
  \ )

let g:startify_change_to_dir       = 0
let g:startify_fortune_use_unicode = 1
let g:startify_session_sort        = 1
let g:startify_update_oldfiles     = 1

let g:startify_session_before_save = [
  \   'silent! tabdo NERDTreeClose'
  \ ]

let g:startify_session_before_save = [
  \   "ContextDisable"
  \ ]

let g:startify_lists = [
  \   { 'type':   'sessions',
  \     'header': [
  \       '   [Vim] Sessions'
  \     ]
  \   },
  \   { 'type':   'dir',
  \     'header': [
  \       '   [Vim] Recently Used ['. getcwd() .']'
  \     ]
  \   },
  \   { 'type':   'bookmarks',
  \     'header': [
  \        '   [Startify] Bookmarks'
  \     ]
  \   },
  \   { 'type':   function('s:nerdTreeBookmarks'),
  \     'header': [
  \       '   [NERDTree] Bookmarks'
  \     ]
  \   },
  \   { 'type':   function('s:gitModifiedFileList'),
  \     'header': [
  \       '   [Git] Modified Files ['. getcwd() .']'
  \     ]
  \   },
  \   { 'type':   function('s:gitUntrackedFileList'),
  \     'header': [
  \       '   [Git] Untracked Files ['. getcwd() .']'
  \     ]
  \   },
  \   { 'type':   function('s:gitCommitList'),
  \     'header': [
  \       '   [Git] Last 25 commits ['. getcwd() .']'
  \     ]
  \   },
  \   { 'type':   'files',
  \     'header': [
  \       '   [Vim] Recently Used [Global]'
  \     ]
  \   },
  \   { 'type':   'commands',
  \     'header': [
  \       '   [Vim] Commands'
  \     ]
  \   },
  \ ]

let g:vimwiki_list = [
  \   { 'path':      '$HOME/vimwiki',
  \     'path_html': '$HOME/public_html/vimwiki',
  \     'auto_toc':  1
  \   },
  \   { 'path':      '$HOME/src/vimwikiwiki/wiki',
  \     'path_html': '$HOME/src/vimwikiwiki/docs',
  \     'auto_toc':  1
  \   }
  \ ]

map      f                   :call IfdefHeaven_WhereAmI()<CR>
map      g#                  <Plug>(asterisk-g#)
map      g*                  <Plug>(asterisk-g*)
map      gz#                 <Plug>(asterisk-gz#)
map      gz*                 <Plug>(asterisk-gz*)
map      #                   <Plug>(asterisk-#)
map      *                   <Plug>(asterisk-*)
map      z#                  <Plug>(asterisk-z#)
map      z*                  <Plug>(asterisk-z*)
nmap     ga                  <Plug>(EasyAlign)
nmap     +                   <Plug>(choosewin)
nmap     s                   <Plug>(easymotion-s)
nmap     <C-w>m              <Plug>(git-messenger)
nmap     <Leader>gm          <Plug>(git-messenger)
nnoremap <F4>                :UndotreeToggle<CR>
nnoremap <F5>                :NERDTreeToggle<CR>
nnoremap <F6>                :TagbarToggle<CR>
nnoremap <F7>                :BuffergatorTabsToggle<CR>
nnoremap <F8>                :BuffergatorToggle<CR>
nnoremap <F9>                :CCTreeTraceForward<CR>
nnoremap <F10>               :CCTreeTraceReverse<CR>
nnoremap <Leader>ml          :call AppendModeline()<CR>
noremap  <silent> <C-Down>   :<C-U>ObviousResizeDown<CR>
noremap  <silent> <C-Left>   :<C-U>ObviousResizeLeft<CR>
noremap  <silent> <C-Right>  :<C-U>ObviousResizeRight<CR>
noremap  <silent> <C-Up>     :<C-U>ObviousResizeUp<CR>
omap     t                   <Plug>(easymotion-bd-tl)
xmap     ga                  <Plug>(EasyAlign)
map      <Leader>            <Plug>(easymotion-prefix)

if has('nvim')
  nnoremap <Leader>S <Cmd>lua
         \  require('spectre').open()<CR>
  nnoremap <Leader>sw <Cmd>lua
         \  require('spectre').open_visual({select_word=true})<CR>
  vnoremap <Leader>s <ESC>:lua
         \  require('spectre').open_visual()<CR>
  nnoremap <Leader>sp viw:lua
         \  require('spectre').open_file_search()<CR>
endif

augroup Ditto_Initialization
  autocmd!
  silent! autocmd FileType markdown,text,tex DittoOn
  nmap <leader>di <Plug>ToggleDitto
augroup end

if has('nvim')
  augroup Scrollbar_Initialization
    autocmd!
    silent! autocmd WinScrolled,VimResized,CursorMoved,QuitPre *
          \  silent! lua require('scrollbar').show()
    silent! autocmd BufWinEnter,WinEnter,BufEnter,TabEnter,FocusGained *
          \  silent! lua require('scrollbar').show()
    silent! autocmd User StartifyReady
          \  silent! lua require('scrollbar').show()
    silent! autocmd WinLeave,BufLeave,BufWinLeave,FocusLost *
          \  silent! lua require('scrollbar').clear()
  augroup end
endif

if exists('s:loaded_vimafter')
  doautocmd VimAfter VimEnter *
else
  let s:loaded_vimafter = 1
  augroup VimAfter
    autocmd!
    autocmd VimEnter * silent! unmap <Leader>bd
    autocmd VimEnter * silent! Alias w!! SudaWrite
    if !has('nvim')
      autocmd VimEnter * silent! Alias Term term
    endif
    if has('nvim')
      autocmd FileType c call SourceIfExists(expand(
            \   '$HOME/.local/share/nvim/plugged/'
            \   .'vim-cpp-modern/after/syntax/c.vim')
            \ )
      autocmd FileType cpp call SourceIfExists(expand(
            \   '$HOME/.local/share/nvim/plugged/'
            \   .'vim-cpp-modern/after/syntax/cpp.vim')
            \ )
    else
      autocmd FileType c call SourceIfExists(expand(
            \   '$HOME/.vim/plugged/'
            \   .'vim-cpp-modern/after/syntax/c.vim')
            \ )
      autocmd FileType cpp call SourceIfExists(expand(
            \   '$HOME/.vim/plugged/'
            \   .'vim-cpp-modern/after/syntax/cpp.vim')
            \ )
    endif
  augroup END
endif
