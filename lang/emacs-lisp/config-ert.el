;;; config-ert.el --- Package manager config -*- lexical-binding: t; -*-

(defun svjson/run-ert-tests-in-buffer ()
  "Run all ERT tests defined in the current buffer."
  (interactive)
  (let ((test-names nil))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "^(ert-deftest \\([^ ]+\\)" nil t)
        (setq test-names (append test-names (list (intern (match-string 1)))))))
    (message "%s" test-names)
    (ert `(member ,@test-names))))

(define-key emacs-lisp-mode-map (kbd "C-c t e") #'ert-run-tests-interactively)
(define-key emacs-lisp-mode-map (kbd "C-c t f") #'svjson/run-ert-tests-in-buffer)

(provide 'config-ert)

;;; config-ert.el ends here
