;; full screen as the first thing!
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(package-initialize t)
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp")
(add-to-list 'load-path "~/.emacs.d/tramp/lisp")
(require 'org)
;load dorf specific config!
(org-babel-load-file "~/.emacs.d/dorf.org")

(require 'package)
;;; Packages repo, can't really live without melpa rite?
(when (>= emacs-major-version 24)
   (require 'package)
    (package-initialize)
     (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
      )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-ignore-case nil)
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "5d36f8700df907940779a5ca42ce7a0d6821028a2f5a4e34fb03e8d7aad13f01" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "ac536fdb4c33ffaa8fc6b6e5cc29e693725164648439f28e686f988a04d0645b" default)))
 '(dabbrev-case-fold-search nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "84.238.0.3")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#585858"))))
 '(company-scrollbar-fg ((t (:background "#4b4b4b"))))
 '(company-tooltip ((t (:inherit default :background "#444444"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face)))))
