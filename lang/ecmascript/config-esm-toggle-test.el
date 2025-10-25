;;; config-esm-toggle-test.el --- Emacs TypeScript + TSX IDE Setup Outline -*- lexical-binding: t; -*-


;; Toggle test/impl buffer functions

(defun svjson/toggle-src-test-other-window ()
  "Toggle between src/foo/bar.ts and test/foo/bar.test.ts.

Opens in other window."
  (interactive)
  (svjson/toggle-src-test t))

(defun svjson/toggle-src-test (&optional other-windowp)
  "Toggle between src/foo/bar.ts and test/foo/bar.test.ts.

Opens in other window for non-nil values of OTHER-WINDOWP."
  (interactive)
  (let* ((ff-fn (if other-windowp #'find-file-other-window #'find-file))
         (f (buffer-file-name))
         (is-src (string-match "/src/\\(.*\\)\\.ts\\'" f))
         (is-test (string-match "/test/\\(.*\\)\\.test\\.ts\\'" f)))
    (cond
     (is-src (funcall ff-fn (replace-regexp-in-string "/src/\\(.*\\)\\.ts\\'"
                                                   "/test/\\1.test.ts" f)))
     (is-test (funcall ff-fn (replace-regexp-in-string "/test/\\(.*\\)\\.test\\.ts\\'"
                                                    "/src/\\1.ts" f)))
     (t (message "Not a src/ or test/ file")))))




(provide 'config-esm-toggle-test)

;;; config-esm-toggle-test.el ends here
