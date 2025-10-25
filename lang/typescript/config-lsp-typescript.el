;;; config-lsp-typescript.el --- -*- lexical-binding: t; -*-

(require 'lsp-mode)



(defun svjson/lsp-organize-imports-if-connected ()
  (when (and (bound-and-true-p lsp-mode)
             (lsp--cur-workspace)) ;; or (lsp-workspaces) if using multiple
    (lsp-organize-imports)))

;;; config-lsp-typescript ends here
