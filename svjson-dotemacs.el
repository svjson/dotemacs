;;; svjson-dotemacs.el --- summary -*- lexical-binding: t -*-

(dolist (file '("svjson-local-secrets.el" "svjson-theme-contexts.el"))
  (let ((local-file (expand-file-name (format "config/%s" file) user-emacs-directory)))
    (when (file-exists-p local-file)
      (load local-file))))

(require 'packages-config)
(require 'emacs-config)
(require 'editor-config)
(require 'file-formats-config)
(require 'ui-config)
(require 'tools-config)
(require 'lang-config)
(require 'modes-config)
(require 'custom-config)


(provide 'svjson-dotemacs)

;;; svjson-dotemacs ends here
