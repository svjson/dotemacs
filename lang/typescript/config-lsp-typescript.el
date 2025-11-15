;;; config-lsp-typescript.el --- -*- lexical-binding: t; -*-

(defun svjson/lsp-organize-imports-if-connected ()
  (when (and (require 'lsp-mode nil t)
             (bound-and-true-p lsp-mode)
             (lsp--cur-workspace)) ;; or (lsp-workspaces) if using multiple
    (lsp-organize-imports)))

;;; config-lsp-typescript ends here
