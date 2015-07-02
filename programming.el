;; Configuration file for programming specific modes.
;; I tend to switch round in modes, so this is made for having easy access to that.


;; C/C++ mode
(require 'cc-mode)
(c-set-offset 'template-args-cont 4 nil)
;;;Setting C/C++ syntax
;; Coding style
(setq c-default-style "stroustrup")
;reflow comment, fix long lines. split to multi etc
(define-key c-mode-base-map "\e." 'c-fill-paragraph)
;jump to funtion by name -> tab completion helps here
(define-key c-mode-base-map "\ej" 'imenu)
;; Proper indent in hpp files inline code:
(c-set-offset 'inline-open 0)

;; activate minor whitespace mode - FIGURE OUT WTF THIS IS!!!
;(add-hook 'c-mode-common-hook 'whitespace-mode)
;(add-hook 'rst-mode-hook 'whitespace-mode)




;; PHP
; i actually enjoy web-mode way more than php-mode.
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . web-mode))

;setup slime backend for php
(slime-setup '(slime-company))


;; LUA
(autoload 'lua-mode "lua-mode" "Mode for editing Lua source files")
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(defadvice lua-electric-match (around last-command-char-fixup activate)
  (let ((last-command-char last-command-event))
    ad-do-it))

;; remove the highlight indentation mode from elpy
(setq elpy-modules (delq 'elpy-module-highlight-indentation
			          elpy-modules))
