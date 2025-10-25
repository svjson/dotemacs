;;; config-elisp-global.el --- Global keybindings -*- lexical-binding: t; flycheck-disabled-checkers: (emacs-lisp-checkdoc); -*-


;; Eval functions for global use

(defun svjson/eval-last-sexp-in-any-mode ()
  "Eval the last sexp before point, ignoring major mode syntax."
  (interactive)
  (save-excursion
    (let ((read-symbol-positions t))
      (backward-sexp)
      (let* ((start (point))
             (end (progn (forward-sexp) (point)))
             (form (read (buffer-substring-no-properties start end))))
	      (print form)
        (message "%S" (eval form))))))

(defun svjson/eval-last-lisp-line ()
  "Evaluate the last line as Emacs Lisp, useful in non-Emacs Lisp modes."
  (interactive)
  (let* ((line (thing-at-point 'line t))
         (form (read line))
         (result (eval form)))
    (message "=> %S" result)
    result))



;; Key Bindings

(global-set-key (kbd "C-x C-e") #'svjson/eval-last-sexp-in-any-mode)

;;; config-elisp-global.el ends here
