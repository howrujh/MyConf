"if filereadable("/etc/vimrc")
if 0
	source /etc/vimrc
else
	let g:os = "null"
	let g:uname = "null"
	if has("unix")
		let g:os = "unix"
		let g:uname = system("uname")
	elseif has("win32")
		let g:os = "win32"
	else
		let g:os = "unknown"
	endif

	if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	   set fileencodings=utf-8,latin1
	endif

	set nocompatible	" Use Vim defaults (much better!)
	set bs=indent,eol,start		" allow backspacing over everything in insert mode
	set viminfo='20,\"50	" read/write a .viminfo file, don't store more
				" than 50 lines of registers
	set history=50		" keep 50 lines of command line history
	set ruler

	if has("cscope") && filereadable("/usr/bin/cscope")
		set csprg=/usr/bin/cscope
		set csto=0
		set cst
		set nocsverb
		" add any database in current directory
		"    " else add database pointed to by environment
		if $CSCOPE_DB != ""
			cs add $CSCOPE_DB
		elseif filereadable("cscope.out")
			cs add cscope.out
		endif
		set csverb
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
"current file directory 
set autochdir
" Add full file path to your existing statusline
"set statusline+=%F
set laststatus=2


"use man page open in vim
runtime ftplugin/man.vim

filetype off "required for vundle
filetype plugin on
filetype plugin indent on     " required! for vundle

if( g:os == "unix" )
	let g:vundle_path = $HOME."/.vim/bundle/vundle"

	let g:vim_tmp_path = $HOME."/.vim/tmp"
elseif( g:os == "win32" )
	let g:vim_tmp_path = $HOMEDRIVE.$HOMEPATH."\\Documents\\vim_tmp"
endif

if isdirectory( g:vim_tmp_path ) == 0
	call system( "mkdir ".g:vim_tmp_path )
endif

"exec("set dir =".g:vim_tmp_path)
"exec("set bdir =".g:vim_tmp_path)

"============ VUNDLE  =================================
" NOTE: This Script Required Install VUNDLE Plugin
" VUNDLE INSTALL :
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"------------------------------------------------------
if isdirectory( g:vundle_path )

	set rtp+=~/.vim/bundle/vundle/

	call vundle#rc()
	"------ let Vundle manage Vundle--------
	" required! 
	if version >= 600
		Bundle 'gmarik/vundle'
	endif
	"------ My Bundles here ----------------
	if version >= 702
		Bundle 'howrujh/Mark.git'
	endif
	"------ original repos on github-------
	if version >= 703
	"	Bundle 'Valloric/YouCompleteMe.git'
	endif
	"Bundle 'tpope/vim-fugitive'
	"Bundle 'Lokaltog/vim-easymotion'
	"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
	"Bundle 'tpope/vim-rails.git'
	if version >= 700
		Bundle 'spolu/dwm.vim.git'
		Bundle 'oplatek/Conque-Shell'
		
	endif
	"-------vim-scripts repos--------------
	if version >= 702
		Bundle 'L9'
		Bundle 'FuzzyFinder'
		Bundle 'ZoomWin'
	endif

	if version >= 700
		Bundle 'OmniCppComplete'
		Bundle 'DirDiff.vim'
		Bundle 'Align'
		Bundle 'DoxygenToolkit.vim'
		Bundle 'bufexplorer.zip'
		Bundle 'vcscommand.vim'
	endif


	if version >= 600
		Bundle 'hexman.vim'
		Bundle 'taglist.vim'
		Bundle 'Tango-colour-scheme'
	endif

endif
"------ non github repos -------------
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

"============ VUNDLE END  ==============================


"============ TANGO COLOR SCHEME ======================
colorscheme tango
let g:bg_tango = 1
hi CursorLine term=none cterm=bold ctermfg=4
hi TabLineSel term=UnderLine cterm=bold,UnderLine guifg=DarkGreen guibg=Black ctermfg=DarkGreen ctermbg=Black
hi TabLine term=UnderLine cterm=bold,UnderLine ctermfg=White
hi TabLineFill term=UnderLine cterm=bold,UnderLine ctermfg=White ctermbg=Black gui=none guibg=Black
hi ModeMsg ctermfg=darkgreen
"============ TANGO COLOR SCHEME END ==================


"============ OMNICPPCOMPLETE =========================
set completeopt-=preview
"============ OMNICPPCOMPLETE END =====================


"============ TEST ====================================
function! TEST()
	echo getcwd()	
endfunction
"============ TEST END ================================

nmap <F5> :call CurrentFunc()<CR>
"nmap <F8> :call DebugPrintf()<CR>

func! CurrentFunc()
  " c-type code have remarkable definitions from other OO code.
	let l:line_bak = line(".")
	let l:colum_bak = col(".")
    let l:extension = expand("%:e")
	let l:error = 0

	echohl WarningMsg

    if l:extension == "c" || l:extension == "cpp" || l:extension == "cc" || l:extension == "h" || l:extension == "hh"
		let l:file_name = expand("%:r")
		exec "normal ][%b"
		let l:line_cur= line(".")
		let l:is_class= stridx(getline("."),"::")

		if l:is_class >= 0 "the function in the class
			let l:is_destructor= stridx(getline("."),"~")
			call cursor(l:line_cur, l:is_class)
			let l:class_name=expand("<cword>")
			call cursor(l:line_cur, l:is_class+3)
			let l:func_name=expand("<cword>")

			if l:is_destructor >= 0
				let @d="printf(\"\\x1b[32m===".l:class_name."::~".l:func_name." (%d)\\x1b[0m\\n\",__LINE__);"
			else
				let @d="printf(\"\\x1b[32m===".l:class_name."::".l:func_name." (%d)\\x1b[0m\\n\",__LINE__);"
			endif
	
		else
			let l:is_function= stridx(getline("."),"(")

			if l:is_function >= 0
				call cursor(l:line_cur, l:is_function)
				let l:func_name=expand("<cword>")
				let @d="printf(\"\\x1b[32m===".l:func_name." (%d)\\x1b[0m\\n\",__LINE__);"
			else
				echo "Error! Can not extract the function name"
				let	l:error =1
			endif
		endif	

		call cursor(l:line_bak, l:colum_bak)
		if l:error == 0
			exec "normal o"
			exec "normal \"dp" 
		endif

	else
		echo "Error! This type of file is not surpport yet"
	endif
	echohl None
endfunc " CurrentFunc

func! DebugPrintf(mode)
	if ( a:mode == 0 )
		let @d="printf(\"\\x1b[32m===%s(%d)  \\x1b[0m\\n\",__PRETTY_FUNCTION__,__LINE__);"
	else
		let @d="printk(\"\\x1b[32m===%s(%d)  \\x1b[0m\\n\",__PRETTY_FUNCTION__,__LINE__);"
	endif
	exec "normal o"
	exec "normal \"dp"
endfunc "DebugPrintf()

nmap <silent>  ;p :call DebugPrintf(0)<CR>
nmap <silent>  ;k :call DebugPrintf(1)<CR>

function! TEST1()
	echo "22"
	let a =system('xclip -o')
	if !v:shell_error

		echo "X11 Alive"
		return 0
	else
		echo "X11 Broken "
		return 1
	endif
	
endfunction



function! X11Clipboard(IsCopy)
	
	if ( a:IsCopy == 1 )
		let clip = getline(line('v'),line('.'))
		silent! exec "!echo '" . a:params . "' | xclip"
	elseif ( a:IsCopy == 0 )
		silent! exec "r!echo | xclip -o"
 
	endif
endfunction


"=========== AUTOCMD =====================================
if has("autocmd")
	"autocmd SessionLoadPost * source ~/.vim/syntax/tango.vim
	autocmd VimLeave * call SessionManager('SAVE', 'last_exit_backup')
	"autocmd CursorHold * call AutoSessionSave()
	"autocmd CursorHoldI * call AutoSessionSave()
	"autocmd VimEnter * call CscopeDBload(0)
"	autocmd VimEnter * call CscopeDBLoad('',0)
	autocmd VimEnter * call StartUpFunction()
	autocmd VimEnter * let g:StartPath= getcwd()
	autocmd BufEnter *.txt setlocal ft=txt
endif
"=========== StartUp Function =========================== 

function! StartUpFunction1()
"--------- Checking xclip is exist -----------------
	if !CheckProgramExist('xclip')
		"checking X connecton
		call system('xclip -o')
		if !v:shell_error
			vnoremap <C-c> "cy <esc>:call system('xclip', @c)<CR>
			nnoremap <C-c> "cyy <esc>:call system('xclip', @c)<CR>
			nnoremap <C-p> :r!xclip -o<CR>
		else
			vnoremap <C-c> "cy 
			nnoremap <C-c> "cyy
			nnoremap <C-p> "cp
		endif
	else
		vnoremap <C-c> "cy 
		nnoremap <C-c> "cyy
		nnoremap <C-p> "cp
	endif

	call CscopeDBLoad('',0)
endfunction

function! StartUpFunction()
	call CscopeDBLoad('',0)
"--------- Checking xclip is exist -----------------
	if !CheckProgramExist('xclip')
		"checking X connecton
		if filereadable($HOME."/bin/tmux_set_display.sh")
			call system('source $HOME."/bin/tmux_set_display.sh"')
		else
			echo "cant read"
		endif
		call system('xclip -o')
		if !v:shell_error
			vmap <C-c> "cy <esc>:call system('xclip', @c)<CR>
			nmap <C-c> "cyy <esc>:call system('xclip', @c)<CR>
			nmap <C-p> :r!xclip -o<CR>
		else
			vmap <C-c> "cy 
			nmap <C-c> "cyy
			nmap <C-p> "cp

		endif
	else
		vmap <C-c> "cy 
		nmap <C-c> "cyy
		nmap <C-p> "cp
	endif

endfunction

"=========== Chck Program Exist ==========================
function! CheckProgramExist(ProgramName)
	let hh=system('which '.a:ProgramName)
	if !v:shell_error
		return 0
	else
		return 1
	endif
endfunction

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

nmap <silent>  ;cd :call DirectoryChanger('0')<CR>
command! -nargs=* CD call DirectoryChanger( '<args>' )
function! DirectoryChanger( arg )

	exe ':lcd %:h'

endfunction

function! CscopeWM( FunctionName, option)
	let l:prev_win = winnr()
	call DWM_Stack(1)
	"call IpcFuncDetector( a:FunctionName, a:option )
	let l:result= IpcFuncDetector( a:FunctionName, a:option )

"	call DWM_Focus()
	wincmd H
	if ( l:result == -1 )
		exec l:prev_win . "wincmd w"
	endif

	return l:result
endfunction

function! IpcFuncDetector( FunctionName, option )

		
	if ( a:FunctionName != "" )
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
		return 0
	else
		return -1
	endif
endfunction

nmap <C-\>g :call CscopeWM( expand("<cword>") , "g")<CR>
nmap <C-\>s :call CscopeWM( expand("<cword>") , "s")<CR>
nmap <C-\>c :call CscopeWM( expand("<cword>") , "c")<CR>
nmap <C-\>t :call CscopeWM( expand("<cword>") , "t")<CR>
nmap <C-\>e :call CscopeWM( expand("<cword>") , "e")<CR>
nmap <C-\>f :call CscopeWM( expand("<cword>") , "f")<CR>
nmap <C-\>i :call CscopeWM( expand("<cword>") , "i")<CR>
nmap <C-\>d :call CscopeWM( expand("<cword>") , "d")<CR>


function! CscopeDBLoad( NewDB, IsReload )
	if( a:IsReload == 1 )
		cs kill a
	endif

	let l:DBPath = ""
	let l:tag_path = ""

	if( a:NewDB != "")
		if ( a:NewDB == "sd4k" )
			let l:DBPath =$HOME."/xm4k/sd4k_cscope.out"
			let l:tag_path=$HOME."/xm4k/sd4k_tags"
		elseif ( a:NewDB == "sd4kktt" )
			let l:DBPath =$HOME."/xm4k/sd4kktt_cscope.out"
			let l:tag_path=$HOME."/xm4k/sd4kktt_tags"
		elseif ( a:NewDB == "hd4k" )
			let l:DBPath =$HOME."/xm4k/hd4k_cscope.out"
			let l:tag_path=$HOME."/xm4k/hd4k_tags"
		elseif ( a:NewDB == "xm40" )
			let l:DBPath =$HOME."/xm4k/xm40_cscope.out"
			let l:tag_path=$HOME."/xm4k/xm40_tags"
		elseif ( a:NewDB == "xm4k" )
			let l:DBPath =$HOME."/xm4k/xm4k_cscope.out"
			let l:tag_path=$HOME."/xm4k/xm4k_tags"
		elseif ( a:NewDB == "abr" || a:NewDB == "sd2k" )
			let l:DBPath =$HOME."/abr/sd2k_cscope.out"
			let l:tag_path=$HOME."/abr/sd2k_tags"
		elseif ( a:NewDB == "tp1k" )
			let l:DBPath =$HOME."/tp1k/cscope.out"
			let l:tag_path=$HOME."/tp1k/tags"
		elseif ( a:NewDB == "libmpeg2" )
			let l:DBPath =$HOME."/work/libmpeg2-0.5.1/cscope.out"
			let l:tag_path=$HOME."/work/libmpeg2-0.5.1/tags"
		else
			echo "Not supported option :".a:NewDB
		endif

	else
		let g:CurrentDir = getcwd()
		if stridx(g:CurrentDir, "xm4k" ) >= 1
			let l:DBPath =$HOME."/xm4k/hd4k_cscope.out"
			let l:tag_path=$HOME."/xm4k/hd4k_tags"
		elseif stridx(g:CurrentDir, "abr" ) >= 1
			let l:DBPath =$HOME."/abr/sd2k_cscope.out"
			let l:tag_path=$HOME."/abr/sd2k_tags"
		elseif stridx(g:CurrentDir, "tp1k") >= 1
			let l:DBPath =$HOME."/tp1k/cscope.out"
			let l:tag_path="home2/jinhwan/tp1k/tags"
		elseif stridx(g:CurrentDir, "libmpeg2-0.5.1" ) >= 1
			let l:DBPath =$HOME."/work/libmpeg2-0.5.1/cscope.out"
			let l:tag_path=$HOME."/work/libmpeg2-0.5.1/tags"
		endif
	endif

	if filereadable(l:DBPath)
		execute "cs add "l:DBPath	
	endif

	if filereadable(l:tag_path)
		execute "set tags=".l:tag_path
	endif

endfunction

"nmap <silent>  ;c  :call CscopeDBLoad('',1)<CR>

command! -nargs=* LC call CscopeDBLoad( '<args>', 0 )
command! -nargs=* RC call CscopeDBLoad( '<args>', 1 )
command! -nargs=* CC call CscopeDBLoad( '<args>', 1 )
"============ Session Save/Load===========================

let g:SessionPath=$HOME."/.vim/session/"

if isdirectory( g:SessionPath ) == 0
	call system( "mkdir ".g:SessionPath )
endif
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




"======================= DOXYGEN =======================
nmap <silent> ;da  :DoxAuthor<CR>
nmap <silent> ;dm  :call AddModifySection()<CR>
nmap <silent> ;df  :Dox<CR>
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_authorName = "jinhwan <jinhwan@pinetron.com>"
"======================= DOXYGEN END ===================

"============== FuzzyFinder ============================
if version >= 702
	let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'FavFile':{}, 'Tag':{}, 'TaggedFile':{}}
	"let g:FuzzyFinderOptions.File.excluded_path ='\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.class$|\.settings$|CVS|.svn|((^|[/\\])\.[/\\]$)'
	let g:FuzzyFinderOptions.Base.ignore_case = 0

	nmap <silent>ff <ESC>:FufCoverageFile<CR>
	nmap <silent>fb <ESC>:FufBuffer<CR>
	nmap <silent>fd <ESC>:FufDir<CR>
endif
"============== FuzzyFinder END=========================

"============== DWM ================================
let g:dwm_map_keys=0
if !hasmapto('<Plug>DWMFocus')
  nmap <C-@> <Plug>DWMFocus
  nmap <C-Space> <Plug>DWMFocus
endif
if !hasmapto('<Plug>DWMNew')
  nmap <C-W>n <Plug>DWMNew
endif
if !hasmapto('<Plug>DWMClose')
  nmap <C-W>c <Plug>DWMClose
endif
"============== DWM END ============================

"============== VCSCOMMAND =========================
command! -nargs=* SVNDiff normal :VCSVimDiff <args><CR>
command! -nargs=* SVNBlame normal :VCSBlame <args><CR>
command! -nargs=* SVNLog normal :VCSLog <args><CR>
command! -nargs=* SVNStatus normal :VCSStatus <args><CR>


ca svndiff VCSVimDiff
ca svnblame VCSBlame
ca svnblame VCSBLog
ca svnstatus VCSStatus
"============== VCSCOMMAND END =====================


"============== TagList ============================
nmap <silent> ;t :TlistToggle<CR>
"============== TagList END ========================


"========= DIR DIFF =====================================
let g:DirDiffExcludes = ".svn,*.swap,*.swp,*.o,*.a"

"============ MARK =======================================
if version >= 702
	"nmap <silent> ;1 :Mark <C-R>=expand("<cword>")<CR><CR>
	nmap <silent> ;1 :Mark \<<C-R>=expand("<cword>")<CR>\><CR>
	nmap <silent>  ;mc  :MarkClear<CR>
	command! -nargs=* MC call mark#ClearAll() 
endif
"============ MARK END ===================================


"============ Man Page Open =======================================
nmap <silent> ;hh :Man <C-R>=expand("<cword>")<CR><CR>

"======== My Alias========================================


nmap <silent> ;dt  :diffthis<CR>
nmap <silent> ;do  :diffoff<CR>

"======== nmap ===========================================

let mapleader = '\'
"nnoremap * *``
"nnoremap * :keepjumps normal *''<CR>
nmap <silent>  ;sv  :source $MYVIMRC<CR> :call UserMSG(".vimrc file reloaded!")<CR>
nmap <silent>  ;ww  :w<CR>
nmap <silent>  ;qq  :exec DWM_Close()<CR>
nmap <silent>  ;nn  :call DWM_New()<CR>


nmap <silent> ;/ ^i//<Esc>

if version >= 700
nmap - gT
"nmap <C-[> <C-PageUp>
nmap = gt
"nmap <C-]> <C-PageDown>

nmap <C-W>! :tab split<CR> :tabm 99<CR>
command! TC exec "normal :tabclose<CR>"
command! -nargs=* TM exec "normal :tabmove ".'<args>'."<CR>"
endif
"command! -nargs=* TERM exec "normal :ConqueTerm ".'<args>'."<CR>"
command! -nargs=* TERM exec "normal :ConqueTerm bash<CR>"

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
"F8
"F9
nmap <C-F9> <Down>[{<Down><Home>v]}<Up><End>zf
"imap <C-F9> <Down>[{<Down><Home>v]}<Up><End>zf
"F10
"F11
nmap <C-F11> <Esc>:tabp<CR>
imap <C-F11> <Esc>:tabp<CR>

"F12
nmap <C-F12> <Esc>:tabn<CR>
imap <C-F12> <Esc>:tabn<CR>

"------Meta + F? -------
nmap <M-F11> <Esc>:bprev<CR>
imap <M-F11> <Esc>:bprev<CR>
"F12
nmap <M-F12> <Esc>:bnext<CR>
imap <M-F12> <Esc>:bnext<CR>

"------Ctrl + Shift + F? -------
"------Ctrl + Shift + F? -------
"nmap [228;6z 20<C-W><
"nmap [15;6~ 20<C-W><
"nmap [229;6z 20<C-W>>
"nmap [17;6~ 20<C-W>>
"nmap [230;6z 10<C-W>-
"nmap [18;6~ 10<C-W>-
"nmap [231;6z 10<C-W>+
"nmap [19;6~ 10<C-W>+
"------Ctrl + Shift + KEY -------

"nmap <F10> :NERDTree<CR>
"nmap <F11> :TrinityToggleAll<CR>
"nmap <F11> :tabp<CR>
"nmap <F12> :tabn<CR>
"nmap [1;5H :tabfirst<CR>
"nmap [1;5F :tablast<CR>
"-----Ctrl + KEY ------------
nnoremap <C-a> <Nop>
nnoremap <C-x> <Nop>

"Ctrl+]
"imap ` <Esc>
"vmap ` <Esc>
"Ctrl+w s
"nmap <silent> =  <C-W>s
"nmap <silent> 2  <C-W>s
"imap <silent> =  <C-W>s

"Ctrl+w v
"nmap <silent> \ <C-W>v
"nmap <silent> 3 <C-W>v
"imap <silent> \ <C-W>v

"Ctrl+c
" copy to buffer
"vmap <C-c> "+y
" paste from buffer
"imap <C-p> "+p
"nmap <C-p> "+p

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
"imap <C-u> <Undo>
"imap <M-u> <Undo>
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
" :put a, :1, 5 yank a
"	let l:split_word= split(getline("."), '::\zs')		
"	let l:buf2 = bufnr('%')
"	let l:win2 = winnr()
"	exec l:win1 . "wincmd w"
"	echo l:buf1." ".l:win1." ".l:buf2." ".l:win2

"com! -bang -range -nargs=* Align <line1>,<line2>call Align#Align(<bang>0,<q-args>)
