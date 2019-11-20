;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(after! typescript-mode
  (setq typescript-indent-level 2)
  ;; (add-hook 'before-save-hook 'tide-format-before-save)
  )

(def-package! vue-mode
  :mode "\\.vue$"
  ;; (setq js-indent-level 2)
  )
(after! vue-mode
  (set-face-background 'mmm-default-submode-face nil)
  )

;;(add-hook 'mmm-mode-hook
;;	  (lambda ()
;;	    (set-face-background 'mmm-default-submode-face "#fafafa")))


(setq display-line-numbers-type nil)

;; <HIGHLIGHT>
(define-key evil-normal-state-map "g1" #'hlt-highlight-symbol)
(define-key evil-normal-state-map "g2" #'hlt-unhighlight-symbol)


(defun copy-to-clipboard ()
  "Copies selection to x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "~/script/pbcopy")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun paste-from-clipboard ()
  "Pastes from x-clipboard."
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "~/script/pbpaste"))
    )
  )
(define-key global-map (kbd "C-x y") 'copy-to-clipboard)
(define-key global-map (kbd "C-x p") 'paste-from-clipboard)


