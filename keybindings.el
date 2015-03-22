;; Well guess what, this file defines all keybindings I needed, or had to change!


;; make C-a jump from BOL to BOC
(global-set-key "\C-a" 'my-back-to-indentation-or-beginning)

;; rather nifty functions
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;; Replace 'yes' by 'y' - yes, i am that lazy!
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key "\M-m" 'compile)
(global-set-key "\M-f" 'find-file)
(global-set-key "\M-F" 'find-file-other-window)
(global-set-key "\M-b" 'switch-to-buffer)
(global-set-key "\M-B" 'switch-to-buffer-other-window)
(global-set-key "\M-k" 'kill-this-buffer)
(global-set-key "\C-K" 'kill-whole-line)
(global-set-key "\M-D" 'backward-kill-word)
; C-x o is stupid, testing other stuff out at the moment, might even look in to some
; window switching mode at some point, but think thii'll do for now.
(global-set-key [S-left] 'windmove-left)
(global-set-key [S-right] 'windmove-right)
(global-set-key "\M-o" 'other-window)

;; ORGMODE
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; COMPANY MODE
(defun my-tab-fix ()
  (local-set-key "\t" 'indent-or-expand))

(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'c++-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'web-mode-hook 'my-tab-fix)

;; define new line and indent for programming modes
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(define-key web-mode-map (kbd "RET") 'newline-and-indent)
(define-key emacs-lisp-mode-map (kbd "RET") 'newline-and-indent)
