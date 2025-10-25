;;; config-treemacs.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:


;; Require packages

(use-package treemacs
  :defer t
  :hook (treemacs-mode . (lambda () (scroll-bar-mode -1)))
  :bind (("C-c C-t t" . treemacs)
         ("C-c C-t C-t" . treemacs)
         ("C-c C-t -" . treemacs-collapse-all-projects)
         ("C-c C-t g" . treemacs-find-file))
  :config
  (define-key treemacs-workspace-map (kbd "p") #'treemacs-previous-workspace)
  )

(use-package lsp-treemacs
  :bind (("M-m t c" . lsp-treemacs-call-hierarchy)
         ("M-m t i" . lsp-treemacs-implementations)
         ("M-m t r" . lsp-treemacs-references)
         ("M-m t s" . lsp-treemacs-symbols)
         ("M-m t t" . lsp-treemacs-type-hierarchy))
  :config
  (lsp-treemacs-sync-mode 1))

(use-package all-the-icons
  :after treemacs
  :if (display-graphic-p))

(use-package treemacs-all-the-icons
  :after all-the-icons
  :config
  (treemacs-load-theme "all-the-icons"))

(require 'treemacs)
(require 'treemacs-interface)
(require 'treemacs-workspaces)
(require 'treemacs-themes)


;; Custom functions

(defun treemacs-previous-workspace ()
  "Switch to the previous treemacs workspace."
  (interactive)
  (treemacs-next-workspace -1))

(defun svjson/treemacs-common-root ()
  "Return the common root of all projects in the current Treemacs workspace.

Finds and returns the top-most common root directory of all treemacs
projects in the current treemacs workspace."
  (when-let* ((workspace (treemacs-current-workspace))
              (projects (treemacs-workspace->projects workspace))
              (paths (mapcar #'treemacs-project->path projects)))
    (file-name-directory
     (try-completion "" (mapcar #'file-truename paths)))))




(provide 'config-treemacs)

;;; config-treemacs.el ends here
