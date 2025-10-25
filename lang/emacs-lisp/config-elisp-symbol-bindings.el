;;; config-elisp-symbol-bindings.el --- Package manager config -*- lexical-binding: t; -*-

(require 'elisp-mode)

(defun svjson/delete-face-at-point ()
  "Delete/undef the face at point so it can be redefined with `defface`."
  (interactive)
  (let* ((sym (symbol-at-point))
         (face (and (symbolp sym) (facep sym) sym)))
    (if (not face)
        (message "No face at point.")
      ;; Remove from internal face storage
      (face-spec-set face nil)
      (put face 'face-defface-spec nil)
      (message "Face `%s` deleted. You can now redefine it." face))))

(defun svjson/unbind-symbol-at-point ()
  (interactive)
  (let ((symbol (thing-at-point 'symbol)))
    (cond
     ((facep symbol)
      (svjson/delete-face-at-point))

     (t
      (progn
        (makunbound (intern symbol))
        (message "Unbound symbol '%s" (intern symbol)))))))

(defun svjson/nuke-defface-from-orbit (face)
  "Remove all specs and properties for FACE, even if it was defined incorrectly."
  (interactive
   (list (intern (completing-read "Face to reset: " (face-list)))))
  (when (facep face)
    (face-spec-set face nil)
    (put face 'face-defface-spec nil)
    (put face 'customized-face nil)
    (put face 'saved-face nil)
    (put face 'customized-face-comment nil)
    (message "Face `%s` forcibly reset. You may now re-`defface` it." face)))



;; Key Bindings

(define-key emacs-lisp-mode-map (kbd "C-c C-u") #'svjson/unbind-symbol-at-point)


(provide 'config-elisp-symbol-bindings)

;;; config-elisp-symbol-bindings.el ends here
