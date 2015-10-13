(setq user-full-name "Martin Stendorf"
      user-full-email-address "mas@bnaa.dk"
      mail-host-address "bnaa.dk")
(custom-set-variables
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "84.238.0.3")
 '(smtpmail-smtp-service 25))
;setup org2blog info
(setq org2blog/wp-blog-alist
      '(("dorfzone"
         :url "http://dorfzone.dk/xmlrpc.php"
         :username "admin"
         :default-categories ("Uncategorized")
         :default-options "toc:4 h:4"
         :default-title "TITLE HERE!")))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(bind-key "s-M-t" 'transpose-sexps)
;; some other personal convenience settings.
(global-set-key "\C-K" 'kill-whole-line)
(global-set-key "\M-D" 'backward-kill-word)
(global-set-key "\C-j" 'pop-global-mark)

;; These functions are useful. Activate them.
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Keep all backup and auto-save files in one directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq-default indent-tabs-mode nil)

;; Turn off the blinking cursor
(blink-cursor-mode -1)
;; Don't count two spaces after a period as the end of a sentence.
;; Just one space is needed.
(setq sentence-end-double-space nil)

;; delete the region when typing, just like as we expect nowadays.
(delete-selection-mode t)

(show-paren-mode t)

(column-number-mode t)

(global-visual-line-mode)
(diminish 'visual-line-mode)

(setq uniquify-buffer-name-style 'forward)

;; -i gets alias definitions from .bash_profile
;(setq shell-command-switch "-ic")

;; Don't beep at me
;(setq visible-bell t)
;; Never sound the alarm! CRIMERIDER!!
(setq ring-bell-function 'ignore)

; stop losint undo content, by setting big buffers
(setq undo-limit 20000000)
(setq undo-sring-limit 40000000)

; auto reload buffers that change on disk so that we never edit stale buffers
(global-auto-revert-mode)
; do it for dired to, but do it silently
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

; fix the chunky scrolling
(setq scroll-conservatively 10000
scroll-step 1)

;; nuke trailing whitespaces when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; Allow Emacs to silently delete backup files
(setq delete-old-versions t)

;; HACK for magit to be able to push!!
;(setenv "SSH_ASKPASS" "git-gui--askpass")

;; Yep, 3.4 is the default to me now.
;(setq python-shell-interpreter "python3.4")

(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (thing-at-point 'symbol))
        regexp-history)
  (call-interactively 'occur))

(bind-key "M-s o" 'occur-dwim)

(if (display-graphic-p)
    (progn                              ;if graphical
      (set-frame-font "-outline-Ubuntu Mono-normal-normal-normal-mono-*-*-*-*-c-*-iso8859-1")
      (set-face-attribute 'default nil :height 120)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (menu-bar-mode -1)
      ;highlight the current marked line
      (global-hl-line-mode 1)
      (set-face-background 'hl-line "midnight blue")
      (add-to-list 'default-frame-alist '(fullscreen . maximized))

      ;prettyfy
      (require 'color)
      (let ((bg (face-attribute 'default :background)))
        (custom-set-faces
         `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
         `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
         `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
         `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
         `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))


      )                                 ;else
  ;; hack to make C-arrow work under putty terminal!
  (define-key input-decode-map (kbd "ESC [ D") (kbd "<C-left>"))
  (define-key input-decode-map (kbd "ESC [ C") (kbd "<C-right>"))
  (define-key input-decode-map (kbd "ESC [ A") (kbd "<C-up>"))
  (define-key input-decode-map (kbd "ESC [ B") (kbd "<C-down>"))
  ;(xterm-mouse-mode 1)
  )

(use-package cyberpunk-theme
  :ensure t
)

(use-package solarized-theme
  :init
  (setq solarized-use-variable-pitch nil)
  :ensure t)

(setq monokai-use-variable-pitch nil)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (progn
    (load-theme 'sanityinc-tomorrow-night t)))

;; Function to move to beginning of code if somwhere else
(defun my--back-to-indentation ()
  "Move to indentation respecting `visual-line-mode'."
  (if visual-line-mode
      (flet ((beginning-of-line (arg) (beginning-of-visual-line arg)))
        (back-to-indentation))
    (back-to-indentation)))

;; funcition to move to beginning of line if at beginning of code
(defun my--move-beginning-of-line (&optional arg)
  "Move to beginning of line respecting `visual-line-mode'."
  (if visual-line-mode
      (beginning-of-visual-line arg)
    (move-beginning-of-line arg)))

;; function implementing above written functions so this can be bound to C-a for easy moving around.
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

;; Company mode indent or autocomplete function
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

(defun switch-theme (theme)
  "Disables any currently active themes and loads THEME."
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapc 'symbol-name
                                   (custom-available-themes))))))
  (let ((enabled-themes custom-enabled-themes))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme t)))

(defun disable-active-themes ()
  "Disables any currently active themes listed in `custom-enabled-themes'."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(bind-key "s-<f12>" 'switch-theme)
(bind-key "s-<f11>" 'disable-active-themes)

;; make ibuffer the default buffer lister.
(defalias 'list-buffers 'ibuffer)

(use-package recentf
  :commands ido-recentf-open
  :init
  (progn
    (recentf-mode t)
    (setq recentf-max-saved-items 200)

    (defun ido-recentf-open ()
      "Use `ido-completing-read' to \\[find-file] a recent file"
      (interactive)
      (if (find-file (ido-completing-read "Find recent file: " recentf-list))
          (message "Opening file...")
        (message "Aborting")))

    (bind-key "C-x C-r" 'ido-recentf-open)))

(bind-key "C-c l" 'org-store-link)
(bind-key "C-c c" 'org-capture)
(bind-key "C-c a" 'org-agenda)
(bind-key "C-c b" 'org-iswitchb)

(setq org-agenda-files
      (delq nil
            (mapcar (lambda (x) (and (file-exists-p x) x))
                    '("~/.emacs.d/org/Agenda"))))

(setq org-default-notes-file "~/.emacs.d/org/notes.org")

(setq org-use-speed-commands t)

(setq org-image-actual-width 550)

;; archiving for old TODO items
(setq org-archive-location "~/.emacs.d/org/archive.org::* From %s")
;; org-mode capture templates: maybe org-mode need it's own file?
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/org/plan.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/.emacs.d/org/journal.org")
             "* Event: %?\n\n  %i\n\n  From: %a")))
;; Alter TODO states for more trackabillity.
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "RESEARCH(r@/!)" "ACTIVE(a)" "|" "DONE(d)" "DELEGATED(e@/!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

;; Select states fast by C-c C-t KEY
(setq org-use-fast-todo-selection t)

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("ACTIVE" :foreground "light blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("DELEGATED" :foreground "green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "brown" :weight bold)
              ("CANCELLED" :foreground "light grey" :weight bold)
              ("MEETING" :foreground "yellow" :weight bold)
              ("PHONE" :foreground "yellow" :weight bold))))
;try to color literal code blocks
(setq org-src-fontify-natively t)

(setq org-tags-column 45)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (C . t)
   (calc . t)
   (latex . t)
   (java . t)
   (ruby . t)
;   (scheme . t)
   (sh . t)
;   (sqlite . t)
   (js . t)))

(defun my-org-confirm-babel-evaluate (lang body)
  "Do not confirm evaluation for these languages."
  (not (or (string= lang "C")
           (string= lang "java")
           (string= lang "python")
           (string= lang "emacs-lisp"))))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(setq org-src-fontify-natively t
      org-src-window-setup 'current-window
      org-src-strip-leading-and-trailing-blank-lines t
      org-src-preserve-indentation t
      org-src-tab-acts-natively t)

; (use-package ox-pandoc
;   :no-require t
;   :ensure t)

(setq erc-server "irc.freenode.net"
      erc-port 6667
      erc-nick "Dorfen"
      erc-user-full-name "Dorfen"
      erc-email-userid "mstendorf@gmail.com")
;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

;; auto join activated
(erc-autojoin-mode t)
;; join channels in theese lists
(setq erc-autojoin-channels-alist
      '(("freenode.net"
;        ;; hacking,security & networks related
;        "#justhackingthings"
;        "#hacking"
;        "##re"
;        "#metasploit"
;        "#reddit-sysadmin"
;        "##hackers"
;        "#wireshark"
;        "#vulnhub"
;        "#openstack-security"
;        "#howtohack"
;        "#hackhouse"
;        "#2701"
;        "##whitehat"
;        "#nodesecurity"
;        "#MITMf"
;        "#sqlmap"
;        "##hackaday"
;        "#r_netsec"
;        "#hacker.org"
;        "#defcon"
;        "#livectf"
;        "##crypto"
;        "#65kHacking"
;        "#pro-verflow"
;        "#DataHoarder"
;        "##systemadmins"
;        "#networking"
;        "##networking"
;        "#snort"
;        "#cyberpunk"
;        "#dns"
;        "#gnu"
;
;
;        ;; programming
;        "#postgresql"
;        "##python-friendly"
;        "##dreamincode"
;        "##C++-general"
;        "#git"
;        "##c"
;        "##c++"
;        "#osdev"
;        "#python"
;        "##programming"
;        "#loldev"
;
;        ;; editors & tools
         "#emacs"
;        "#emacsconf"
         "#org-mode"
;        "#vim"
;
;
;        ;; *nix related
         "#freebsd"
;        "#ubuntu-steam"
;        "#bash"
;        "##linux"
;        "#nagios"
;        "#ubuntu"
;        "#juniper"
;        "#android"
;        "#ubuntu-desktop"
;
;        ;; danish stuff
         "#linux.dk"
         "#ubuntu-dk"
;        "#osaa"
;        "#bitcoin-dk"
;
;        ;; misc stuff
;        "#startups"
;        "##politics"
)))

(bind-key "C-x m" 'shell)
(bind-key "C-x M" 'ansi-term)

(bind-key "s-C-<left>"  'shrink-window-horizontally)
(bind-key "s-C-<right>" 'enlarge-window-horizontally)
(bind-key "s-C-<down>"  'shrink-window)
(bind-key "s-C-<up>"    'enlarge-window)

(global-set-key [S-left] 'windmove-left)
(global-set-key [S-right] 'windmove-right)
(global-set-key "\M-o" 'other-window)

(global-set-key "\M-f" 'find-file)
(global-set-key "\M-F" 'find-file-other-window)
(global-set-key "\M-b" 'switch-to-buffer)
(global-set-key "\M-B" 'switch-to-buffer-other-window)
(global-set-key "\M-k" 'kill-this-buffer)

(use-package ido
  :init
  (progn
    (setq ido-enable-flex-matching t)
    (setq ido-everywhere t)
    (ido-mode t)
    ;; (use-package ido-ubiquitous
    ;;   :ensure t
    ;;   :init (ido-ubiquitous-mode))
    (use-package ido-vertical-mode
      :ensure t
      :init (ido-vertical-mode 1)
      (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
      ;(setq ido-vertical-define-keys 'C-n-and-C-p-only)
)))

(use-package whitespace
  :bind ("s-<f10>" . whitespace-mode))

(use-package ace-jump-mode
  :ensure t
  :diminish ace-jump-mode
  :commands ace-jump-mode
  :bind ("C-S-s" . ace-jump-mode))

; (use-package android-mode
;   :ensure t)

(use-package c-eldoc
  :commands c-turn-on-eldoc-mode
  :ensure t
  :init (add-hook 'c-mode-hook #'c-turn-on-eldoc-mode))

(use-package lua-mode
  :ensure t
  :init (progn
           (defadvice lua-electric-match (around last-command-char-fixup activate)
           (let ((last-command-char last-command-event))
                ad-do-it)))
  :config
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (define-key magit-status-mode-map (kbd "q") 'magit-quit-session))

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(use-package ein
  :ensure t)

(use-package expand-region
  :ensure t
  :bind ("C-@" . er/expand-region))

(use-package flycheck
  :ensure t
  :config (setq flycheck-html-tidy-executable "tidy5"))

(use-package edit-server
  :ensure t
  :config
  (edit-server-start)
  (setq edit-server-default-major-mode 'markdown-mode)
  (setq edit-server-new-frame nil))

(use-package macrostep
  :ensure t
  :bind ("H-`" . macrostep-expand))

(use-package markdown-mode
  :ensure t
  :mode (("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'"       . markdown-mode)))

(use-package multiple-cursors
  :ensure t
  :init (require 'multiple-cursors)
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-!"         . mc/mark-all-like-this)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :commands projectile-mode
  :config
  (progn
    (projectile-global-mode t)
    (setq projectile-enable-caching t)
    (use-package ag
      :commands ag
      :ensure t)))

(use-package elpy
   :ensure t
   :config
   (elpy-enable)
   (highlight-indentation-mode -1)
   (autoload 'jedi:setup "jedi" nil t)
   (add-hook 'python-mode-hook 'jedi:setup)
   (setq jedi:setup-keys t)
   (setq jedi:complete-on-dot t)
   ;; remove the highlight indentation mode from elpy
   (setq elpy-modules (delq 'elpy-module-highlight-indentation
                             elpy-modules)))

(use-package restclient
  :ensure t
  :mode ("\\.restclient\\'" . restclient-mode))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config (progn (require 'smartparens-config)
                 (smartparens-global-mode t)))

(sp-local-pair 'org-mode "~" "~" :actions '(wrap))
(sp-local-pair 'org-mode "/" "/" :actions '(wrap))
(sp-local-pair 'org-mode "*" "*" :actions '(wrap))

(use-package smartscan
  :ensure t
  :config (global-smartscan-mode 1)
  :bind (("s-n" . smartscan-symbol-go-forward)
         ("s-p" . smartscan-symbol-go-backward)))

(use-package skewer-mode
  :commands skewer-mode
  :ensure t
  :config (skewer-setup))

(use-package smooth-scrolling
  :ensure t)

(use-package visual-regexp
  :ensure t
  :init
  (use-package visual-regexp-steroids :ensure t)
  :bind (("C-c r" . vr/replace)
         ("C-c q" . vr/query-replace)
         ("C-c m" . vr/mc-mark) ; Need multiple cursors
         ("C-M-r" . vr/isearch-backward)
         ("C-M-s" . vr/isearch-forward)))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (setq yas-snippet-dirs (concat user-emacs-directory "snippets"))
  (yas-global-mode))

(use-package emmet-mode
  :ensure t
  :commands emmet-mode
  :config
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode))

(use-package zoom-frm
  :ensure t
  :bind (("C-M-=" . zoom-in/out)
         ("H-z"   . toggle-zoom-frame))
  :config
  (setq frame-zoom-font-difference 10))

(use-package scratch
  :ensure t)

(use-package org2blog
  :ensure t
;  :init ((setq load-path (cons "~/.emacs.d/org2blog/" load-path)))
  :bind (("C-c p" . org2blog/wp-post-buffer-and-publish)
         ("C-x C-f" . org2blog/wp-new-entry)))

(use-package doc-view
  :config
  (define-key doc-view-mode-map (kbd "<right>") 'doc-view-next-page)
  (define-key doc-view-mode-map (kbd "<left>") 'doc-view-previous-page))

(use-package powerline
   :ensure t
   :config
   (powerline-default-theme)
   (setq powerline-arrow-shape 'curve)
)

(defun my-tab-fix ()
  (local-set-key "\t" 'indent-or-expand))

(add-hook 'c-mode-hook 'my-tab-fix)
(add-hook 'c++-mode-hook 'my-tab-fix)
(add-hook 'sh-mode-hook 'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'web-mode-hook 'my-tab-fix)
(add-hook 'python-mode-hook 'my-tab-fix)

;; define new line and indent for programming modes
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(define-key emacs-lisp-mode-map (kbd "RET") 'newline-and-indent)
(define-key python-mode-map (kbd "RET") 'newline-and-indent)

;; CLEAN UP NEEDED HERE!!!!
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
