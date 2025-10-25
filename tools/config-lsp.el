;;; config-lsp.el --- LSP config -*- lexical-binding: t; -*-

(use-package lsp-mode
  :ensure t
  :commands lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-auto-guess-root t)
  :config
  (setq lsp-enable-symbol-highlighting t
        lsp-enable-on-type-formatting t)
  (define-key lsp-mode-map [menu-bar lsp-mode]
              (cons "LSP" lsp-mode-menu))
  (define-key lsp-mode-map (kbd "C-M-<return>")
              'svjson/lsp-execute-code-action-at-point-prompt))

(require 'lsp-mode)

(defun svjson/lsp-execute-code-action-at-point-prompt ()
  "Force selection of code action - no auto select!"
  (interactive)
  (lsp-execute-code-action (lsp--select-action (lsp-code-actions-at-point))))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable nil))


(use-package helm-lsp
  :ensure t
  :config
  (global-set-key (kbd "C-c o s") 'helm-lsp-workspace-symbol))


;; Key Bindings




(provide 'config-lsp)
;;; config-lsp.el ends here
