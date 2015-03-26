;; Code that loads only when emacs is tunnig under the graphical interface
;; no more editing config after pull.

(if (display-graphic-p)
    (progn				;if graphical
      (set-frame-font "-outline-Ubuntu Mono-normal-normal-normal-mono-*-*-*-*-c-*-iso8859-1")
      (set-face-attribute 'default nil :height 120)
      ;get rid off the toolbar to get a cleaner view.
      (tool-bar-mode -1)
;scroll bars fuck em tool
      (scroll-bar-mode -1)
;I AM LONE WUF, i need no menu!
      (menu-bar-mode -1)
;always start emacs in split pane mode
      (split-window-horizontally)
      ;highlight the current marked line
      (global-hl-line-mode 1)
      (set-face-background 'hl-line "midnight blue")

      ;; well since windows is what graphical means for me this goes here for now:
      (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
      (setq ispell-program-name "aspell")
      (setq ispell-personal-dictionary "en")

      ;; Set default method for tramp on windows to be plink
      (setq tramp-default-method "plink")

      ;prettyfy
      (require 'color)
      (let ((bg (face-attribute 'default :background)))
	(custom-set-faces
	 `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
	 `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
	 `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
	 `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
	 `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))


      ;; POWERLINE - awesome modeline!
      (require 'powerline)
      (powerline-default-theme)
      (setq powerline-arrow-shape 'curve)

      ; start emacs in fullscreen (windows specific)
; this has to be last cause of some window error along the line in this config, figure out where
      (w32-send-sys-command 61488)
      )					;else

  ;(xterm-mouse-mode 1)
  )
