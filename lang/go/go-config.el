;;; go-config.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:

(require 'treesit)


(setenv "GO111MODULE" "on")
(unless (executable-find "gopls")
  (let ((go-bin-path (concat (getenv "HOME") "/go/bin")))
    (setenv "PATH" (concat (getenv "PATH") (concat ":" go-bin-path)))
    (add-to-list 'exec-path go-bin-path)))

(with-eval-after-load 'projectile
  (add-to-list 'projectile-project-root-files-bottom-up "go.mod")
  (add-to-list 'projectile-project-root-files-bottom-up "go.work"))

(with-eval-after-load 'project
  (add-to-list 'project-vc-extra-root-markers "go.mod"))

(use-package go-mode)

(use-package go-ts-mode
  :mode ("\\.go\\'" . go-ts-mode)
  :hook ((go-ts-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

(add-to-list 'treesit-language-source-alist
             '(go . ("https://github.com/tree-sitter/tree-sitter-go")))

(unless (treesit-language-available-p 'go)
  (ignore-errors
    (treesit-install-language-grammar 'go)))

(add-to-list 'major-mode-remap-alist
             '(go-mode . go-ts-mode))

(provide 'go-config)

;;; go-config.el ends here
