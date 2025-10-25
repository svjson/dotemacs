;;; svjson-dotemacs.el --- summary -*- lexical-binding: t -*-

(let ((local-file (expand-file-name "config/svjson-local-secrets.el" user-emacs-directory)))
  (when (file-exists-p local-file)
    (load local-file)))

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
