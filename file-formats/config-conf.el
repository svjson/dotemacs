;;; config-conf.el --- Package manager config -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.env\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . conf-mode)) ;; for .env.production, etc.
(add-to-list 'auto-mode-alist '("\\.properties\\'" . conf-mode))

(provide 'config-conf)

;;; config-conf.el ends here
