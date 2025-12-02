
;;; config-tree-sitter.el --- Emacs TypeScript + TSX IDE Setup Outline -*- lexical-binding: t; -*-

(use-package treesit-auto
  :hook (after-init . global-treesit-auto-mode)
  :config
  (setq treesit-auto-install 'prompt))




(provide 'config-tree-sitter)

;;; config-tree-sitter.el ends here
