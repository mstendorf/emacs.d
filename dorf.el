
; start package.el for emacs to handle packages
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


