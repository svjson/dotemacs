;;; cpp-config.el --- C++ modes configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'c-ts-mode)
(require 'treesit-auto)
(require 'flycheck)
(require 'lsp-mode)

(use-package c-ts-mode
  :hook (c++-ts-mode . lsp-deferred))

(use-package clang-format
  :ensure t
  :hook ((c-mode
          c-ts-mode
          c++-mode
          c++-ts-mode) . (lambda ()
                           (add-hook 'before-save-hook
                                     #'clang-format-buffer nil t))))

(provide 'cpp-config)
;;; cpp-config.el ends here
