;;; config-undo-tree.el --- Theme setup -*- lexical-binding: t; -*-


;; use-package

(use-package undo-tree
  :ensure t
  :init
  (make-directory svjson/undo-tree-history-dir t)
  (setq undo-tree-history-directory-alist
        `(("." . ,(expand-file-name "undo-tree-history/" user-emacs-directory))))
  (advice-add 'undo-tree-make-history-save-file-name :override
              #'svjson/undo-tree-make-history-save-file-name)
  :config
  (global-undo-tree-mode))

;; Make it sane

(defvar svjson/undo-tree-history-dir
  (expand-file-name "undo-tree-history/" user-emacs-directory))

(defvar undo-tree-history-directory-alist)

(defun svjson/undo-tree-make-history-save-file-name (file)
  "Use the same naming scheme as backups for undo-tree history FILE."
  (let* ((filename (expand-file-name buffer-file-name))
         (safe-name (replace-regexp-in-string "/" "!" filename)))
    (expand-file-name safe-name (cdr (assoc "." undo-tree-history-directory-alist)))))



;; Key Bindings

(global-set-key (kbd "C-_") 'undo-tree-undo)
(global-set-key (kbd "C-M-_") 'undo-tree-redo)
(global-set-key (kbd "M-_") 'undo-tree-redo)
(global-set-key (kbd "C-x _") 'undo-tree-visualize)



(provide 'config-undo-tree)

;;; config-undo-tree.el ends here
