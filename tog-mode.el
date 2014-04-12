;;; tog-mode --- Toggle major modes -*- lexical-binding: t; -*-
;;; Commentary:
;; A minor mode for toggling major modes. For example, you may want to
;; toggle between latex mode and org-mode when writing reveal.js
;; presentations.

;;; Code:

(defvar tog-mode-modes nil
  "A list of modes to toggle through.")

(make-variable-buffer-local 'tog-mode-modes)

(defun tog-toggle-modes ()
  "Toggle between the various modes in this buffer's tog-mode-modes variable."
  (interactive)
  (if (and tog-mode-modes (> (length tog-mode-modes) 0))
      (let ((modes tog-mode-modes)
            (mode (car tog-mode-modes)))
        (funcall mode)
        (tog-mode)
        (setq tog-mode-modes (append (cdr modes) (list mode))))))

(define-minor-mode tog-mode
  "A minor mode for toggling major modes - use tog-setup to start it.

This mode provides a keybinding for toggling between a list of
major modes. For example, latex-mode and org-mode when
writing reveal.js presentations."
  nil                                   ; Not on by default
  " tog"                                ; modeline indicator
  '(([?\C-c ?#] . tog-toggle-modes))    ; keymap
  :group 'tog)

(defun tog-setup (modes)
  "Setup tog-mode.

The parameter MODES should contain a list of callable functions
which activate major modes.  For example:

\(list 'org-mode 'message-mode\)

Your first toggle will be to the car of the list, then the second
element, and so on."
  (setq tog-mode-modes modes)
  (tog-mode))

(provide 'tog-mode)
;;; tog-mode ends here
