(package-initialize t)
;(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
;(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp")
;(add-to-list 'load-path "~/.emacs.d/tramp/lisp" t)
;(require 'org)
;load dorf specific config!
(org-babel-load-file "~/.emacs.d/dorf.org")

(require 'package)
;;; Packages repo, can't really live without melpa rite?
(when (>= emacs-major-version 24)
   (require 'package)
    (package-initialize)
     (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
      )
(load "~/.emacs.d/functions.el")
(load "~/.emacs.d/settings.el")
(load "~/.emacs.d/graphical.el")
(load "~/.emacs.d/personal.el")
(load "~/.emacs.d/modules.el")
(load "~/.emacs.d/programming.el")
(load "~/.emacs.d/keybindings.el")
(load "~/.emacs.d/misc.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-ignore-case nil)
 '(dabbrev-case-fold-search nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "84.238.0.3")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#2b2f45"))))
 '(company-scrollbar-fg ((t (:background "#212435"))))
 '(company-tooltip ((t (:inherit default :background "#1b1e2c"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face)))))
