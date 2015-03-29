;; This is the main configuration for major modes

;; IDO
;ido mode is just to awesome to miss
(require 'ido)
;flex matching in ido mode is living the dream while opening buffers and files
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
;i love fuzzy matching to much to do the helm switch, so doing this for now.
(require 'ido-vertical-mode)
(ido-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(ido-vertical-mode 1)

;; COMPANY - autocompletion interface
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-semantic company-backends))


;; ORGMODE - The mother of all gods!
(setq  org-agenda-files (list "~/org/")) ; i need to figure out how to manage this across machines
(setq org-default-notes-file (concat org-directory "~/org/notes.org"))

;; archiving for old TODO items
(setq org-archive-location "~/archive.org::* From %s")
;; org-mode capture templates: maybe org-mode need it's own file?
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/plan.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
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


;; ORG2BLOG
(require 'org2blog)
(global-set-key (kbd "C-c p") 'org2blog/wp-post-buffer-and-publish)
(global-set-key (kbd "C-c n") 'org2blog/wp-new-entry)


;; TRAMP
(require 'tramp)
(setq tramp-verbose 10)
(setq tramp-debug-buffer t)
(setq tramp-shell-prompt-pattern
      "\\(?:^\\| \\)[^:#$%>\n]*[:#$%>].* *\\(\\[[0-9;]*[a-zA-Z] *\\)*")


;; FLEX - auto insert paired bracers and strins
(require 'flex-autopair)
(flex-autopair-mode 1)
;; (add-to-list 'tramp-default-proxies-alist
;; 	     '((regexp-quote (system-name)) nil nil))
