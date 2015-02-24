
;; and you need this, else you'll get symbol void errors when doing
;; fill paragraph
(setq org-list-allow-alphabetical t)
;hacks to get org2blog going,
;cloned git repo to below dest while installing all deps manually:
;xml-rpc metaweblogger htmlize
(setq load-path (cons "~/.emacs.d/org2blog/" load-path))
(add-to-list 'load-path "~/.emacs.d/tramp/lisp")
(require 'org2blog-autoloads)

; stop losint undo content, by setting big buffers
(setq undo-limit 20000000)
(setq undo-sring-limit 40000000)
;highlight the current marked line
(global-hl-line-mode 1)
(set-face-background 'hl-line "midnight blue")

;setup the preference of UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

; auto reload buffers that change on disk so that we never edit stale buffers
(global-auto-revert-mode)
; do it for dired to, bu do itr silently
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

; fix the chunky scrolling
(setq scroll-conservatively 10000
scroll-step 1)

(set-frame-font "-outline-Ubuntu Mono-normal-normal-normal-mono-*-*-*-*-c-*-iso8859-1")
(set-face-attribute 'default nil :height 120)

;get rid off the toolbar to get a cleaner view.
(tool-bar-mode -1)
;scroll bars fuck em too
(scroll-bar-mode -1)
;I AM LONE WUF, i need no menu!
(menu-bar-mode -1)
;always start emacs in split pane mode
(split-window-horizontally)
;load the theme!
(load-theme 'deeper-blue t)

; start package.el for emacs to handle packages
(require 'package)
;;; Packages repo, can't really live without melpa rite?
(when (>= emacs-major-version 24)
   (require 'package)
    (package-initialize)
     (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
      )

;; nuke trailing whitespaces when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 80
           whitespace-style '(face tabs trailing lines-tail))

;; Allow Emacs to silently delete backup files
(setq delete-old-versions t)

;; activate minor whitespace mode
(add-hook 'c-mode-common-hook 'whitespace-mode)
(add-hook 'rst-mode-hook 'whitespace-mode)
;; Proper indent in hpp files inline code:
(c-set-offset 'inline-open 0)

(defun my--back-to-indentation ()
  "Move to indentation respecting `visual-line-mode'."
  (if visual-line-mode
      (flet ((beginning-of-line (arg) (beginning-of-visual-line arg)))
        (back-to-indentation))
    (back-to-indentation)))

(defun my--move-beginning-of-line (&optional arg)
  "Move to beginning of line respecting `visual-line-mode'."
  (if visual-line-mode
      (beginning-of-visual-line arg)
    (move-beginning-of-line arg)))

(defun my-back-to-indentation-or-beginning (&optional arg)
  "Jump back to indentation of the current line.  If already
there, jump to the beginning of current line.  If visual mode is
enabled, move according to the visual lines."
  (interactive "p")
  (cond
   ((and (functionp 'org-table-p)
         (org-table-p))
    (let ((eob (save-excursion
                 (re-search-backward "|")
                 (forward-char 1)
                 (skip-chars-forward " ")
                 (point))))
      (if (= (point) eob)
          (org-beginning-of-line)
        (goto-char eob))))
   ((eq major-mode 'dired-mode)
    (if (= (point) (save-excursion
                     (dired-move-to-filename)
                     (point)))
        (progn
          (move-beginning-of-line 1)
          (skip-syntax-forward " "))
      (dired-move-to-filename)))
   ((eq major-mode 'org-mode)
    (org-beginning-of-line))
   (t
    (if (or (/= arg 1)
            (= (point) (save-excursion
                         (my--back-to-indentation)
                         (point))))
        (progn
          (my--move-beginning-of-line arg)
          (when (/= arg 1)
            (my--back-to-indentation)))
      (my--back-to-indentation)))))

(global-set-key "\C-a" 'my-back-to-indentation-or-beginning)

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

(setq user-full-name "Martin Stendorf")
(setq user-email-address "mas@bnaa.dk")
(setq mail-host-address "bnaa.dk")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "84.238.0.3")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;setup org2blog info
(setq org2blog/wp-blog-alist
      '(("dorfzone"
         :url "http://dorfzone.dk/xmlrpc.php"
         :username "admin"
         :default-categories ("Uncategorized")
         :default-options "toc:4 h:4"
         :default-title "TITLE HERE!")))

;;;This gives line numbers
;(add-hook 'find.file-hook (lambda () (linum-mode 1)))
;(global-linum-mode 1)
;;;Parent highlight
(show-paren-mode 1)
;ido mode is just to awesome to miss
(require 'ido)
;flex matching in ido mode is living the dream while opening buffers and files
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
(setq ispell-program-name "aspell")
(setq ispell-personal-dictionary "en")

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-semantic company-backends))
; snippet i pulled and edited from emacs wiki as i  remember.. sry
(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (company-complete)
    (indent-according-to-mode)))

(defun my-tab-fix ()
  (local-set-key "\t" 'indent-or-expand))

(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'c++-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'web-mode-hook 'my-tab-fix)
;prettyfy
(require 'color)
(let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

;;;Setting C/C++ syntax
;; Coding style
(setq c-default-style "stroustrup")
;; Automatic Indentation - indentation after newline
(require 'cc-mode)
(c-set-offset 'template-args-cont 4 nil)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;reflow comment, fix long lines. split to multi etc
(define-key c-mode-base-map "\e." 'c-fill-paragraph)
;jump to funtion by name -> tab completion helps here
(define-key c-mode-base-map "\ej" 'imenu)

;(autoload 'php-mode "php-mode" "Major mode for editing php code.")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . web-mode))
(define-key web-mode-map (kbd "RET") 'newline-and-indent)
;setup slime backend for php
(slime-setup '(slime-company))

(autoload 'lua-mode "lua-mode" "Mode for editing Lua source files")
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
    (defadvice lua-electric-match (around last-command-char-fixup activate)
      (let ((last-command-char last-command-event))
        ad-do-it))

(setq  org-agenda-files (list "~/.emacs.d/org/"))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
; try to color literal code blocks
(setq org-src-fontify-natively t)

(require 'org2blog)
(global-set-key (kbd "C-c p") 'org2blog/wp-post-buffer-and-publish)
(global-set-key (kbd "C-c n") 'org2blog/wp-new-entry)

;start auto-complete
;(require 'auto-complete)
; do default config - TODO: Figure out less annoying conf.
;(require 'auto-complete-config)
;(ac-config-default)
;(setq ac-auto-show-menu nil)
;(define-key ac-completing-map "\t" 'ac-complete)
;(define-key ac-completing-map "\r" nil)
; turn on semantic mode tab completion from known words in buffers and found import files.
;(semantic-mode 1)
; define function to add this to c modes
;(defun my:add-semantic-to-autocomplete()
;  (add-to-list 'ac-sources 'ac-source-semantic)
;)
;(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;I'm currently taking company-mode for a spin
;(add-hook 'after-init-hook 'global-company-mode)
; set the expansion to de done like in a terminal!
;(defun indent-or-expand (arg)
;  "Either indent according to mode, or expand the word preceding
;point."
;  (interactive "*P")
;  (if (and
;       (or (bobp) (= ?w (char-syntax (char-before))))
;       (or (eobp) (not (= ?w (char-syntax (char-after))))))
;      (dabbrev-completion)
;    (indent-according-to-mode)))
;
;(defun my-tab-fix ()
;  (local-set-key [tab] 'indent-or-expand))
;
;(add-hook 'c-mode-hook          'my-tab-fix)
;(add-hook 'c++-mode-hook        'my-tab-fix)
;(add-hook 'sh-mode-hook         'my-tab-fix)
;(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)

; smarttab - this might work.

;*win32* (eq system-type 'windows-nt) )
;32 auto configuration, assuming that cygwin is installed at "c:/cygwin"
;in32*
;
;etq cygwin-mount-cygwin-bin-directory "c:\\cygwin\\bin")
;equire 'setup-cygwin)
;setenv "HOME" "c:/cygwin/home/someuser") ;; better to set HOME env in GUI
;

(require 'tramp)
(add-to-list 'tramp-default-proxies-alist
                       '("asauce" nil "/plink:root@%h:"))
          (add-to-list 'tramp-default-proxies-alist
                      '((regexp-quote (system-name)) nil nil))
(setq tramp-default-method "plink")

;(require 'yasnippet)
;(yas-global-mode 1)

;(defun on-after-init ()
;  (unless (display-graphic-p (select-frame))
;    (set-face-background 'default "color-235" (select-frame)))
;)
; start emacs in fullscreen (windows specific)
; this has to be last cause of some window error along the line in this config, figure out where
(w32-send-sys-command 61488)
