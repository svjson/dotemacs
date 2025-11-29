;;; config-elisp-symbol-bindings.el --- Package manager config -*- lexical-binding: t; -*-

(require 'elisp-mode)

(defun svjson/delete-face-at-point ()
  "Delete/undef the face at point so it can be redefined with `defface`."
  (interactive)
  (svjson/el/delete-face (symbol-at-point)))

(defun svjson/el/delete-face (face-symbol)
  (if-let ((face (and (symbolp face-symbol) (facep face-symbol) face-symbol)))
      (progn
        (face-spec-set face nil)
        (put face 'face-defface-spec nil)
        (message "Face `%s` deleted. You can now redefine it." face))
    (message "No face at point.")))

(defun svjson/el/unbind-symbol (symbol)
  (let ((symbol (if (symbolp symbol) symbol (intern symbol))))
    (cond
     ((fboundp symbol)
      (fmakunbound symbol))

     ((facep symbol)
      (svjson/el/delete-face symbol))

     (t
      (progn
        (makunbound symbol)
        (message "Unbound symbol '%s" symbol))))))

(defun svjson/unbind-symbol-at-point ()
  (interactive)
  (when-let ((symbol (thing-at-point 'symbol)))
    (svjson/el/unbind-symbol symbol)))

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

(defun svjson/el/extract-prefix (symbol &optional exclude-delimiter)
  "Extract the prefix part of a symbol."
  (let ((name (symbol-name symbol)))
    (when (or (string-match "--" name)
              (string-match "/" name))
      (substring name 0 (if exclude-delimiter (match-beginning 0) (match-end 0))))))

(defun svjson/el/buffer-prefixes ()
  "Find all symbol prefixes present in buffer declarations."
  (save-excursion
    (goto-char (point-min))
    (let (prefixes form)
      (while (setq form (ignore-errors (read (current-buffer))))
        (when (memq (car form)
                    (list 'cl-defun
                          'cl-defgeneric
                          'cl-defmethod
                          'defconst
                          'defcustom
                          'defface
                          'defmacro
                          'defun
                          'defvar
                          'ert-deftest))
          (when-let ((prefix (svjson/el/extract-prefix (cadr form))))
            (unless (member prefix prefixes)
              (push prefix prefixes)))))
      prefixes)))

(defun svjson/el/prefix-at-point-or-file (&optional prefixes)
  "Get the symbol prefix at point or fall back on PREFIXES or file name."
  (if-let ((sym (symbol-at-point)))
      (svjson/el/extract-prefix sym)
    (or (car prefixes) (file-name-base (buffer-file-name)))))

(defun svjson/el/symbols-with-prefix (prefix)
  "Find all declared symbols starting with PREFIX in the global ns."
  (let (symbols)
    (mapatoms
     (lambda (sym)
       (when (string-prefix-p prefix (symbol-name sym))
         (push sym symbols))))
    symbols))

(defun svjson/el/unbind-all-with-prefix (&optional prefix)
  "Unbind all symbols starting with PREFIX."
  (interactive)
  (let* ((buffer-prefixes (svjson/el/buffer-prefixes))
         (prefix (or prefix
                     (completing-read "Unbind symbols with prefix: "
                                      buffer-prefixes
                                      nil
                                      nil
                                      (svjson/el/prefix-at-point-or-file buffer-prefixes))))
         (symbols (svjson/el/symbols-with-prefix prefix)))
    (dolist (sym symbols)
      (svjson/el/unbind-symbol sym))))



;; Key Bindings

(define-key emacs-lisp-mode-map (kbd "C-c C-u") #'svjson/unbind-symbol-at-point)


(provide 'config-elisp-symbol-bindings)

;;; config-elisp-symbol-bindings.el ends here
