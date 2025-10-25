;;; config-elisp-eval.el --- Package manager config -*- lexical-binding: t; -*-

(require 'elisp-mode)

(defun svjson/eval-region-or-buffer-with-defvar ()
  "Force re-evaluate all `defvar` declarations in the current buffer or region."
  (interactive)
  (save-excursion
    (let ((start (if (use-region-p) (region-beginning) (point-min)))
          (end (if (use-region-p) (region-end) (point-max))))
      (goto-char start)
      (while (re-search-forward "^(defvar \\([^ ]+\\)" end t)
        (let ((var (intern (match-string 1))))
          (message "Unbinding %s" var)
          (makunbound var))))
    (if (use-region-p)
        (eval-region (region-beginning) (region-end))
      (eval-buffer))))


;; Key bindings
(define-key emacs-lisp-mode-map (kbd "C-c C-e") #'elisp-eval-region-or-buffer)
(define-key emacs-lisp-mode-map (kbd "C-c C-S-e") #'svjson/eval-region-or-buffer-with-defvar)
(global-set-key (kbd "M-m f e b") 'eval-buffer)

(which-key-add-key-based-replacements "M-m f e" "eval ops")


(provide 'config-elisp-eval)

;;; config-elisp-eval.el ends here
