;; <GET ENV>
;; (if (eq system-type 'windows-nt)
;;     (add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
;;     (add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

(defconst os_win32  (eq system-type 'windows-nt) "윈도머신이면 참")
(defconst os_unix (eq system-type (or 'gnu/linux 'berkeley-unix)) "FreeBSD 머신이면 참")
(defconst os_mac (eq system-type 'darwin ) "Mac OS X 머신이면 참")

(defconst is_office (string-match "omg" system-name)"사무실의 pc 라면 참")
(defconst is_home (not is_office)"집의 pc 라면 참")

;(defconst extra-packages "~/.emacs.d" "내가 추가로 설치한 el 패키지들의 위치")


;; <SET ENV>
(setq user-mail-address (if is_home "howrujh@gmail.com" "jinhwan@pinetron.com"))
(setq user-full-name "jinhwan Lee")

;; <INTERFACE>
;(tool-bar-mode -1)
(if window-system
	(tool-bar-mode 0))
(menu-bar-mode -1)

;; <LAYOUT>

(setq-default c-default-style "linux"
			  c-basic-offset 4
			  tab-width 4
			  indent-tabs-mode t)

;; <FONT>
(if window-system
	(set-frame-font "Inconsolata 11"))

;; <INDENT>
;;(setq c-offsets-alist '((case-label . 4)))
(c-set-offset 'case-label '+)

;; <PACKAGE MANAGEMENT>
;; -- using package.el for install popular packages --

(setq pkg-list)
(add-to-list 'pkg-list 'cl)
(add-to-list 'pkg-list 'el-get)
(add-to-list 'pkg-list 'xcscope)

(add-to-list 'pkg-list 'ido)
;;(add-to-list 'pkg-list 'tabbar)
(add-to-list 'pkg-list 'color-theme)
;;(add-to-list 'pkg-list 'tango-2-theme)
;;(add-to-list 'pkg-list 'lush-theme)
(add-to-list 'pkg-list 'color-theme-solarized)
(add-to-list 'pkg-list 'highlight-symbol)

;;(add-to-list 'pkg-list 'smartparens)
;;(add-to-list 'pkg-list 'ecb)
(add-to-list 'pkg-list 'cedet)
;;(add-to-list 'pkg-list 'auto-complete)
(add-to-list 'pkg-list 'smex)
(add-to-list 'pkg-list 'winpoint)
;;(add-to-list 'pkg-list 'blank-mode)

(add-to-list 'pkg-list 'evil)
(add-to-list 'pkg-list 'undo-tree)

(add-to-list 'pkg-list 'sr-speedbar)
(add-to-list 'pkg-list 'ediff)
(add-to-list 'pkg-list 'yasnippet)
(add-to-list 'pkg-list 'iedit)
(add-to-list 'pkg-list 'flycheck)
;;(add-to-list 'pkg-list 'flymake-google-cpplint)
;;(add-to-list 'pkg-list 'flymake-cursor)
;;(add-to-list 'pkg-list 'google-c-style)
(add-to-list 'pkg-list 'cc-mode)
(add-to-list 'pkg-list 'multi-term)
(add-to-list 'pkg-list 'multiple-cursors)
;; (add-to-list 'pkg-list 'popwin)


(add-to-list 'pkg-list 'ace-window)
(add-to-list 'pkg-list 'smart-mode-line)

(add-to-list 'pkg-list 'buffer-move)
(add-to-list 'pkg-list 'ace-jump-mode)

(add-to-list 'pkg-list 'php-mode)
(add-to-list 'pkg-list 'visual-regexp)
;;(add-to-list 'pkg-list 'haskell-mode)
(add-to-list 'pkg-list 'go-mode)
;;(add-to-list 'pkg-list 'go-mode-autoloads)

(add-to-list 'pkg-list 'company)
;;(add-to-list 'pkg-list 'jedi)
;;(add-to-list 'pkg-list 'company-jedi)
(add-to-list 'pkg-list 'anaconda-mode)
(add-to-list 'pkg-list 'company-anaconda)


(when (require 'package nil 'noerror)

  (package-initialize)

  (setq package-archives '(
						   ("ELPA" . "http://tromey.com/elpa/")
						   ("melpa" . "http://melpa.milkbox.net/packages/")
						   ("gnu" . "http://elpa.gnu.org/packages/")
						   ("marmalade" . "http://marmalade-repo.org/packages/")))

  ;; loop function needs cl package
  (when (not (require 'cl nil 'noerror))
	(package-refresh-contents)
	(package-install 'cl)
	)

  (defun has-package-not-installed ()
	(loop for p in pkg-list
		  when (not (package-installed-p p)) do (return t)
		  finally (return nil)))
  (when (has-package-not-installed)
	;; Check for new packages (package versions)
	(message "%s" "Get latest versions of all packages...")
	(package-refresh-contents)
	(message "%s" " done.")
	;; Install the missing packages
	(dolist (p pkg-list)
	  (when (not (package-installed-p p))
		(package-install p))))

  )

;; -- using el-get for install from github, svn, etc..--
(when (require 'el-get nil 'noerror)
  ;; Set up packages
  (setq el-get-sources
		'(
		;  (:name rscope
		;		 :description "another interface to cscope tool."
		;		 :type github
		;		 :pkgname "rjarzmik/rscope")

		; (:name rxvt
		;		 :description "define function key sequences for rxvt"
		;		 :type http
		;		 :url "http://www.emacswiki.org/emacs/download/rxvt.el")

		;(:name multiple-cursors
		;	   :description "An experiment in adding multiple cursors to emacs"
		;	   :type github
		;	   :pkgname "magnars/multiple-cursors.el"
		;	   :features multiple-cursors)
		;(:name scala-mode
		;	   :description "Major mode for editing Scala code."
		;	   :type git
		;	   :url "https://github.com/scala/scala-dist.git"
		;	   :build `(("make -C tool-support/src/emacs" ,(concat "ELISP_COMMAND=" el-get-emacs)))
		;	   :load-path ("tool-support/src/emacs")
		;	   :features scala-mode-auto)
		;(:name rainbow-mode :type elpa)
		;(:name js2-mode
		;	   :website "https://github.com/mooz/js2-mode#readme"
		;	   :description "An improved JavaScript editing mode"
		;	   :type github
		;	   :pkgname "mooz/js2-mode"
		;	   :prepare (autoload 'js2-mode "js2-mode" nil t))
		  ))


  ;; install any packages not installed yet
  (mapc (lambda (f)
		  (let ((name (plist-get f :name)))
			(when (not (require name nil t)) (el-get-install name))))
		el-get-sources)

  )

;; <MAC OS X>
;(when os_mac
;  (setq mac-option-modifier 'alt)
(setq mac-command-modifier 'meta)
;  )


;; <RXVT>
;(when (require 'rxvt nil 'noerror)
;  )

;; <GDB>
(setq gdb-many-windows 1)

;; <MOUSE>
(xterm-mouse-mode t)

;; <WINNER MODE>
(setq winner-dont-bind-my-keys t)
(when (require 'winner nil 'noerror)
  (global-set-key (kbd "C-c w p") 'winner-undo)
  (global-set-key (kbd "C-c w n") 'winner-redo)
  (winner-mode t)
  )

;; <MOVE BUFFER>
(when (require 'buffer-move nil 'noerror)

  (global-set-key (kbd "C-c b <up>")     'buf-move-up)
  (global-set-key (kbd "C-c b <down>")   'buf-move-down)
  (global-set-key (kbd "C-c b <left>")   'buf-move-left)
  (global-set-key (kbd "C-c b <right>")  'buf-move-right)
  )

;; <NXML MODE>
(when (require 'nxml-mode nil 'noerror)
  (setq nxml-child-indent 4)
  )


;; <CC MODE>
(when (require 'cc-mode nil 'noerror)
  )


;; <PHP MODE>
(when (require 'php-mode nil 'noerror)
  )

;; <GO MODE>
(when (require 'go-mode-autoloads nil 'noerror)
  )


;; <COMPANY MODE>
(when (require 'company nil 'noerror)
  (add-hook 'after-init-hook 'global-company-mode)
  )

;; <ANACONDA MODE>
(when (require 'anaconda-mode nil 'noerror)
  (when (require 'company-anaconda nil 'noerror)
	(add-to-list 'company-backends 'company-anaconda)
	)
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'eldoc-mode)  
  )

;; ;; <JEDI>
;; (when (require 'jedi nil 'noerror)
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   )


;; (when (require 'company-jedi nil 'noerror)
;;   (defun my/python-mode-hook ()
;; 	(add-to-list 'company-backends 'company-jedi))

;;   (add-hook 'python-mode-hook 'my/python-mode-hook)
;;   )

;; <IEDIT MODE>
(when (require 'iedit nil 'noerror)
  (define-key global-map (kbd "C-c ;") 'iedit-mode)
  )

;; <VISUAL REGEXP>
(when (require 'visual-regexp nil 'noerror)
;;  (global-set-key (kbd "C-s") 'vr/isearch-forward)
;;  (global-set-key (kbd "C-r") 'vr/isearch-backward)
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  ;; if you use multiple-cursors, this is for you:
  (when (require 'multiple-cursors nil 'noerror)
	(define-key global-map (kbd "C-c c r") 'vr/mc-mark))
  )


;; <DESKTOP SAVE MODE>
;;(desktop-save-mode 1)

;; <SHOW PAREN MODE>
;; highlight pare charecters
(show-paren-mode 1)

;; <MULTIPLE CURSORS>
(when (require 'multiple-cursors nil 'noerror)
  (global-set-key (kbd "C-c c m") 'mc/edit-lines)
  (global-set-key (kbd "C-c c p") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c c n") 'mc/mark-next-like-this)
  )

;; ;; <POPWIN>
;; (when (require 'popwin nil 'noerror)
;;   (popwin-mode 1)
;;   ;(setq popwin:reuse-window popwin:popup-window)
;;   ;(setq popwin:close-popup-window-timer-interval 0.005)
  
;;   (push '("*cscope*" :position bottom :height 0.2) popwin:special-display-config)
;;   ;;(push '(cscope-list-entry-mode :position bottom :height 0.2) popwin:special-display-config)
;;   (push '("*Help*" :position bottom :height 0.3 ) popwin:special-display-config)
;;   (push '(vc-annotate-mode :position top :height 0.35) popwin:special-display-config)
;;   (push "*Shell Command Output*" popwin:special-display-config)

;;   (push '("\\.[cChH]" :regexp t :position top :height 0.25 :noselect t) popwin:special-display-config)
;;   (push '("^\\.el" :regexp t :position top :height 0.25 :noselect t) popwin:special-display-config)
;;   (push '("Makefile" :regexp t :position top :height 0.25 :noselect t) popwin:special-display-config)
;;   (push '("^\\.mk" :regexp t :position top :height 0.25 :noselect t) popwin:special-display-config)

;;   (defun my:before-popup()

;; 	;;(popwin:close-popup-window t)
;; 	(if (eq major-mode "cscope-list-entry-mode")
;; 		(message "before-popup-hook")
;; 		(popwin:close-popup-window-timer)
;; 		;;(popwin:close-popup-window)
;; 	  )
;; 	)

  
;;   (defun my:after-popup()
;; 	;(message "after-popup-hook")
;; 	;(popwin:close-popup-window-timer)
;; 	)
  
;;   (add-hook 'popwin:before-popup-hook 'my:before-popup)
;;   (add-hook 'popwin:after-popup-hook 'my:after-popup)
;;   )


  
;; <COLOR THEME>
(when (require 'color-theme nil 'noerror)
  (when (require 'color-theme-solarized nil 'noerror)
	(add-hook 'window-setup-hook
			  (lambda()
				(load-theme 'solarized t)
				(setq solarized-termcolors 256)
				(set-frame-parameter nil 'background-mode 'dark)
				(set-terminal-parameter nil 'background-mode 'dark)
				(enable-theme 'solarized)
				)
			  )
   	)

  ;; (set-terminal-parameter nil 'background-mode 'dark)	
  ;;(require 'tango-2-theme)
  ;;(load-theme 'tango-dark t)
  ;;(load-theme 'lush t)
  )



;; TRANSPARENT BG COLOR

(defun on-after-init ()

  ;; for terminal using
  (unless (display-graphic-p (selected-frame))
	(set-face-background 'default "unspecified-bg" (selected-frame)))


  ;; for gui using
  ;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
  (set-frame-parameter (selected-frame) 'alpha '(85 50))
  (add-to-list 'default-frame-alist '(alpha 85 50))
)

;;(add-hook 'window-setup-hook 'on-after-init)



;; <SMART MODE LINE>
(when (require 'smart-mode-line nil 'noerror)
  (setq sml/no-confirm-load-theme t)

  (when (require 'rich-minority nil 'noerror)
	;; hide minor modes
	(add-to-list 'rm-excluded-modes " Undo-Tree")
	(add-to-list 'rm-excluded-modes " yas")
	(add-to-list 'rm-excluded-modes " Abbrev")

	)

  ;; directory replace
  (add-to-list 'sml/replacer-regexp-list '("^~/xm4k/" ":ABR:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/abr/" ":ABR:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/github/" ":GIT:") t)
  ;; Added in the right order, they even work sequentially:
  ;(add-to-list 'sml/replacer-regexp-list '("^:ABR:app/dvr_app_v2" ":ABR:APPV2:") t)

  (add-to-list 'sml/replacer-regexp-list '("^:ABR:\\(.*\\)/dvr_app_v\\(.?\\)/" ":A\\2:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/hictrl\\(.?\\)/" ":A\\1:HI\\3:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/osd/" ":A\\1:OSD:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):OSD:windows/" ":A\\1:OSD:W:") t)

  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/diskman/" ":A\\1:DISK:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/ioman/" ":A\\1:IO:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/monitor/" ":A\\1:MON:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/ipreceiver/" ":A\\1:IP:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/network/" ":A\\1:NET:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/playback/" ":A\\1:PB:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):\\(.*\\)/recorder/" ":A\\1:REC:") t)

  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):util/" ":A\\1:U:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:A\\(.?\\):include/" ":A\\1:INC:") t)

  (add-to-list 'sml/replacer-regexp-list '("^:ABR:\\(.*\\)/font/" ":F:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:F:res_v\\(.?\\)/" ":F:RES\\1:") t)

  ;(setq sml/shorten-directory nil)
  ;(setq sml/shorten-modes nil)
  (setq sml/name-width 34)
  (setq sml/mode-width 12)
  (sml/apply-theme 'dark)
  (sml/setup)

  )

;; (when (require 'smartparens nil 'noerror)
;;   (require 'smartparens-config)
;;   (smartparens-global-mode t)
;;   )

;; <AUTO COMPLETE>
;; (when (require 'auto-complete nil 'noerror)
;;   (when (require 'auto-complete-config nil 'noerror)
;; 	(ac-config-default)
;; 	)

;;   (defun my:ac-c-header-init ()
;; 	(require 'auto-complete-c-headers)
;; 	(add-to-list 'ac-sources 'ac-source-c-headers)
;; 	;(add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include")
;; 	)

;;   ;(add-hook 'c++-mode-hook 'my:ac-c-header-init)
;;   ;(add-hook 'c-mode-hook 'my:ac-c-header-init)
  
;;  )





;; <CEDET MODE>
(when (require 'cedet nil 'noerror)
;; turn on Semantic
  (semantic-mode 1)

  (global-semanticdb-minor-mode 1)
  (global-semantic-idle-scheduler-mode 1) ;The idle scheduler with automatically reparse buffers in idle time.
  
  ;; (add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
  ;; (add-hook 'c++-mode-common-hook 'my:add-semantic-to-autocomplete)

  ;; (defun my:add-semantic-to-autocomplete()

  ;; 	(add-to-list 'ac-sources 'ac-source-semantic)
  ;; )

  ;; Enable EDE (Project Management) features
  (global-ede-mode 1)

  ;TODO: set dynamic project path assign function
  (when is_office
	(setq macro-path '("~/abr/app/dvr_app_v2/include/configs/pdrhd4k_config.h"))
	
	(setq inc-path '("~/abr/app/dvr_app_v2/include/"
					 "~/abr/app/dvr_app_v2/src/osd/olib/"
					 "../"
					 "~/abr/sdk/hi3531-sdk-1.0.9.0/src/mpp/include_hi3531/"
					 "~/abr/sub/onvif/elements/5003.onvif/inc/"
					 ))
	
	(setq sys-inc-path '("~/abr/kernel/linux-3.0.8-hisi-pdr/include/linux/"
						 "/opt/hisilicon/arm-hisiv200-linux/target/armv7a_soft/include/"
						 ))
	
	(ede-cpp-root-project "ABR_PROJECT"
						  :file "~/abr/Makefile" 
						  :include-path inc-path
						  :system-include-path sys-inc-path
						  :spp-files macro-path
						  )
	)

  ;(global-semantic-idle-completions-mode 1) ;Display a tooltip with a list of possible completions near the cursor.
  ;(global-semantic-idle-summary-mode 1) ;Display a tag summary of the lexical token under the cursor.
  )




;; <YASNIPPET>
(when (require 'yasnippet nil 'noerror)
  (add-to-list 'yas/snippet-dirs "~/.emacs.d/myel/snippets")
  (yas-global-mode 1)
  )


;; <SNIPPET>
;;;; snippet.el
;; 이정도만 알아두면 쓰는데 지장없다.
;; $${blahblah} blahblah 기본값가진 필드
;; blahblah$> blahblah 입력후 인덴트
;; $. 커서위치
;; \n newline
;; 보기 흉해서 뉴라인을 모두 \n 으로 적어뒀으니 수정할 일이 있으면 \n
;; 을 뉴라인으로 바꿔서 수정후 다시 \n 으로 바꿔주자.
;(when (require 'snippet nil 'noerror) 
;  (defun install-c++-snippet ()
;	(abbrev-mode 1)
;	(snippet-with-abbrev-table
;	 'c++-mode-abbrev-table
;	 ("classx" . "class $${class}$>\n{$>\npublic:$>\n$${class}();$>\n~$${class}();$>\nprivate:$>\n$${class}(const $${class}& _);$>\n$${class}& operator=(const $${class}& _);$>\n};\n")
;	 ("doxx" . "/**$>\n* \\brief $${brief}$>\n*$>\n* $.$>\n*/$>")
;	 ))
;  (add-hook 'c++-mode-hook 'install-c++-snippet)
;  )



;; <FLYCHECK>
;; (when (require 'flycheck nil 'noerror)
;;   (add-hook 'after-init-hook #'global-flycheck-mode)
;;   )



;; <FLYMAKE GOOGLE CPPLINT>
;; wget http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py
(defun my:flymake-google-init()
  (when (require 'flymake-google-cpplint nil 'noerror)
	(when (require 'flymake-cursor nil 'noerror)
	;  (custom-set-variables
	;  '(flymake-google-cpplint-command "~/scripts/cpplint.py"))
	  (flymake-google-cpplint-load)
	  )
	)
  )
;(add-hook 'c-mode-hook 'my:flymake-google-init)
;(add-hook 'c++-mode-hook 'my:flymake-google-init)

;; <GOOGLE C STYLE>
;(require 'google-c-style)
;(add-hook 'c-mode-common-hook 'google-set-c-style)
;(add-hook 'c-mode-common-hook 'google-make-newline-indent)


;; <CSCOPE>
;;(setq cscope-initial-directory "~/github/opengles2-book-sample/LinuxX11/")
;;(setq cscope-database-file "cscope.out")

;( setq pwd  ( getenv "PWD" ))

(when (require 'xcscope nil 'noerror)

  (setq my:cscope-preview-window nil)
  
  (defun my:cscope-init()
	(setq cscope-close-window-after-select t)

	;; (setq cscope-index-file "hd41_cscope.files")
	(cscope-minor-mode t)
	)

  (add-hook 'c++-mode-hook 'my:cscope-init)
  (add-hook 'c-mode-hook 'my:cscope-init)
  (add-hook 'makefile-mode-hook 'my:cscope-init)

;;   (eval-after-load "xcscope"

;; 	'(defun cscope-show-entry-other-window ()
;; 	   "Display the entry at point in other window.
;; Point is not saved on mark ring."
;; 	   (interactive)

;; 	   (if (or (eq my:cscope-preview-window nil) (not (popwin:window-deletable-p my:cscope-preview-window)))
;; 	   	  (setq my:cscope-preview-window (nth 1 (popwin:create-popup-window 0.3 'top t))))

;; 	   ;; (let ((navprops (cscope-get-navigation-properties)))
;; 	   ;; 	 (cscope-show-entry-internal navprops nil my:cscope-preview-window nil)
;; 	   ;; 	 )
;; 	   ))


  ;; (defun my:cscope-select-entry-specified-window()
  ;; 	;"Open in specific window"
  ;; 	(interactive)
  ;; 	(setq old-point (point))
  ;; 	(setq prev_win (selected-window))

  ;; 	(if (or (eq my:cscope-preview-window nil) (not (popwin:window-deletable-p my:cscope-preview-window)))
  ;; 		(setq my:cscope-preview-window (nth 1 (popwin:create-popup-window 0.4 'top t))))

  ;; 	(cscope-select-entry-specified-window my:cscope-preview-window)

  ;; 	(set-window-point prev_win old-point)
  ;; 	;; (if cscope-close-window-after-select
  ;; 	;; 	(delete-windows-on cscope-output-buffer-name))
  ;; )

  ;; (defun my:cscope-show-entry-specified-window()
  ;; 	;"Open in specific window"
  ;; 	(interactive)

  ;; 	;; (if (or (eq my:cscope-preview-window nil) (not (popwin:window-deletable-p my:cscope-preview-window)))
  ;; 	;; 	(setq my:cscope-preview-window (nth 1 (popwin:create-popup-window 0.4 'top t))))
	
  ;; 	(popwin:create-popup-window 20 'top nil)

  ;; 	;; (let (navprops (cscope-get-navigation-properties))

  ;; 	;;   (cscope-show-entry-internal navprops nil my:cscope-preview-window))

  ;; 	;; (let (navprops (cscope-get-navigation-properties)))
  ;; 	;; (cscope-show-entry-internal navprops t my:cscope-preview-window)
  ;; 	;; (if cscope-close-window-after-select
  ;; 	;; 	(delete-windows-on cscope-output-buffer-name))
  ;; )

  
  
  ;; (defvar my:cscope-local-keymap
  ;; 	(let ((map (make-keymap)))
  ;; 	  (suppress-keymap map)
  ;; 	  ;; The following section does not appear in the "Cscope" menu.

  ;; 	  (define-key map (kbd "SPC") 'my:cscope-show-entry-specified-window)

  ;; 	  ;; (define-key map (kbd "\r") 'my:cscope-select-entry-specified-window)


  ;; 	  map)
  ;; 	"The custom *cscope* buffer keymap")

  ;; (defun my:cscope-local-map()
  ;; 	(use-local-map my:cscope-local-keymap)
  
  ;; 	)

  ;; (add-hook 'cscope-list-entry-hook 'my:cscope-local-map)
)


;; <ACE JUMP MODE>
(when (require 'ace-jump-mode nil 'noerror)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  )

;; <ACE JUMP MODE>
(when (require 'ace-window nil 'noerror)
  (global-set-key (kbd "C-x o") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-scope 'frame)
  )

;; <HIGHLIGHT>
(when (require 'highlight-symbol nil 'noerror)

  (global-set-key (kbd "C-c 1") 'highlight-symbol-at-point)
  (global-set-key (kbd "C-c *") 'highlight-symbol-next)
  (global-set-key (kbd "C-c #") 'highlight-symbol-prev)
  )

;; <HIDE-IFDEF-MODE>
;(add-hook 'c++-mode-hook
;   '(lambda ()
;      (hide-ifdef-mode t)
;	   (setq hide-ifdef-initially t)
;	   (setq hide-ifdef-shadow t)
;    ))

(defun my-c-mode-font-lock-if0 (limit)
  (save-restriction
	(widen)
	(save-excursion
	  (goto-char (point-min))
	  (let ((depth 0) str start start-depth)
		(while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
		  (setq str (match-string 1))
		  (if (string= str "if")
			  (progn
				(setq depth (1+ depth))
				(when (and (null start) (looking-at "\\s-+0"))
				  (setq start (match-end 0)
						start-depth depth)))
			(when (and start (= depth start-depth))
			  (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
			  (setq start nil))
			(when (string= str "endif")
			  (setq depth (1- depth)))))
		(when (and start (> depth 0))
		  (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)

(defun my-c-mode-if0-hook ()
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

(add-hook 'c-mode-common-hook 'my-c-mode-if0-hook)


;; <DOXYGEN STYLE FUNCTION COMMENT>
(add-to-list 'load-path "~/share/emacs/site-lisp")
(when (require 'doxymacs nil 'noerror)

  (defun my:doxy-func-comment()
	"Write doxygen style comment"
	(interactive)
	(let* ((next-func-alist (doxymacs-find-next-func))
		   (func-name (cdr (assoc 'func next-func-alist)))
		   (params-list (cdr (assoc 'args next-func-alist)))
		   (return-name (cdr (assoc 'return next-func-alist)))
		   (snippet-text "")
		   (idx 1))
	  (setq snippet-text (format "/**\n * \@brief ${1:%s}\n * \n" func-name))
	  (setq idx 2)
	  (dolist (param params-list)
		(unless (string= param "this")
		  (setq snippet-text (concat snippet-text
									 (format " * \@param %s ${%d:}\n" param idx)))
		  (setq idx (+ 1 idx))))
	  (when (and return-name (not (string= return-name "void")))
		(setq snippet-text (concat snippet-text
								   (format " * \@return ${%d:%s}\n" idx return-name))))
	  (setq snippet-text (concat snippet-text " */"))
	  (yas/expand-snippet snippet-text))
	)

  ;(global-set-key (kbd "C-c d f") 'my:doxy-func-comment)
  (global-set-key (kbd "C-c d f") 'doxymacs-insert-function-comment)
  (global-set-key (kbd "C-c d m") 'doxymacs-insert-member-comment)
  (global-set-key (kbd "C-c d c") 'doxymacs-insert-file-comment)
  )


;; <DIFF REGION>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diff-region* - Diff two regions
;;
;;  To compare two regions, select the first region
;; and run `diff-region`.  The region is now copied
;; to a seperate diff-ing buffer.  Next, navigate
;; to the next region in question (even in another file).
;; Mark the region and run `diff-region-now`, the diff
;; of the two regions will be displayed by ediff.
;;
;;  You can re-select the first region at any time
;; by re-calling `diff-region`.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun diff-region ()
  "Select a region to compare"
  (interactive)
  (when (use-region-p)  ; there is a region
	(let (buf)
	  (setq buf (get-buffer-create "*Diff-regionA*"))
	  (save-current-buffer
		(set-buffer buf)
		(erase-buffer))
	  (append-to-buffer buf (region-beginning) (region-end)))
	)
  (message "Now select other region to compare and run `diff-region-now`")
  )

(defun diff-region-now ()
  "Compare current region with region already selected by `diff-region`"
  (interactive)
  (when (use-region-p)
	(let (bufa bufb)
	  (setq bufa (get-buffer-create "*Diff-regionA*"))
	  (setq bufb (get-buffer-create "*Diff-regionB*"))
	  (save-current-buffer
		(set-buffer bufb)
		(erase-buffer))
	  (append-to-buffer bufb (region-beginning) (region-end))
	  (ediff-buffers bufa bufb))
	)
  )

(global-set-key (kbd "C-c d 1") 'diff-region)
(global-set-key (kbd "C-c d 2") 'diff-region-now)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; <COMMENT OR UNCOMMNT REGION>
(global-set-key (kbd "C-c /") 'comment-or-uncomment-region)

;; <GOTO LINE>
(global-set-key (kbd "C-c j") 'goto-line)

;; <WHICH FUNCTION MODE>
(defun my:which-func()
  (which-func-mode 1)
  )

(add-hook 'c++-mode-hook 'my:which-func)
(add-hook 'c-mode-hook 'my:which-func)



;; <IDO-MODE>
(setq confirm-nonexistent-file-or-buffer nil)
(when (require 'ido nil 'noerror)

  (ido-mode 1)
  (ido-everywhere 1)
  (setq ido-enable-flex-matching t)
  (setq ido-create-new-buffer 'always)
  (setq ido-enable-tramp-completion nil)
;(setq ido-enable-last-directory-history nil)
  (setq ido-confirm-unique-completion nil) ;; wait for RET, even for unique?
  (setq ido-show-dot-for-dired t) ;; put . as the first item
;(setq Ido-use-filename-at-point t) ;; prefer file names near point
;(setq ido-ignore-buffers '("*scratch*" "*Messages*"))
  (setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
							 "*Ediff" "**.~**~"
							 "*Messages*" "*scratch*" "Async Shell Command"))
  )
;; <UNDO-TREE>
(when (require 'undo-tree nil 'noerror)
  (global-undo-tree-mode 1)
;(global-set-key (kbd "C-?") 'undo-tree-redo)
;(global-set-key (kbd "C-z") 'undo-tree-undo) ; 【Ctrl+z】
;(global-set-key (kbd "C-S-z") 'undo-tree-redo) ; 【Ctrl+Shift+z】; Mac style
  )

;; <EVIL-MODE>
(when (require 'evil nil 'noerror)
  ;(evil-mode nil)
  )

;; <SMEX>
(when (require 'smex nil 'noerror)
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  )

;; <WINPOINT>
(when (require 'winpoint nil 'noerror)
  (winpoint-mode 1)
  )

;; <BLANK-MODE>
;; (when (require 'blank-mode nil 'noerror)

;;   )

;; <VC>
(when (require 'vc nil 'noerror)
  (add-hook 'vc-annotate-mode-hook 'my:kill-buffer-local-key)
  (add-hook 'vc-svn-log-view-mode-hook 'my:kill-buffer-local-key)
  
  )

;; <SR-SPEEDBAR>
(when (require 'sr-speedbar nil 'noerror)
  
  )


;; <EDIFF>
(when (require 'ediff nil 'noerror)
  ;(setq ediff-keep-variants nil)
  (add-hook 'ediff-before-setup-hook
			(lambda ()
			  (setq ediff-saved-window-configuration (current-window-configuration))))

  (add-hook 'ediff-cleanup-hook
			(lambda ()
			  (ediff-janitor nil t)))

  (add-hook 'ediff-quit-hook
			(lambda ()
			  (set-window-configuration ediff-saved-window-configuration))
			)
  

  
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-merge-split-window-function 'split-window-horizontally)
  )
;; <ECB>
;(require 'cl)
;(require 'ecb)

;; <MULTI-TERM>
(when (require 'multi-term nil 'noerror)

  (setq multi-term-program "/bin/bash")
  (global-set-key (kbd "C-c t n") 'multi-term)
  (global-set-key (kbd "C-c t -") 'multi-term-prev)
  (global-set-key (kbd "C-c t =") 'multi-term-next)
  )

;; <SATELLITE WINDOW>
(defun mark-this-window-as-satellite ()
  "Mark the current window as the satellite window."
  (interactive)
  (mapc (lambda (win) (set-window-parameter win 'satellite nil))
	(window-list))
  (set-window-parameter nil 'satellite t)
  (message "Window: %s is now the satellite window." (selected-window)))

(defun get-satellite-window ()
  "Find and return the satellite window or nil if non exists."
  (find-if (lambda (win) (window-parameter win 'satellite)) (window-list)))



(defun display-buffer-in-satellite (buffer ignore)
  "Display the buffer in the satellite window, or the first window \
	it finds if there is no satellite."
  (let ((satellite-window (or (get-satellite-window)
							  (first (window-list)))))
	(select-window satellite-window)
	(display-buffer-same-window buffer nil)
	(display-buffer-record-window 'reuse satellite-window buffer)
	satellite-window))


;(push '("\\*Result*" display-buffer-in-satellite) display-buffer-alist)
;(global-set-key (kbd "C-c w s") 'mark-this-window-as-satellite)

;(defun display-buffer-in-current-window (buffer ignore)
;  "Display the buffer in the current window."
;
;  (let ((satellite-window (selected-window)))
;    (select-window satellite-window)
;    (display-buffer-same-window buffer nil)
;    (display-buffer-record-window 'reuse satellite-window buffer)
;    satellite-window))

(setq my:use-window-manager t)
(defun my:toggle-window-manager()
  (interactive)

  (setq my:use-window-manager (not my:use-window-manager))
  (message "window manager %s" my:use-window-manager)
  )

(global-set-key (kbd "C-c w m") 'my:toggle-window-manager)

(defun my:display-buffer-in-info-window (buffer ignore)
  "Display cscope buffer in info window"
  (when my:use-window-manager
	(display-buffer-at-bottom buffer '((side . bottom) (window-height . 8)))
  ))

(defun my:display-buffer-in-preview-window (buffer ignore)
  "Display source code in preview window"

  (when my:use-window-manager
	(setq info-list '(cscope-list-entry-mode))

	(dolist (l info-list)
	  (when (eq l major-mode)
		(display-buffer-in-side-window buffer '((side . top) (window-height . 12)))
		))
	)
  )

(defun my:display-buffer-in-top-window (buffer ignore)
  "Display the buffer in the top window."
  (when my:use-window-manager
	(display-buffer-in-side-window buffer '((side . top)))
  ))

(defun my:display-buffer-in-bottom-window (buffer ignore)
  "Display the buffer in the bottom window."
  (when my:use-window-manager
	(display-buffer-in-side-window buffer '((side . bottom)))
  ))

(defun my:display-buffer-in-left-window (buffer ignore)
  "Display the buffer in the left window."
  (when my:use-window-manager
	(display-buffer-in-side-window buffer '((side . left)))
  ))

(defun my:display-buffer-in-right-window (buffer ignore)
  "Display the buffer in the right window."
  (when my:use-window-manager
	(display-buffer-in-side-window buffer '((side . right)))
  ))



(push '("\\*[+]*" my:display-buffer-in-bottom-window) display-buffer-alist)
(push '("\\.el" my:display-buffer-in-preview-window) display-buffer-alist)
(push '("\\.mk" my:display-buffer-in-preview-window) display-buffer-alist)
(push '("[Mm]akefile" my:display-buffer-in-preview-window) display-buffer-alist)
(push '("\\.[cChH]" my:display-buffer-in-preview-window) display-buffer-alist)


;; <SCROLL WITHOUT CURSOR MOVE>
(defun scroll-in-place (scroll-up)
  "Scroll window up (or down) without moving point (if possible).
SCROLL-Up is non-nil to scroll up one line, nil to scroll down."
  (interactive)
  (let ((pos (point))
				(col (current-column))
				(up-or-down (if scroll-up 1 -1)))
		(scroll-up up-or-down)
		(if (pos-visible-in-window-p pos)
				(goto-char pos)
		  (if (or (eq last-command 'next-line)
						  (eq last-command 'previous-line))
				  (move-to-column temporary-goal-column)
				(move-to-column col)
				(setq temporary-goal-column col))
		  (setq this-command 'next-line))))

(defun scroll-up-in-place ()
  "Scroll window up without moving point (if possible)."
  (interactive)
  (scroll-in-place t))

(defun scroll-down-in-place ()
  "Scroll window up without moving point (if possible)."
  (interactive)
  (scroll-in-place nil))

(global-set-key (read-kbd-macro "M-n") 'scroll-up-in-place)
(global-set-key (read-kbd-macro "M-p") 'scroll-down-in-place)

;; <TOGGLE WINDOW DEDICATION>

(defun toggle-window-dedicated ()

  "Toggle whether the current active window is dedicated or not"

  (interactive)

  (message

   (if (let (window (get-buffer-window (current-buffer)))

		 (set-window-dedicated-p window

								 (not (window-dedicated-p window))))

	   "Window '%s' is dedicated"

	 "Window '%s' is normal")

   (current-buffer)))

(global-set-key (kbd "C-c w l") 'toggle-window-dedicated)

;; <MOVE BETWEEN '{' and '}'>
(defun match-paren ()
 "% command of vi"
 (interactive)
 (let ((char (char-after (point))))
   (cond ((memq char '(?\( ?\{ ?\[))
		  (forward-sexp 1)
		  (backward-char 1))
		 ((memq char '(?\) ?\} ?\]))
		  (forward-char 1)
		  (backward-sexp 1))
		 (t (call-interactively 'self-insert-command)))))

(global-set-key (kbd "C-c %") 'match-paren)

;; <CONFIRM KILL EMACS>
(setq confirm-kill-emacs 'y-or-n-p)

;; <PRINTF DEBUG MESSAGE>
(defun printf-debug-message()
  "printf debug message"
  (interactive)
  (insert "printf(\"\\x1b[32m===%s(%d)  \\x1b[0m\\n\",__PRETTY_FUNCTION__,__LINE__);"))

(global-set-key (kbd "C-c m p") 'printf-debug-message)

;; <PRINTK DEBUG MESSAGE>
(defun printk-debug-message()
  "printk debug message"
  (interactive)
  (insert "printk(\"\\x1b[32m===%s(%d)  \\x1b[0m\\n\",__PRETTY_FUNCTION__,__LINE__);"))

(global-set-key (kbd "C-c m k") 'printk-debug-message)

;; <PDR_ERROR DEBUG MESSAGE>
(defun pdrerror-debug-message()
  "pdr_error debug message"
  (interactive)
  (insert "pdr_error(\"===[%s]  \\n\",__PRETTY_FUNCTION__);"))

(global-set-key (kbd "C-c m e") 'pdrerror-debug-message)

;; <PDR_INFO DEBUG MESSAGE>
(defun pdrinfo-debug-message()
  "pdr_info debug message"
  (interactive)
  (insert "pdr_info(\"\\x1b[32m===[%s]  \\x1b[0m\\n\",__PRETTY_FUNCTION__);"))

(global-set-key (kbd "C-c m i") 'pdrinfo-debug-message)

;; <ONVIF_INFO DEBUG MESSAGE>
(defun onvifinfo-debug-message()
  "onvif_info debug message"
  (interactive)
  (insert "onvif_info(\"\\x1b[32m===[%s]  \\x1b[0m\\n\",__PRETTY_FUNCTION__);"))

(global-set-key (kbd "C-c m o") 'onvifinfo-debug-message)

;; <DISABLE AUTO RECENTERING>
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; <DISPLAY PERFORMANCE>
;;(setq redisplay-dont-pause t)

;; <CHANGE BUFFER IN CURRENT WINDOW>
;;(global-set-key (kbd "C-c -") 'previous-buffer)
;;(global-set-key (kbd "C-c =") 'next-buffer)

;; <CHANGE TO PREV/NEXT FRAME>
(defun move-cursor-next-frame ()
  "Move cursor to the next frame."
  (interactive)
  (other-frame 1))

(defun move-cursor-previous-frame ()
  "Move cursor to the previous frame."
  (interactive)
  (other-frame -1))

(global-set-key (kbd "C-c -") 'move-cursor-previous-frame)
(global-set-key (kbd "C-c =") 'move-cursor-next-frame)
(global-set-key (kbd "C-c !") 'new-frame)


;; <DEFAULT MODE HOOK>
(add-hook 'help-mode-hook 'my:kill-buffer-local-key)



;; <MY LOCAL SET KEY FUNC>
(defun my:kill-buffer-local-key()
  (local-set-key (kbd "q") 'kill-this-buffer)
  )


;; <RELOAD .emacs >
(defun reload-emacs-config()
  (interactive)
  (load-file "~/.emacs")
  ;(on-after-init)
)

(global-set-key (kbd "C-c C-r") 'reload-emacs-config)

;; <MOVE WINDOW>
(windmove-default-keybindings 'meta)
(define-key input-decode-map (kbd "\e[1;3A") [(meta up)])
(define-key input-decode-map (kbd "\e[1;3B") [(meta down)])
(define-key input-decode-map (kbd "\e[1;3D") [(meta left)])
(define-key input-decode-map (kbd "\e[1;3C") [(meta right)])

(define-key input-decode-map "\e\e[A" [(meta up)])
(define-key input-decode-map "\e\e[B" [(meta down)])
(define-key input-decode-map "\e\e[D" [(meta left)])
(define-key input-decode-map "\e\e[C" [(meta right)])

(define-key input-decode-map (kbd "ESC M-O A") [(meta up)])
(define-key input-decode-map (kbd "ESC M-O B") [(meta down)])
(define-key input-decode-map (kbd "ESC M-O D") [(meta left)])
(define-key input-decode-map (kbd "ESC M-O C") [(meta right)])


(define-key input-decode-map "\eOa" [(ctrl up)])
(define-key input-decode-map "\eOb" [(ctrl down)])
(define-key input-decode-map "\eOd" [(ctrl left)])
(define-key input-decode-map "\eOc" [(ctrl right)])

(define-key input-decode-map (kbd "\e[1;5A") [(ctrl up)])
(define-key input-decode-map (kbd "\e[1;5B") [(ctrl down)])
(define-key input-decode-map (kbd "\e[1;5D") [(ctrl left)])
(define-key input-decode-map (kbd "\e[1;5C") [(ctrl right)])


;;(global-set-key (kbd "C-c b") 'windmove-left)          ; move to left windnow
;;(global-set-key (kbd "C-c f") 'windmove-right)        ; move to right window
;;(global-set-key (kbd "C-c p") 'windmove-up)              ; move to upper window
;;(global-set-key (kbd "C-c n") 'windmove-down)          ; move to downer window




;; <MEMO>


;; KEY MAPPING RULE
;;========================
;; [C-x] : window
;;  o : ace-window (replaced)
;;========================
;; [C-c] : custom
;;------------------------
;;  f : frame
;;------------------------
;;  w : window
;;  w s : satellite window
;;  w l : window dedicate
;;  w p,n : window layout prev/next
;;  w m : window manager on/off
;;------------------------
;;  b : buffer
;;  b arrow : buffer move
;;  b p,n : buffer prev/next
;;-----------------------
;;  m : message
;;  m p : printf dbg msg
;;  m k : printk dbg msg
;;-----------------------
;;  t : terminal
;;  t n : new terminal
;;  t - : prev terminal
;;  t = : next terminal
;;-----------------------
;;  d : doxygen
;;  d f : doxygen function
;;----------------------
;;  s : cscope
;;  s s : find this symbol
;;  s g : find golobal definition
;;  s c : find funtions-colling-this-function
;;  s u : pop-mark
;;-----------------------
;;  c : cursor
;;  c m : multi cursor
;;  c p : previous like this
;;  c n : next like this
;;  c r : multi curosr reg xp
;;-----------------------



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(inhibit-startup-screen t)
 '(vc-follow-symlinks t)
 '(which-function-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(which-func ((t (:foreground "brightmagenta")))))
