;; <GET ENV>
;; (if (eq system-type 'windows-nt)
;;     (add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))
;;     (add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

;; <INTERFACE>
(tool-bar-mode -1)
(menu-bar-mode -1)

;; <LAYOUT>

(setq-default c-basic-offset 4 
                  tab-width 4
                  indent-tabs-mode t)
;; <PACKAGE MANAGEMENT>
(setq pkg-list)
(add-to-list 'pkg-list 'xcscope)
(add-to-list 'pkg-list 'ido)
(add-to-list 'pkg-list 'color-theme)
(add-to-list 'pkg-list 'tango-2-theme)
(add-to-list 'pkg-list 'highlight-symbol)

(require 'package)
(setq package-archives '(
						 ("ELPA" . "http://tromey.com/elpa/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")
						 ("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))
(dolist (p pkg-list)
    (when (not (package-installed-p p))
	      (package-install p)))

;; <COLOR THEME>
(require 'color-theme)
(require 'tango-2-theme)
(load-theme 'tango-2 t)

;; <CSCOPE>
;;(add-to-list 'load-path "/usr/share/cscope")
(require 'xcscope)

;; <HIGHLIGHT>
(require 'highlight-symbol)
(global-set-key (kbd "ESC 1") 'highlight-symbol-at-point)
(global-set-key (kbd "ESC *") 'highlight-symbol-next)
(global-set-key (kbd "ESC #") 'highlight-symbol-prev)


;; <IDO-MODE>
(global-set-key (kbd "C-c s s") 'cscope-find-called-functions)
(global-set-key (kbd "C-c s g") 'cscope-find-global-definition)
(global-set-key (kbd "C-c s c") 'cscope-find-functions-calling-this-function)

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
;(setq ido-use-filename-at-point t) ;; prefer file names near point

;; <EVIL-MODE>
;;(evil-mode)








;; <KEY BINDING>
(windmove-default-keybindings 'meta)
(global-set-key (kbd "C-c b") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "C-c f") 'windmove-right)        ; move to right window
(global-set-key (kbd "C-c p") 'windmove-up)              ; move to upper window
(global-set-key (kbd "C-c n") 'windmove-down)          ; move to downer window


;; <MEMO>
;;(dolist (key '("\C-a" "\C-b" "\C-c" "\C-t" "\C-u" "\C-v" "\C-x" "\C-z" "\e"))
;;  (global-unset-key key))
