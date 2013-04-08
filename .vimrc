if filereadable("/etc/vimrc")
	source /etc/vimrc
else
	if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	   set fileencodings=utf-8,latin1
	endif
	" Switch syntax highlighting on, when the terminal has colors
	" Also switch on highlighting the last used search pattern. 
	if &t_Co > 2 || has("gui_running")
		syntax on
		set hlsearch
	endif

	if &term=="xterm"
		 set t_Co=8
		 set t_Sb=[4%dm
		 set t_Sf=[3%dm
	endif

	set nocompatible	" Use Vim defaults (much better!)
	set bs=indent,eol,start		" allow backspacing over everything in insert mode
	set viminfo='20,\"50	" read/write a .viminfo file, don't store more
				" than 50 lines of registers
	set history=50		" keep 50 lines of command line history
	set ruler
	set nocp
endif
"======= VIM OPTION ====================================

set title
set cursorline
"set smartindent
"set showmatch
"set mouse=an
set tabstop=4
set ts=4
set sw=4
set nobackup
"current file directory 
set autochdir
" Add full file path to your existing statusline
"set statusline+=%F
set laststatus=2




filetype off "required for vundle
filetype plugin on
filetype plugin indent on     " required! for vundle


"============ VUNDLE  =================================
" NOTE: This Script Required Install VUNDLE Plugin
" VUNDLE INSTALL :
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"============ VUNDLE  =================================
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
if version >= 702
	Bundle 'howrujh/Mark.git'
endif
" original repos on github
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
Bundle 'spolu/dwm.vim.git'
"-------vim-scripts repos--------------

if version >= 702
	Bundle 'L9'
	Bundle 'FuzzyFinder'
endif

Bundle 'Tango-colour-scheme'
"Bundle 'tango.vim'
Bundle 'bufexplorer.zip'
Bundle 'DirDiff.vim'
Bundle 'taglist.vim'
Bundle 'Align'
Bundle 'DoxygenToolkit.vim'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
colorscheme tango
let g:bg_tango = 1
"============ TEST ====================================
function! TEST()
	echo getcwd()	
endfunction
nmap <F8>  :call TEST()<CR>

"=========== AUTOCMD======================================
if has("autocmd")
	"autocmd SessionLoadPost * source ~/.vim/syntax/tango.vim
	autocmd VimLeavePre * call SessionManager('SAVE', 'last_exit_backup')
	"autocmd CursorHold * call AutoSessionSave()
	"autocmd CursorHoldI * call AutoSessionSave()
	"autocmd VimEnter * call CscopeDBload(0)
	autocmd VimEnter * call CscopeDBLoad('',0)
endif
"============ Message ====================================
function! UserMSG( MSG )
	echo a:MSG	
endfunction
"============ Reg Diff ==================================
function! ShowDiff(a,b)
    " I expect neither string to contain '@@'
    let start = matchstr(a:a.'@@'.a:b, '^\zs\(.*\)\ze.\{-}@@\1.*$')
    let end= matchstr(a:a.'@@'.a:b, '^.\{-}\zs\(.*\)\ze@@.\{-}\1$')
    let a = a:a[len(start): -len(end)-1]
    let b = a:b[len(start): -len(end)-1]
    echo "identical beginning: ".strlen(start )." chars ->\n".start
    echo "identical ending   : ".strlen(end)." chars ->\n".end
    echo "typical to a       : ".strlen(a)." chars ->\n".a
    echo "typical to b       : ".strlen(b)." chars ->\n".b
endfunction

" A list for bookkeeping..
let g:diffreg_buffers = []

function! DiffRegs(reg1, reg2)
    " Preserve the unnamed register
    let s:nonamereg = @@
    let @@ = a:reg1
    " new window
    :new
    normal P
    setlocal nomodifiable
    setlocal buftype=nofile
    diffthis
    call add(g:diffreg_buffers, bufnr('%'))

    let @@ = a:reg2
    :vsp +enew
    normal P
    setlocal nomodifiable
    setlocal buftype=nofile
    diffthis
    call add(g:diffreg_buffers, bufnr('%'))

    let @@ = s:nonamereg
endfunction " DiffRegs(reg1, reg2)

" Function to wipe all buffers we're diffing with the function above
function! EndDiffs()
    for buffer in g:diffreg_buffers
        exe ':buffer '  . buffer
        diffoff
        quit
    endfor
    let g:diffreg_buffers = []
endfunction " EndDiffs()

vmap <silent>  ;d1  "ay
vmap <silent>  ;d2  "by
command! -nargs=* SD call ShowDiff(@b,@a)
command! -nargs=* DR call DiffRegs(@b,@a)
command! -nargs=* ED call EndDiffs()
"============ CSCOPE/ CTAGS===============================

function! IpcFuncDetector( FunctionName, option )

	let g:IsIpc=strpart(a:FunctionName,0,3)
	let g:IsOn=strpart(a:FunctionName,0,2)
	
	if ( g:IsIpc == "Ipc" && a:option == 'g' )
		let g:IpcFunctionName = strpart(a:FunctionName,3)
		echo ""
		execute 'scs find 'a:option "On".g:IpcFunctionName	
	elseif ( g:IsOn == "On" && a:option == 'c' )
		let g:IpcFunctionName = strpart(a:FunctionName,2)
		echo ""
		execute 'scs find 'a:option "Ipc".g:IpcFunctionName	
	else
		echo ""
		execute 'scs find 'a:option a:FunctionName 	
	endif
endfunction

nmap <C-\>g :call IpcFuncDetector( expand("<cword>") , "g")<CR>
nmap <C-\>s :call IpcFuncDetector( expand("<cword>") , "s")<CR>
nmap <C-\>c :call IpcFuncDetector( expand("<cword>") , "c")<CR>
nmap <C-\>t :call IpcFuncDetector( expand("<cword>") , "t")<CR>
nmap <C-\>e :call IpcFuncDetector( expand("<cword>") , "e")<CR>
nmap <C-\>f :call IpcFuncDetector( expand("<cword>") , "f")<CR>
nmap <C-\>i :call IpcFuncDetector( expand("<cword>") , "i")<CR>
nmap <C-\>d :call IpcFuncDetector( expand("<cword>") , "d")<CR>



function! CscopeDBLoad( NewDB, IsReload )
	if( a:IsReload == 1 )
		cs kill a
	endif

	let g:DBPath = ""
	let g:TagPath = ""

	if( a:NewDB != "")
		if ( a:NewDB == "sd4k" )
			let g:DBPath ="/home2/jinhwan/xm4k/sd4k_cscope.out"
			let g:TagPath ="/home2/jinhwan/xm4k/sd4k_tags"
		elseif ( a:NewDB == "hd4k" )
			let g:DBPath ="/home2/jinhwan/xm4k/hd4k_cscope.out"
			let g:TagPath ="/home2/jinhwan/xm4k/hd4k_tags"
		elseif ( a:NewDB == "xm4k" )
			let g:DBPath ="/home2/jinhwan/xm4k/xm4k_cscope.out"
			let g:TagPath ="/home2/jinhwan/xm4k/xm4k_tags"
		elseif ( a:NewDB == "abr" || a:NewDB == "sd2k" )
			let g:DBPath ="/home2/jinhwan/abr/cscope.out"
			set g:TagPath ="/home2/jinhwan/abr/tags"
		elseif ( a:NewDB == "tp1k" )
			let g:DBPath ="/home2/jinhwan/tp1k/cscope.out"
			let g:TagPath ="/home2/jinhwan/tp1k/tags"
		else
			echo "Not supported option :".a:NewDB
		endif

	else
		let g:CurrentDir = getcwd()
		if stridx(g:CurrentDir, "tp1k") >= 1
			let g:DBPath ="/home2/jinhwan/tp1k/cscope.out"
			let g:TagPath="/home2/jinhwan/tp1k/tags"
		elseif stridx(g:CurrentDir, "xm4k") >= 1
			let g:DBPath ="/home2/jinhwan/xm4k/sd4k_cscope.out"
			let g:TagPath ="/home2/jinhwan/xm4k/sd4k_tags"
		elseif stridx(g:CurrentDir, "abr" ) >= 1
			let g:DBPath ="/home2/jinhwan/abr/cscope.out"
			let g:TagPath ="/home2/jinhwan/abr/tags"
		endif
	endif

	if filereadable(g:DBPath)
		execute 'cs add 'g:DBPath	
	else
		echo a:NewDB." cscope file is not exist!"
	endif
	
	set tags=g:TagPath

endfunction
nmap <silent>  ;c  :call CscopeDBLoad('',1)<CR>

command! -nargs=* LC call CscopeDBLoad( '<args>', 0 )
command! -nargs=* RC call CscopeDBLoad( '<args>', 1 )
command! -nargs=* CC call CscopeDBLoad( '<args>', 1 )
"============ Session Save/Load===========================

let g:SessionPath=$HOME."/.vim/session/"

let g:AutoSaveTime=7200

let g:LastSessionSavedTime = localtime()
function! AutoSessionSave()
	if( (localtime() - g:LastSessionSavedTime) >= g:AutoSaveTime)

		let g:BackUpName =strftime("%y%m%d_%H%M%S")
		call SessionManager('BACKUP', g:BackUpName )
	endif
endfunction

function! SessionManager( SaveLoad, Path )

	let g:ThePath=g:SessionPath."session".".vim"
	if( a:Path != "")
		let g:ThePath=g:SessionPath.a:Path.".vim"
	endif


	if ( a:SaveLoad == "SAVE" )
		execute	'mksession!' g:ThePath

		if filereadable( g:ThePath )	
			echo "Session Saved. at" g:ThePath
			let g:LastSessionSavedTime = localtime()
		else
			echo "Can not Save the Session at" g:ThePath
		endif
	elseif ( a:SaveLoad == "LOAD" )
		execute	'source' g:ThePath

		echo "Session Loaded. from" g:ThePath
	elseif ( a:SaveLoad == "BACKUP" )
		let g:ThePath=g:SessionPath."auto_backup/".a:Path.".vim"

		execute	'mksession!' g:ThePath

		if filereadable( g:ThePath )	
			echo "Session Backuped. at" g:ThePath
			let g:LastSessionSavedTime = localtime()
		else
			echo "Auto Session Backup Fail." g:ThePath
		endif
	endif

endfunction

"============= Renaming in the VisualBlock ================
let g:BlockStartLine=0
let g:BlockEndLine=0

function! GetVisualBlockLineNum()
echo line("'>")."-".line("'<") + 1
endfunction
function! RenamingInTheVisualBlock(StartLine, EndLine, SrcWord, DstWord)
	
	echo a:StartLine."--".a:EndLine."--"."--".a:SrcWord."--".a:DstWord	
endfunction
"vmap <F9> :call GetVisualBlockLineNum()<CR>
command! -nargs=* WC call RenamingInTheVisualBlock( line("'>") ,line("'<") + 1, <f-args> )<CR>

"=============Highlight====================================
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap ;ah :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=2000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorMoved * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

if version >= 702
	nmap <silent> 1 :Mark <C-R>=expand("<cword>")<CR><CR>
endif
"========================DOXYGEN========================
nmap <silent> ;da  :DoxAuthor<CR>                                                                                                                                                                                                                                                                                                                           
nmap <silent> ;df  :Dox<CR>
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_authorName = "jinhwan <jinhwan@pinetron.com>"
"================= L9 LIB ==============================
"
"============== FuzzyFinder ============================
if version >= 702
	let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'FavFile':{}, 'Tag':{}, 'TaggedFile':{}}
	"let g:FuzzyFinderOptions.File.excluded_path ='\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.class$|\.settings$|CVS|.svn|((^|[/\\])\.[/\\]$)'
	let g:FuzzyFinderOptions.Base.ignore_case = 0

	nmap <silent>ff <ESC>:FufCoverageFile<CR>
	nmap <silent>fb <ESC>:FufBuffer<CR>
	nmap <silent>fd <ESC>:FufDir<CR>
endif
"============== DWM ================================
let g:dwm_map_keys=0
if !hasmapto('<Plug>DWMFocus')
  nmap <C-@> <Plug>DWMFocus
  nmap <C-Space> <Plug>DWMFocus
endif
"============== TagList ============================
nmap <silent> ;t :TlistToggle<CR>
"========= DIR DIFF =====================================
let g:DirDiffExcludes = ".svn,*.swap,*.swp,*.o,*.a"


"======== nmap ===========================================

let mapleader = ";"
"nnoremap * *``
"nnoremap * :keepjumps normal *''<CR>
nmap <silent>  ;sv  :source ~/.vimrc<CR> :call UserMSG("Vimrc file reloaded!")<CR>
nmap <silent>  ;ww  :w<CR>
nmap <silent>  ;qq  :q!<CR>
command! -nargs=* SS call SessionManager('SAVE', '<args>' ) 
command! -nargs=* LS call SessionManager('LOAD', '<args>' ) 
command! -nargs=* LLS call SessionManager('LOAD', 'last_exit_backup' ) 
"------Ctrl + F? -------
"F1
"nmap <C-F1> <Esc>:tabfir<CR>
"imap <C-F1> <Esc>:tabfir<CR>
"F2
"nmap <C-F2> <Esc>:tabfir<CR><Esc>:tabn<CR>
"imap <C-F2> <Esc>:tabfir<CR><Esc>:tabn<CR>
"F3
"nmap <C-F3> <Esc>:tabfir<CR><Esc>:tabn<CR><Esc>:tabn<CR>
"imap <C-F3> <Esc>:tabfir<CR><Esc>:tabn<CR><Esc>:tabn<CR>
"F4
"nmap <C-F4> <Esc>:tabfir<CR><Esc>:tabn<CR><Esc>:tabn<CR><Esc>:tabn<CR>
"imap <C-F4> <Esc>:tabfir<CR><Esc>:tabn<CR><Esc>:tabn<CR><Esc>:tabn<CR>
"F5
"F6
"nmap <C-F6> <Esc>:tabn<CR>
"F7
"F8
"F9
nmap <C-F9> <Down>[{<Down><Home>v]}<Up><End>zf
"imap <C-F9> <Down>[{<Down><Home>v]}<Up><End>zf
"F10
"F11
nmap <C-F11> <Esc>:tabp<CR>
nmap 9 <Esc>:tabp<CR>
imap <C-F11> <Esc>:tabp<CR>
"F12
nmap <C-F12> <Esc>:tabn<CR>
nmap 0 <Esc>:tabn<CR>
imap <C-F12> <Esc>:tabn<CR>

"------Meta + F? -------
"F1
"F2
"F3
"F4
"F5
"F6
"F7
"F8
"F9
"F10
"F11
nmap <M-F11> <Esc>:bprev<CR>
imap <M-F11> <Esc>:bprev<CR>
"F12
nmap <M-F12> <Esc>:bnext<CR>
imap <M-F12> <Esc>:bnext<CR>

"------Ctrl + Shift + F? -------
"------Ctrl + Shift + F? -------
"F1
"F2
"F3
"F4
"F5
"nmap [228;6z 20<C-W><
"nmap [15;6~ 20<C-W><
"F6
"nmap [229;6z 20<C-W>>
"nmap [17;6~ 20<C-W>>
"F7
"nmap [230;6z 10<C-W>-
"nmap [18;6~ 10<C-W>-
"F8
"nmap [231;6z 10<C-W>+
"nmap [19;6~ 10<C-W>+
"F9
"F10
"F11
"F12
"------Ctrl + Shift + KEY -------

"nmap <F10> :NERDTree<CR>
"nmap <F11> :TrinityToggleAll<CR>
"nmap <F11> :tabp<CR>
"nmap <F12> :tabn<CR>
"nmap [1;5H :tabfirst<CR>
"nmap [1;5F :tablast<CR>

"-----Ctrl + KEY ------------
"Ctrl+]
imap ` <Esc>
vmap ` <Esc>
"Ctrl+w s
nmap <silent> =  <C-W>s
"imap <silent> =  <C-W>s

"Ctrl+w v
nmap <silent> \ <C-W>v
"imap <silent> \ <C-W>v

"Ctrl+c
" copy to buffer
vmap <C-c> "+y
" paste from buffer
imap <C-y> "+p
nmap <C-y> "+p

" window focus switching
nmap [1;5A <C-W><Up>
nmap [A <C-W><Up>

nmap [1;5B <C-W><Down>
nmap [B <C-W><Down>

nmap [1;5D <C-W><Left>
nmap [D <C-W><Left>

nmap [1;5C <C-W><Right>
nmap [C <C-W><Right>

nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" window resizing
nmap OD 8<C-W><
"imap OD 8<C-W><
nmap OC 10<C-W>>
"imap OC 10<C-W>>
nmap OA 10<C-W>+
"imap OA 10<C-W>+
nmap OB 10<C-W>-
"imap OB 10<C-W>-\
"------Meta + KEY -------

"nmap <M-k> <C-W>k
"nmap <M-j> <C-W>j
"nmap <M-h> <C-W>h
"nmap <M-l> <C-W>l
"-----KEY Remap-------------\
"emacs keymap
"nmap <C-p> <Up>
"imap <C-p> <Up>
"nmap <C-n> <Down>
"imap <C-n> <Down>
"nmap <C-f> <Right>
"imap <C-f> <Right>
"nmap <C-b> <Left>
"imap <C-b> <Left>
"nmap <silent> <C-x><C-s> <Esc>:w<CR>
"imap <silent> <C-x><C-s> <Esc>:w<CR>
"nmap  <esc>u
"imap  <esc>u



"============== memo =========
"current word
"let wordUnderCursor = expand("<cword>")
"current line
"let currentLine   = getline(".")
"current time
"inoremap <F7> <C-R>=strftime("%y%m%d_%H%M%S")<CR>

