;; This file contains all user defined funtions.
;; Theese are stores seperately for abbreviations sake.

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
;prettyfy
(require 'color)
(let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))
