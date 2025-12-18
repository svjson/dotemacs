;;; config-lsp-typescript.el --- -*- lexical-binding: t; -*-



;; Forward declarations
(declare-function lsp--cur-workspace "lsp-mode")
(declare-function lsp-organize-imports "lsp-mode")
(defvar lsp-clients-typescript-preferences nil)


;; Variables
(setq lsp-clients-typescript-preferences
      '(:formatOnSave false))



(defun svjson/lsp-organize-imports-if-connected ()
  (when (and (require 'lsp-mode nil t)
             (bound-and-true-p lsp-mode)
             (lsp--cur-workspace)) ;; or (lsp-workspaces) if using multiple
    (lsp-organize-imports)))



;;; config-lsp-typescript ends here
