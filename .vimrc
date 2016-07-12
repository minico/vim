"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This vimrc is based on the vimrc by Easwy
"
" Last Change: 11/13/09 09:17:57
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=================================== Config VimPlug begin ===============================
 call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/winmanager'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/genutils'
Plug 'ervandew/supertab'
Plug 'vim-scripts/Mark'
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'

" Add plugins to &runtimepath
call plug#end()
"=================================== Config VimPlug end ===============================

"============================= Config YouCompleteMe begin =================================

set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" resolve confilct between YCM and snipetUtils
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" 跳转到定义处
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
" nnoremap <leader>lo :lopen<CR>	"open locationlist
" nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>

let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 不显示开启vim时检查ycm_extra_conf文件的信息  
let g:ycm_confirm_extra_conf=0
" 开启基于tag的补全，可以在这之后添加需要的标签路径  
let g:ycm_collect_identifiers_from_tags_files=1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 输入第2个字符开始补全
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1	
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 设置在下面几种格式的文件上屏蔽ycm
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}

"============================= Config YouCompleteMe end =================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let $VIM="/users/zha55559/bin/vim72/vimL/share/vim/vim72"
"let $VIMRUNTIME="/users/zha55559/bin/vim72/vimL/share/vim/vim72"

"Get out of VI's compatible mode..
set nocompatible
 
" Platform
function! MySys()
  return "linux"
"  return "windows"
endfunction
 
"Sets how many lines of history VIM har to remember
set history=500

" Chinese
if MySys() == "windows"
   "set encoding=utf-8
   "set langmenu=zh_CN.UTF-8
   "language message zh_CN.UTF-8
   "set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1
endif
 
"Enable filetype plugin
filetype plugin off
"filetype plugin on
filetype indent off
"filetype indent on

"Set to auto read when a file is changed from the outside
"set autoread

"Have the mouse enabled all the time:
"set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>

" Switch to buffer according to file name
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
           let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

"Fast edit vimrc
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    " set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
    "Fast copying from linux
    func! CopyFromZ()
      autocmd! bufwritepost _vimrc
      exec 'split y:/.vimrc'
      exec 'normal 17G'
      exec 's/return "linux"/return "windows"/'
      exec 'w! ~/_vimrc'
      exec 'normal u'
      exec 'q'
    endfunc
    nnoremap <silent> <leader>uu :call CopyFromZ()<cr>:so ~/_vimrc<cr>
endif
 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set font
"if MySys() == "linux"
"  set gfn=Monospace\ 11
"endif

" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
    "Enable syntax hl
    syntax enable

    " color scheme
    if has("gui_running")
        set guioptions-=T
        set guioptions+=m
        set guioptions-=L
        set guioptions-=r
        colorscheme delek 
        "hi normal guibg=#294d4a
    else
       colorscheme delek
       "colorscheme delek_my
       "colorscheme evening
    endif " has
endif " exists(...)

autocmd BufEnter * :syntax sync fromstart

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"set so=7

" Maximum window when GUI running
if MySys() == "linux"
  if has("gui_running")
    set lines=9999
    set columns=9999
  endif
else
  au GUIEnter * simalt ~x
endif


"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
"set hid

"Set backspace
"set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
"set whichwrap+=<,>,h,l
set whichwrap+=<,>

"Ignore case when searching
set ignorecase

"Include search, which means search when typing
set incsearch

"Highlight search things
set hlsearch

"Set magic on
set magic

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

  """"""""""""""""""""""""""""""
  " Statusline
  """"""""""""""""""""""""""""""
  "Always show the statusline
  set laststatus=2

  function! CurDir()
     let curdir = substitute(getcwd(), '/home/easwy/', "~/", "g")
     return curdir
  endfunction

  "Format the statusline
  "set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
  "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
"Switch to current dir
map <silent> <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
"set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
"zi flod, zn unfold
"set fen
"set fdl=0
"set fdm=syntax

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set smarttab
"set lbr
"set tw=78

   """"""""""""""""""""""""""""""
   " Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   "set ai
   "Smart indet
   "set si
   "C-style indeting
   "set cindent
   "Wrap lines
   set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " Tabbar setting
   """"""""""""""""""""""""""""""
   nnoremap <silent> <F9> :TagbarToggle<CR>
   let g:tagbar_left = 1
   let g:tagbar_width = 30
   let g:tagbar_ctags_bin = '~/bin/ctags'

   """"""""""""""""""""""""""""""
   " NERD-Tree setting
   """"""""""""""""""""""""""""""
   nnoremap <silent> <F8> :NERDTreeToggle<CR>
   "let g:NERDTreeDirArrowExpandable = '+'
   "let g:NERDTreeDirArrowCollapsible = '-'
   let g:NERDTreeDirArrows=0
   "auto load NERD-Tree
   "autocmd vimenter * NERDTree 
   "close NERD-Tree when the last file closed;
   autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif    
   let g:NERDTreeChDirMode       = 2
   let g:ctrlp_working_path_mode = 'rw'

   """"""""""""""""""""""""""""""
   " winmanager setting
   """"""""""""""""""""""""""""""
   "let g:winManagerWindowLayout = 'NERDTree|Tagbar'
   "let g:winManagerWindowLayout = "TagList"
   let g:winManagerWidth = 30
   let g:defaultExplorer = 0
   nmap <silent> wm :WMToggle<cr>
   autocmd BufWinEnter \[Buf\ List\] setl nonumber

   """"""""""""""""""""""""""""""
   " grep setting
   """"""""""""""""""""""""""""""
   "F3 grep the current word
   nnoremap <silent> <F3> :Rgrep<CR>
   nnoremap <silent> <F4> :GrepBuffer<CR>
   let Grep_Default_Filelist = '*.[ch]* *.m *.mm *.java *.rc *.as' 
   let Grep_Skip_Files = '*.bak *~ *.o *.a *.obj' 
   let Grep_Skip_Dirs = '.svn .git' 


   """"""""""""""""""""""""""""""
   " mark setting
   """"""""""""""""""""""""""""""
   nmap <silent> <leader>hl <Plug>MarkSet
   vmap <silent> <leader>hl <Plug>MarkSet
   nmap <silent> <leader>hh <Plug>MarkClear
   vmap <silent> <leader>hh <Plug>MarkClear
   nmap <silent> <leader>hr <Plug>MarkRegex
   vmap <silent> <leader>hr <Plug>MarkRegex

   """"""""""""""""""""""""""""""
   " ctrlp
   """"""""""""""""""""""""""""""
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'
    "will search in current working dir by default;
    "when pressing Ctrl+a, will search in the specified directory;
    noremap <C-a> :CtrlP ~/code/<CR>
    "noremap <C-[> :CtrlPBuffer<CR>
    nmap <leader>b :CtrlPBuffer<CR>

   """"""""""""""""""""""""""""""
   " aireline
   """"""""""""""""""""""""""""""
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='dark'
    "let g:airline#extensions#tabline#enabled = 1
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '|'

    "Move among splitted windows
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " Fast grep
   function! s:GetVisualSelection()
       let save_a = @a
       silent normal! gv"ay
       let v = @a
       let @a = save_a
       let var = escape(v, '\\/.$*')
       return var
   endfunction

   nmap <silent> <leader>lv :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>
   vmap <silent> <leader>lv :lv /<c-r>=<sid>GetVisualSelection()<cr>/ %<cr>:lw<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mark as loaded
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimrc_loaded = 1

"show right slide bar
set guioptions+=r
"hide left slide bar
set guioptions-=L


"source $HOME/.vim/plugin/mark.vim
nnoremap <silent> <F2> :source $HOME/.vim/plugged/Mark/plugin/mark.vim<CR>

" restore edit cursor when reopen last file
" Only do this part when compiled with support for autocommands. 
if has("autocmd")
  " When editing a file, always jump to the last known cursor position. 
  " Don't do it when the position is invalid or when inside an event handler 
  " (happens when dropping a file on gvim). 
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

