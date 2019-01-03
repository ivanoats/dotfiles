filetype off
set rtp+=~/.nvim/bundle/Vundle.vim/
call vundle#rc()

if has('nvim')
  let s:editor_root=expand("~/.config/nvim")
  call vundle#rc(s:editor_root . '/bundle')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  nnoremap <A-h> <C-w>h
  nnoremap <A-j> <C-w>j
  nnoremap <A-k> <C-w>k
  nnoremap <A-l> <C-w>l
else
  let s:editor_root=expand("~/.vim")
endif

let g:vundle_default_git_proto = 'git'
Bundle 'gmarik/Vundle.vim'
Bundle 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'ngmy/vim-rubocop'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-bundler'
Bundle 'kchmck/vim-coffee-script'
Bundle 'skwp/vim-rspec'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'git://github.com/mileszs/ack.vim.git'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mattn/gist-vim'
Bundle 'ervandew/supertab'
Bundle 'majutsushi/tagbar'
Bundle 'skalnik/vim-vroom'
Bundle 'danchoi/ri.vim'
Bundle 'moll/vim-node'
Bundle 'mustache/vim-mustache-handlebars'
"Bundle 'ahayman/vim-nodejs-complete'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'vim-scripts/closetag.vim'
Bundle 'mattn/webapi-vim'
Bundle 'Raimondi/delimitMate'
Bundle 'mattn/emmet-vim'
Bundle 'mklabs/grunt.vim'
Bundle 'marijnh/tern_for_vim'
Bundle 'elzr/vim-json'
Bundle 'elmcast/elm-vim'
Bundle 'raichoo/purescript-vim'
" provided by syntastic 
"Bundle 'vim-scripts/rubycomplete.vim'
"Bundle 'FredKSchott/CoVim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'plytophogy/vim-virtualenv'

set shell=$SHELL
set completeopt+=preview
filetype plugin indent on
set background=light
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <D-O> ! open file:///%:p<CR>
nmap <Leader>h :noh<CR>
command! W w !sudo tee % > /dev/null
set directory=/tmp
set wrap
syntax enable
set number
set ruler
set encoding=utf-8
set laststatus=2

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set list
set backspace=indent,eol,start

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set hlsearch
set incsearch
set ignorecase
set smartcase

if has("autocmd")
  autocmd! bufwritepost .init.vim source ~/.nvim/init.vim
  " Make sure all mardown files have the correct filetype set and setup wrapping
  autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown
  "not sure what below does
  "au FileType markdown call s:setupWrapping()
  autocmd BufWritePre *.rb :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.yaml :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.feature :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.erb :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.html :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.js :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.json :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.java :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre Cheffile :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre Rakefile :call <SID>StripTrailingWhitespaces()
  autocmd Filetype html,xml,xsl source ~/.nvim/bundle/closetag.vim/plugin/closetag.vim
  autocmd BufRead,BufNewFile *.json set filetype=json
  autocmd filetype crontab setlocal nobackup nowritebackup
endif

nmap <leader>v :tabedit ~/.nvim/init.vim<CR>
nmap <leader>n :NERDTreeToggle<CR>

set colorcolumn=80

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

set clipboard=unnamed

let g:ctrlp_custom_ignore = {'dir': '\.git$\|\.hg$\|\.svn$\|doc$\|node_modules$\|coverage$\|\.chef$','file': '.DS_Store'}
let g:syntastic_ruby_exec='/usr/bin/ruby'
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_tidy_exec = 'tidy5'
"
" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

" waiting until eclipse has ruby 1.9 syntax support
" for YouCompleteMe only
"let g:EclimCompletionMethod = 'omnifunc'

" For Supertab + Eclim
let g:SuperTabDefaultCompletionType = 'context'

" On enter update/create tags
autocmd VimEnter * call UpdateOrCreateTagsFile()

" warn if file has changed
au CursorHold * if getcmdwintype() == '' | checktime | endif

" On write just update tags of this file
"autocmd BufWritePost *.rb call writefile(split(system("sort -u <(touch tags && grep -v " . expand('%:%') . " tags) <(ctags --language-force=ruby -u -f - " . shellescape(expand('%:%')) . " | grep " . expand('%:r') . ")"),"\n"),"tags")

" Create tagsfile (if it doesn't exist)
" or update tags file if it is too old
" currently doesn't handle same-name classes well ...
fun! UpdateOrCreateTagsFile()
  let mtime_tags = getftime("tags")
  let mtime_gemfile = getftime("Gemfile.lock")

  if mtime_gemfile > 0 && (mtime_tags == -1 || mtime_gemfile > mtime_tags)
    echom "Generating tags as Gemfile.lock is newer than tags"
    let tempfile = tempname()
    call writefile(["#!/bin/bash","ctags -R --language-force=ruby -u -f tags", "rm $0"], tempfile)
    silent! execute ":!bash " . tempfile . " &"
  endif
endfun

" Python stuff
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

let g:ycm_autoclose_preview_window_after_comletion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1
let g:python3_host_prog="/usr/local/bin/python3"

