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
;;(add-to-list 'pkg-list 'tango-2-theme)
(add-to-list 'pkg-list 'highlight-symbol)
(add-to-list 'pkg-list 'cl)
(add-to-list 'pkg-list 'ecb)
(add-to-list 'pkg-list 'psvn)


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
;;(require 'tango-2-theme)
(load-theme 'tango-dark t)

;; <CSCOPE>
;;(add-to-list 'load-path "/usr/share/cscope")
(require 'xcscope)
(setq cscope-initial-directory "~/xm4k")
(setq cscope-database-file "sd4k_cscope.out")
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

;; <PSVN)
(require 'psvn)

;; <ECB>
(require 'cl)
(require 'ecb)

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

(global-set-key (kbd "ESC f") 'open-file-at-cursor)








;; <KEY BINDING>
(windmove-default-keybindings 'meta)
(global-set-key (kbd "C-c b") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "C-c f") 'windmove-right)        ; move to right window
(global-set-key (kbd "C-c p") 'windmove-up)              ; move to upper window
(global-set-key (kbd "C-c n") 'windmove-down)          ; move to downer window


;; <MEMO>
;;(dolist (key '("\C-a" "\C-b" "\C-c" "\C-t" "\C-u" "\C-v" "\C-x" "\C-z" "\e"))
;;  (global-unset-key key))
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
