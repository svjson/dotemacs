;;; config-whichkey.el --- summary -*- lexical-binding: t -*-

(require 'config-projectile)


;; use-package

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :custom
  (which-key-idle-delay 0.3)
  (which-key-dont-use-unicode nil)
  (which-key-min-column-description-width 15)
  (which-key-popup-type 'minibuffer))


;; Prexix/map replacements

;; Flycheck
(which-key-add-key-based-replacements "C-c !" "Flycheck")

;; File/Buffer ops
(which-key-add-key-based-replacements "M-m f" "file ops")

;; Projectile
(which-key-add-keymap-based-replacements projectile-command-map "f" "projectile-find-files")

;; Treemacs
(which-key-add-key-based-replacements "M-m t" "lsp-treemacs")
(which-key-add-key-based-replacements "C-c C-t" "treemacs")

;; LSP
(which-key-add-key-based-replacements "C-c l" "lsp")
(which-key-add-key-based-replacements "C-c l =" "Formatting")
(which-key-add-key-based-replacements "C-c l a" "Code actions")
(which-key-add-key-based-replacements "C-c l r" "Refactor")
(which-key-add-key-based-replacements "C-c l g" "Goto")
(which-key-add-key-based-replacements "C-c l G" "lsp-ui Goto")
(which-key-add-key-based-replacements "C-c l T" "Toggle modes")
(which-key-add-key-based-replacements "C-c l F" "Edit workspace")
(which-key-add-key-based-replacements "C-c l F" "Manage Workspace")

;; gptel
(which-key-add-key-based-replacements "M-m g" "gptel")




(provide 'config-whichkey)

;;; config-whichkey.el ends here
