;;; config-elisp-debug.el --- Package manager config -*- lexical-binding: t; -*-

(require 'elisp-mode)

(defun svjson/toggle-debug-on-error ()
  "Toggle `debug-on-error` and `debug-on-signal`."
  (interactive)
  (setq debug-on-error (not debug-on-error)
        debug-on-signal debug-on-error)
  (message "debug-on-error: %s, debug-on-signal: %s"
           debug-on-error debug-on-signal))

(defun svjson/elisp-regex-groups (test-str re)
  "Test regex RE against TEST-STR and return match groups."
  (when (string-match re test-str)
    (cl-loop for i from 1 to (1- (/ (length (match-data)) 2))
             collect (list i (match-string i test-str)))))



;; Key Bindings

(define-key emacs-lisp-mode-map (kbd "C-c C-d") #'svjson/toggle-debug-on-error)


(provide 'config-elisp-debug)

;;; config-elisp-debug.el ends here
