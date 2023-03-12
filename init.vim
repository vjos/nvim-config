" vim mode
if &compatible
  set nocompatible
endif

" hybrid line numbers
set number relativenumber

" filetype specific plugins
filetype plugin indent on

" manage plugins with vim-plug
call plug#begin()
" core plugins to expand vim editing
Plug 'jiangmiao/auto-pairs' " inserts a matching closer for above pairs, handles indentation
Plug 'tpope/vim-commentary' " toggle code commenting with selection+gc or gcc
Plug 'tpope/vim-surround' " adds text-object like interactions for quotes, parens and tags [eg: cs'{]
Plug 'vimwiki/vimwiki'

" additional features outside of core editing
Plug 'Pocco81/TrueZen.nvim'
Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'numtostr/FTerm.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ziontee113/color-picker.nvim'

" handle code completion, linting and snippets
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'

" visual plugins
Plug 'ap/vim-css-color'
Plug 'bling/vim-bufferline'
Plug 'catppuccin/nvim'
Plug 'folke/twilight.nvim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'unblevable/quick-scope'

" statusline plugins
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
call plug#end()

" handle coc extensions
let g:coc_global_extensions = ["coc-snippets", "coc-vimlsp", "coc-jedi", "coc-go", "coc-sh", "coc-html", "coc-htmlhint", "coc-emmet", "coc-json", "coc-prettier", "coc-css", "coc-html-css-support", "coc-vimtex"]

set shell=/bin/bash

" required for correct background window behaviour with shade and truezen
set hidden

" make config
"noremap <F5> <Esc>:silent w<CR>:silent make<CR>:silent !clear<CR><C-L>
"au FileType tex    set makeprg=pdflatex\ %;\ chromium\ %:r.pdf
au FileType c      set makeprg=gcc\ % 

" vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer="okular"
let g:vimtex_view_general_options="--unique file:@pdf"

"\src:@line@tex"
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" set the leader key (needs to be done before any leader key mappings are made)
nnoremap <SPACE> <Nop>
let mapleader=" "

" config that plugins depend on:
syntax enable
set tgc

" basic tab-spacing
set tabstop=4
set shiftwidth=4
set expandtab

" visual configs
set laststatus=3 "global status line (see https://www.youtube.com/watch?v=jH5PNvJIa6o)"
set noshowmode
set cursorline
set termguicolors
set wildmenu

" enable clipboard yank/paste
set clipboard+=unnamedplus

" remap emmet leader ctrl+e
let g:user_emmet_leader_key='<C-E>'

let g:OmniSharp_server_use_mono = 1
let g:ale_linters = {
  \ 'cs': ['OmniSharp']
  \}

" " tab, shift-tab and enter to control autocompletion
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" inoremap <silent><expr> <Tab>
"       \ coc#pum#visible() ? coc#pum#next(1):
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()

" inoremap <silent><expr> <S-Tab>
"       \ coc#pum#visible() ? coc#pum#prev(1):
"       \ <SID>check_back_space() ? "\<S-Tab>" :
"       \ coc#refresh()

" " imap <C-j> <Plug>(coc-snippets-expand)
" inoremap <silent><expr> <C-j> coc#_select_confirm()

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = "<Tab>"
let g:coc_snippet_prev = "<S-Tab>"

" quick-scope config
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" run init.lua script
lua require('init')
lua require('nvim-tree-conf')
lua require('lualine-conf')

" vimwiki configuration
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/documents/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'} 

" nice colourschemes
let g:catppuccin_flavour = "frappe"
colorscheme catppuccin-frappe

highlight WinSeparator guibg=None
