;;; config-helm-ag.el --- summary -*- lexical-binding: t -*-

(require 'config-treemacs)


;; Helm ag specializations

(defun svjson/helm-do-ag-here ()
  "Start helm-ag in current directory without prompting for it."
  (interactive)
  (message default-directory)
  (helm-do-ag default-directory))

(defun svjson/helm-do-ag-workspace-root ()
  "Start helm-ag in the common ancestor directory of all workspace projects."
  (interactive)
  (helm-do-ag (svjson/treemacs-common-root)))

(defun svjson/helm-do-ag-project-root ()
  "Use helm-do-ag-project-root or find other dir."
  (interactive)
  (if-let ((root (helm-ag--project-root)))
      (helm-do-ag-project-root)
    (helm-do-ag "~/.emacs.d")))

(use-package helm-ag
  :after helm
  :commands (helm-do-ag
             helm-do-ag-project-root
             svjson/helm-do-ag-workspace-root
             svjson/helm-do-ag-project-root
             svjson/helm-do-ag-here)
  :config
  (setq helm-ag-base-command "ag --nocolor --nogroup"))



;; Key Bindings
(global-set-key (kbd "M-g a") #'svjson/helm-do-ag-workspace-root)
(global-set-key (kbd "M-g s") #'svjson/helm-do-ag-project-root)
(global-set-key (kbd "M-g d") #'svjson/helm-do-ag-here)



(provide 'config-helm-ag)

;;; config-helm-ag.el ends here
