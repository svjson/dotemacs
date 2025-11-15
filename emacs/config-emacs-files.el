;;; config-emacs-files.el --- Early initialization -*- lexical-binding: t; -*-

(setq lock-file-name-transforms '((".*" "~/.emacs.d/lock-files/" t)))

;: Get rid of tmp files in source trees by redirecting all backup files to
;; a single directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory)))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Redirect auto-save files too
(let ((auto-save-dir (expand-file-name "auto-saves/" user-emacs-directory)))
  (unless (file-exists-p auto-save-dir)
    (make-directory auto-save-dir t))
  (setq auto-save-file-name-transforms
	      `((".*" ,auto-save-dir t))))


(provide 'config-emacs-files)

;;; config-emacs-files.el ends here
