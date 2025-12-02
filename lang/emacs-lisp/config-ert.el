;;; config-ert.el --- Package manager config -*- lexical-binding: t; -*-

(require 'ert)

(defun svjson/run-ert-tests-in-buffer ()
  "Run all ERT tests defined in the current buffer."
  (interactive)
  (let ((test-names (seq-filter
                     (lambda (test)
                       (equal (buffer-file-name)
                              (ert-test-file-name
                               (ert-get-test test))))
                     (apropos-internal "" #'ert-test-boundp))))
    (message "%s" test-names)
    (ert `(member ,@test-names))))

(define-key emacs-lisp-mode-map (kbd "C-c t e") #'ert-run-tests-interactively)
(define-key emacs-lisp-mode-map (kbd "C-c t f") #'svjson/run-ert-tests-in-buffer)

(provide 'config-ert)

;;; config-ert.el ends here
