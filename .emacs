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
;(setq c-offsets-alist '((case-label . 4)))


;; <PACKAGE MANAGEMENT>
(setq pkg-list)
(add-to-list 'pkg-list 'xcscope)
(add-to-list 'pkg-list 'ido)
(add-to-list 'pkg-list 'color-theme)
;;(add-to-list 'pkg-list 'tango-2-theme)
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

(require 'package)
(setq package-archives '(
						 ("ELPA" . "http://tromey.com/elpa/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")
						 ("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents)
)
(dolist (p pkg-list)
    (when (not (package-installed-p p))
	      (package-install p))
)

;; <WINNER MODE>
(winner-mode 1)
;; <CC MODE>
(require 'cc-mode)

;; <PHP MODE>
(require 'php-mode)

;; <IEDIT MODE>
(require 'iedit)
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; <DESKTOP SAVE MODE>
;(desktop-save-mode 1)

;; <SHOW PAREN MODE>
;; highlight pare charecters
(show-paren-mode 1)

;; <MULTIPLE CURSORS>
(require 'multiple-cursors)
(global-set-key (kbd "C-c m") 'mc/edit-lines)
(global-set-key (kbd "C-c <") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c >") 'mc/mark-next-like-this)


;; <COLOR THEME>
(require 'color-theme)
;;(require 'tango-2-theme)
(load-theme 'tango-dark t)

;; <CEDET MODE>
;; turn on Semantic
;(require 'cedet)
(semantic-mode t)
(defun my:add-semantic-to-autocomplete()

  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)


;; <AUTO COMPLETE>
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; <YASNIPPET>
(require 'yasnippet)
(yas-global-mode 1)

;; <FLYMAKE GOOGLE CPPLINT>
;; wget http://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py
(defun my:flymake-google-init()
  (require 'flymake-google-cpplint)
  (require 'flymake-cursor)
;  (custom-set-variables
 ;  '(flymake-google-cpplint-command "~/scripts/cpplint.py"))
  (flymake-google-cpplint-load)
)
;(add-hook 'c-mode-hook 'my:flymake-google-init)
;(add-hook 'c++-mode-hook 'my:flymake-google-init)

;; <GOOGLE C STYLE>
;(require 'google-c-style)
;(add-hook 'c-mode-common-hook 'google-set-c-style)
;(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; <CSCOPE>
;;(add-to-list 'load-path "/usr/share/cscope")
(require 'xcscope)
;;(setq cscope-initial-directory "~/github/opengles2-book-sample/LinuxX11/")
;;(setq cscope-database-file "cscope.out")
(defun my:cscope-init()
  (cscope-minor-mode t)
)

(add-hook 'c++-mode-hook 'my:cscope-init)
(add-hook 'c-mode-hook 'my:cscope-init)
(add-hook 'makefile-mode-hook 'my:cscope-init)

;  '(lambda ()
;	 (cscope-minor-mode t)))

;;(global-set-key (kbd "C-c s s") 'cscope-find-this-symbol)
;;(global-set-key (kbd "C-c s g") 'cscope-find-global-definition)
;;(global-set-key (kbd "C-c s c") 'cscope-find-functions-calling-this-function)
;;(global-set-key (kbd "C-c s u") 'cscope-pop-mark)


;; <HIGHLIGHT>

(require 'highlight-symbol)
(global-set-key (kbd "C-c 1") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c *") 'highlight-symbol-next)
(global-set-key (kbd "C-c #") 'highlight-symbol-prev)


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
(require 'doxymacs)
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
(require 'ido)
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
;; <UNDO-TREE>
(global-undo-tree-mode 1)
(global-set-key (kbd "M-/") 'undo-tree-redo)
;(global-set-key (kbd "C-z") 'undo-tree-undo) ; 【Ctrl+z】
;(global-set-key (kbd "C-S-z") 'undo-tree-redo) ; 【Ctrl+Shift+z】; Mac style


;; <EVIL-MODE>
(require 'evil)
;;(evil-mode)

;; <PSVN)
(require 'psvn)

;; <EDIFF>
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-merge-split-window-function 'split-window-horizontally)

;; <ECB>
;(require 'cl)
;(require 'ecb)

;; <MULTI-TERM>
(require 'multi-term)
(setq multi-term-program "/bin/bash")

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

(push '("\\*" display-buffer-in-satellite) display-buffer-alist)


(global-set-key (kbd "C-c s") 'mark-this-window-as-satellite)



;; <OPEN FILE AT CURSOR>
(defun open-file-at-cursor ()
  "Open the file path under cursor.
If there is text selection, uses the text selection for path.
If the path is starts with “http://”, open the URL in browser.
Input path can be {relative, full path, URL}.
This command is similar to `find-file-at-point' but without prompting for confirmation.
"
  (interactive)
  (let ( (path (if (region-active-p)
                   (buffer-substring-no-properties (region-beginning) (region-end))
                 (thing-at-point 'filename) ) ))
    (if (string-match-p "\\`https?://" path)
        (browse-url path)
      (progn ; not starting “http://”
        (if (file-exists-p path)
            (find-file path)
          (if (file-exists-p (concat path ".el"))
              (find-file (concat path ".el"))
            (when (y-or-n-p (format "file doesn't exist: 「%s」. Create?" path) )
              (find-file path )) ) ) ) ) ))

(global-set-key (kbd "C-c f") 'open-file-at-cursor)

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

(global-set-key (kbd "C-c l") 'toggle-window-dedicated)

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

(global-set-key (kbd "C-c p") 'printf-debug-message)

;; <PRINTK DEBUG MESSAGE>
(defun printk-debug-message()
  "printk debug message"
  (interactive)
  (insert "printk(\"\\x1b[32m===%s(%d)  \\x1b[0m\\n\",__PRETTY_FUNCTION__,__LINE__);"))

(global-set-key (kbd "C-c k") 'printk-debug-message)

;; <DISABLE AUTO RECENTERING>
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

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
  (load-file "~/.emacs"))

(global-set-key (kbd "C-c C-r") 'reload-emacs-config)

;; <MOVE WINDOW>
(windmove-default-keybindings 'meta)


;;(global-set-key (kbd "C-c b") 'windmove-left)          ; move to left windnow
;;(global-set-key (kbd "C-c f") 'windmove-right)        ; move to right window
;;(global-set-key (kbd "C-c p") 'windmove-up)              ; move to upper window
;;(global-set-key (kbd "C-c n") 'windmove-down)          ; move to downer window


;; <MEMO>
;;(dolist (key '("\C-a" "\C-b" "\C-c" "\C-t" "\C-u" "\C-v" "\C-x" "\C-z" "\e"))
;;  (global-unset-key key))
;;(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;; '(custom-safe-themes (quote ("bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" default)))
;;'(ecb-options-version "2.40")
;;'(inhibit-startup-screen t))
;;(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;;)
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(custom-safe-themes (quote ("bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" default)))
;; '(inhibit-startup-screen t))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("bad832ac33fcbce342b4d69431e7393701f0823a3820f6030ccc361edd2a4be4" default)))
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
