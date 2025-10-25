;;; config-markdown.el -*- lexical-binding: t; flycheck-disabled-checkers: (emacs-lisp-checkdoc); -*-

(require 'config-secrets)



(use-package markdown-mode)

(setq markdown-command "pandoc")



(use-package grip-mode
  :ensure t
  :hook (markdown-mode . grip-mode)
  :config
  (setq grip-update-after-change t)
  (setq grip-preview-use-webkit nil)

  (setq grip-github-user (svjson/token-user :GITHUB_TOKEN_PRIVATE))
  (setq grip-github-password (svjson/token :GITHUB_TOKEN_PRIVATE)))



(provide 'config-markdown)

;;; config-markdown.el ends here
