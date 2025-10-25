
;;; csharp-config.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:

(use-package csharp-mode
  :mode "\\.cs\\'"
  :hook (csharp-ts-mode . lsp-deferred))

(provide 'csharp-config)

;;; csharp-config.el ends here
