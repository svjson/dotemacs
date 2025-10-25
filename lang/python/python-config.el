;;; python-config.el --- summary -*- lexical-binding: t -*-

(use-package python-ts-mode
  :no-require t
  :straight (:type built-in)
  :after python-mode
  :config
  (define-key python-ts-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region))

(use-package python-mode
  :mode ("\\.py\\'" . python-ts-mode)
  :hook (python-ts-mode . lsp-deferred))

(use-package py-isort
  :hook (python-mode . py-isort-before-save))

(use-package pytest
  :ensure t)


(use-package lsp-pyright
  :after python
  :custom
  (lsp-pyright-python-executable-cmd "python")
  (lsp-pyright-use-library-code-for-types t))

(use-package blacken
  :hook (python-ts-mode . blacken-mode))

(use-package pyvenv)

(provide 'python-config)

;;; python-config.el ends here
