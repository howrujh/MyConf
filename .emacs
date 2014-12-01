;; <GET ENV>
;; (if (eq system-type 'windows-nt)
;;     (add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
;;     (add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

;; <INTERFACE>
(tool-bar-mode -1)
(menu-bar-mode -1)

;; <LAYOUT>

(setq-default c-default-style "linux"
			  c-basic-offset 4 
			  tab-width 4
			  indent-tabs-mode t)


;; <INDENT>
;;(setq c-offsets-alist '((case-label . 4)))


;; <PACKAGE MANAGEMENT>
;; -- using package.el for install popular packages --

(setq pkg-list)
(add-to-list 'pkg-list 'el-get)
;;(add-to-list 'pkg-list 'xcscope)
;;(add-to-list 'pkg-list 'ascope)
(add-to-list 'pkg-list 'ido)
(add-to-list 'pkg-list 'color-theme)
;;(add-to-list 'pkg-list 'tango-2-theme)
;;(add-to-list 'pkg-list 'lush-theme)
(add-to-list 'pkg-list 'highlight-symbol)
;(add-to-list 'pkg-list 'cl)
;(add-to-list 'pkg-list 'ecb)
;(add-to-list 'pkg-list 'cedet)
(add-to-list 'pkg-list 'psvn)
(add-to-list 'pkg-list 'evil)
(add-to-list 'pkg-list 'undo-tree)
(add-to-list 'pkg-list 'php-mode)
(add-to-list 'pkg-list 'auto-complete)
(add-to-list 'pkg-list 'yasnippet)
(add-to-list 'pkg-list 'iedit)
;(add-to-list 'pkg-list 'flymake-google-cpplint)
;(add-to-list 'pkg-list 'flymake-cursor)
;(add-to-list 'pkg-list 'google-c-style)
(add-to-list 'pkg-list 'cc-mode)
(add-to-list 'pkg-list 'multi-term)
(add-to-list 'pkg-list 'multiple-cursors)
(add-to-list 'pkg-list 'buffer-move)
(add-to-list 'pkg-list 'ace-jump-mode)
(add-to-list 'pkg-list 'smart-mode-line)
(add-to-list 'pkg-list 'visual-regexp)

(when (require 'package nil 'noerror)

  (package-initialize)

  (setq package-archives '(
						   ("ELPA" . "http://tromey.com/elpa/")
						   ("melpa" . "http://melpa.milkbox.net/packages/")
						   ("gnu" . "http://elpa.gnu.org/packages/")
						   ("marmalade" . "http://marmalade-repo.org/packages/")))



  (when (not package-archive-contents)
    (package-refresh-contents)
	)

  (dolist (p pkg-list)
    (when (not (package-installed-p p))
	  (package-install p))
	)

  )

;; -- using el-get for install from github, svn, etc..--
(when (require 'el-get nil 'noerror)

  ;; Set up packages
  (setq el-get-sources
		'(
		  (:name rscope
				 :description "another interface to cscope tool."
				 :type github
				 :pkgname "rjarzmik/rscope")

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

;; <RXVT>
;(when (require 'rxvt nil 'noerror)
;  )

;; <GDB>
(setq gdb-many-windows 1)

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

;; <CC MODE>
(when (require 'cc-mode nil 'noerror)
  )


;; <PHP MODE>
(when (require 'php-mode nil 'noerror)
  )

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

;; <COLOR THEME>
(when (require 'color-theme nil 'noerror)
  ;;(require 'tango-2-theme)
  (load-theme 'tango-dark t)
  ;;(load-theme 'lush t)
  )

;; TRANSPARENT BG COLOR

(defun on-after-init ()
;  (unless (display-graphic-p (selected-frame))
;    (set-face-background 'default "unspecified-bg" (selected-frame)))
)

(add-hook 'window-setup-hook 'on-after-init)


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
  (sml/setup)
  (sml/apply-theme 'automatic)
  )




;; <CEDET MODE>
;; turn on Semantic
;(require 'cedet)
(semantic-mode t)
(defun my:add-semantic-to-autocomplete()

  (add-to-list 'ac-sources 'ac-source-semantic)
  )

(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)


;; <AUTO COMPLETE>
(when (require 'auto-complete nil 'noerror)
  (when (require 'auto-complete-config nil 'noerror)
	(ac-config-default)
	)
  )

;; <YASNIPPET>
(when (require 'yasnippet nil 'noerror)
  (yas-global-mode 1)
  )

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
;;(add-to-list 'load-path "/usr/share/cscope")
;;(require 'xcscope)
;;(require 'ascope)


;;(setq cscope-initial-directory "~/github/opengles2-book-sample/LinuxX11/")
;;(setq cscope-database-file "cscope.out")

;( setq pwd  ( getenv "PWD" )) 

;( cond (( file-exists-p ( expand-file-name "cscope.out"  pwd )) 
;  ( ascope-init ( concat pwd  "/" )))
  ;TODO: select cscope file by current path.
;  ( t (ascope-init "~/xm4k/" )))

(when (require 'rscope nil 'noerror)
  (defun my:cscope-init()

	)
  (defun my:cscope-kill()

	)

  (add-hook 'c++-mode-hook 'my:cscope-init)
  (add-hook 'c-mode-hook 'my:cscope-init)
  (add-hook 'makefile-mode-hook 'my:cscope-init)
  )
;(add-hook 'kill-emacs-hook 'my:cscope-kill)

;  '(lambda ()
;	 (cscope-minor-mode t)))

;(set-process-query-on-exit-flag (get-process "ascope") nil)


;;(global-set-key (kbd "C-c s s") 'cscope-find-this-symbol)
;;(global-set-key (kbd "C-c s g") 'cscope-find-global-definition)
;;(global-set-key (kbd "C-c s c") 'cscope-find-functions-calling-this-function)
;;(global-set-key (kbd "C-c s u") 'cscope-pop-mark)

;(global-set-key (kbd "C-c s s") 'ascope-find-this-symbol)
;(global-set-key (kbd "C-c s g") 'ascope-find-global-definition)
;(global-set-key (kbd "C-c s c") 'ascope-find-functions-calling-this-function)
;(global-set-key (kbd "C-c s u") 'ascope-pop-mark)


;; <ACE JUMP MODE>
(when (require 'ace-jump-mode nil 'noerror)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
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

  (global-set-key (kbd "C-c d f") 'my:doxy-func-comment)

  )



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
							 "*Messages*" "*scratch*" "Async Shell Command"))
  )
;; <UNDO-TREE>
(when (require 'undo-tree nil 'noerror)
  (global-undo-tree-mode 1)
  (global-set-key (kbd "M-/") 'undo-tree-redo)
;(global-set-key (kbd "C-z") 'undo-tree-undo) ; 【Ctrl+z】
;(global-set-key (kbd "C-S-z") 'undo-tree-redo) ; 【Ctrl+Shift+z】; Mac style
  )

;; <EVIL-MODE>
(when (require 'evil nil 'noerror)
;;(evil-mode)
  )
;; <PSVN)
(when (require 'psvn nil 'noerror)

  )
;; <EDIFF>
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-merge-split-window-function 'split-window-horizontally)

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

(push '("\\*Result*" display-buffer-in-satellite) display-buffer-alist)

(defun display-buffer-in-satellite (buffer ignore)
  "Display the buffer in the satellite window, or the first window \
    it finds if there is no satellite."
  (let ((satellite-window (or (get-satellite-window)
                              (first (window-list)))))
    (select-window satellite-window)
    (display-buffer-same-window buffer nil)
    (display-buffer-record-window 'reuse satellite-window buffer)
    satellite-window))



(global-set-key (kbd "C-c w s") 'mark-this-window-as-satellite)



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
  (insert "pdr_error(\"\\x1b[32m===  \\x1b[0m\\n\");"))

(global-set-key (kbd "C-c m e") 'pdrerror-debug-message)

;; <PDR_INFO DEBUG MESSAGE>
(defun pdrinfo-debug-message()
  "pdr_info debug message"
  (interactive)
  (insert "pdr_info(\"\\x1b[32m===  \\x1b[0m\\n\");"))

(global-set-key (kbd "C-c m i") 'pdrinfo-debug-message)

;; <ONVIF_INFO DEBUG MESSAGE>
(defun onvifinfo-debug-message()
  "onvif_info debug message"
  (interactive)
  (insert "onvif_info(\"\\x1b[32m===  \\x1b[0m\\n\");"))

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


;; <RELOAD .emacs >
(defun reload-emacs-config()
  (interactive)
  (load-file "~/.emacs")
  (on-after-init)
)

(global-set-key (kbd "C-c C-r") 'reload-emacs-config)

;; <MOVE WINDOW>
(windmove-default-keybindings 'meta)
(define-key input-decode-map "\e\e[A" [(meta up)])
(define-key input-decode-map "\e\e[B" [(meta down)])
(define-key input-decode-map "\e\e[D" [(meta left)])
(define-key input-decode-map "\e\e[C" [(meta right)])
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(define-key input-decode-map "\e\eOD" [(meta left)])
(define-key input-decode-map "\e\eOC" [(meta right)])


;;(global-set-key (kbd "C-c b") 'windmove-left)          ; move to left windnow
;;(global-set-key (kbd "C-c f") 'windmove-right)        ; move to right window
;;(global-set-key (kbd "C-c p") 'windmove-up)              ; move to upper window
;;(global-set-key (kbd "C-c n") 'windmove-down)          ; move to downer window




;; <MEMO>


;; KEY MAPPING RULE
;;========================
;; [C-x] : window
;;
;;========================
;; [C-c] : custom
;;------------------------
;;  f : frame
;;------------------------
;;  w : window
;;  w s : satellite window
;;  w l : window dedicate
;;  w p,n : window layout prev/next
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
 '(which-function-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(which-func ((t (:foreground "color-92")))))
