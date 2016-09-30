" .vimrc
"
" Default settings for vim/gvim.  Information on the commands/options set
" here can be referenced by starting vim/gvim and entering:
"
"         :help command-or-option
"
" Author:  Mike Bland <mbland@acm.org>
" Date:    2014-06-08

" Enable the pathogen package manager:
"   https://github.com/tpope/vim-pathogen
"   https://gist.github.com/romainl/9970697
execute pathogen#infect()

" Turn on language syntax highlighting
syntax on
filetype on
filetype plugin on
"filetype indent on

set ruler
set title

" Prevent the gvim cursor from blinking
set guicursor=a:blinkon0

" Disables error bells (these can get annoying after a while)
set noeb

" Disables visual error bells (screen flashes); gvim screen still flashes,
" but isn't quite so bad
set t_vb=
set vb

" Set maximum column width for formatting with gq commands
set textwidth=80

" Hides a buffer (file) when abandoned rather than unloading it
set hid

set ts=2
set expandtab
set shiftwidth=2

set statusline=%<%f\ %h%m%r%=%-12.(%l,%c%V%)\ %P
set autoindent
set smartindent
set smarttab

" Highlighted search
set hlsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set spellfile=~/.vim/spell/en.utf-8.add

" Explicitly specifies the program to be used by the ':make' command
"set makeprg=gmake

" Add to include file search path; do ':help tag-commands' to find out more
"set path+=

" Add to tag file search path; do ':help tag-commands' to find out more
"
" You can generate a fresh tags file for your entire project source tree
" by executing:
"
"         proj project_name
"         cd $PROJECT_SOURCE
"         ctags -R *
"
" You can also create a local ctags file in whichever directory you're working
" by executing:
"
"         ctags *
"
" The tags path, as set below, will search the local file first, then the
" project-wide file.
if $TAGS_FILE != ""
  if filereadable($TAGS_FILE)
    set tags+=$TAGS_FILE
  else
    echo "Can't read $TAGS_FILE; tags not set"
  endif
endif

" Detect whether cscope features are present and whether we should add a
" connection to an existing cscope.out database file
if has("cscope")
  set nocsverb
  if filereadable("./cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    if filereadable($CSCOPE_DB)
      cs add $CSCOPE_DB
    else
      echo "Can't read $CSCOPE_DB; cscope add not run"
    endif
  endif
  set csre
  set csverb
endif

" Command to switch to the directory of the file we currently have open
command Cdf execute 'let $NEWDIR = expand("%:p:h") | cd $NEWDIR'

" Command to print out the full path of the current file
command Fpath echo expand("%:p")

" Create an #include directive
function Inc(header)
	execute 's%^.*$%#include <' . a:header .  '>%'
endfunction
command -nargs=1 Inc call Inc(<q-args>)

" Syntastic:
"   cd ~/.vim/bundle
"   git clone https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ["eslint"]
command Sr call SyntasticReset()

" Blog template
autocmd BufNewFile ~/src/mike-bland.com/*.textile 0r ~/src/mike-bland.com/_posts/new-post.textile
autocmd BufNewFile,BufRead ~/src/mike-bland.com/*.textile setlocal spellfile+=~/src/mike-bland.com/_posts/google.utf-8.add,~/src/mike-bland.com/_posts/tags.utf-8.add
autocmd BufNewFile,BufRead *.textile set textwidth=0
autocmd BufNewFile,BufRead *.html,~/src/mike-bland.com/_includes/*.ext set textwidth=0
autocmd BufNewFile,BufRead *.go set noexpandtab ts=8 sw=8
autocmd BufNewFile,BufRead ~/src/mike-bland.com/{*/*.html,_includes/*.ext} set filetype=liquid
autocmd Filetype html,xml,xsl,liquid source ~/.vim/scripts/closetag.vim

" Polyglot language packs (requires Pathogen):
"   cd ~/.vim/bundle
"   git clone https://github.com/sheerun/vim-polyglot polyglot
" Mustache/Handlebars pack:
"   clone https://github.com/mustache/vim-mustache-handlebars mustache
let g:mustache_abbreviations = 1
