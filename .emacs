;; <INTERFACE>
;;(tool-bar-mode -1)
(menu-bar-mode -1)

;; <LAYOUT>

(setq-default c-basic-offset 4 
                  tab-width 4
                  indent-tabs-mode t)
;; <PACKAGE MANAGEMENT>
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

)
;; <CSCOPE>
(add-to-list 'load-path "/usr/share/cscope")
(require 'xcscope)


;; <IDO-MODE>
(global-set-key (kbd "C-\\ s") 'cscope-find-called-functions)
(global-set-key (kbd "C-\\ g") 'cscope-find-global-definition)
(global-set-key (kbd "C-\\ c") 'cscope-find-functions-calling-this-function)

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
