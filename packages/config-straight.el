;;; config-straight.el --- straight.el package manager setup -*- lexical-binding: t; -*-

;; Do the wacky straight.el bootstrapping
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(defvar straight-use-package-by-default nil
  "Make sure straight does nothing unless asked to")

(provide 'config-straight)

;;; config-straight.el ends here
