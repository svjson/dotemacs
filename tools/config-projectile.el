;;; config-projectile.el --- Modeline config -*- lexical-binding: t; -*-

(require 'config-treemacs)


;; use-package

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :config
  (setq projectile-completion-system 'helm
        projectile-enable-caching t
	      projectile-project-root-files-bottom-up
	      (append '(".projectile") projectile-project-root-files-bottom-up))

  (which-key-add-key-based-replacements "M-m p" "projectile")
  :bind
  ("M-m p" . projectile-command-map))

(require 'projectile)



;; Track last active projectile project

(defvar svjson/last-projectile-project-root nil
  "Most recently used valid `projectile-project-root`.")

(defun svjson/record-projectile-root ()
  "Update `svjson/last-projectile-project-root` when switching buffers."
  (let ((proj-root (ignore-errors (projectile-project-root))))
    (when proj-root
      (setq svjson/last-projectile-project-root proj-root))))

(add-hook 'buffer-list-update-hook #'svjson/record-projectile-root)

(defun svjson/projectile-find-file-smart ()
  "Try to find file in current project, or fallback to last known project."
  (interactive)
  (let ((default-directory
          (or (ignore-errors (projectile-project-root))
              svjson/last-projectile-project-root
              default-directory)))
    (call-interactively #'projectile-find-file)))



;; helm-projectile

(use-package helm-projectile
  :after (helm projectile)
  :config
  (helm-projectile-on))

(require 'helm-projectile)

(declare-function helm-projectile-find-file-in-workspace-projects "helm-projectile")

(eval-after-load 'helm-projectile
  '(progn
     (defvar helm-source-projectile-files-in-workspace
     (helm-build-sync-source "Projectile files in workspace"
       :candidates (lambda ()
                     (with-helm-current-buffer
                       (let ((projectile-require-project-root nil))
                         (cl-mapcan
                          (lambda (project)
                            (when (file-exists-p project)
                              (mapcar (lambda (file)
                                        (expand-file-name file project))
                                      (cl-remove-if (lambda (f)
                                                      (string-match-p "/node_modules/" f))
                                                    (projectile-project-files project)))))
                          (mapcar #'file-name-as-directory
                                  (mapcar #'treemacs-project->path (treemacs-workspace->projects (treemacs-current-workspace))))))))
       :keymap helm-projectile-find-file-map
       :help-message 'helm-ff-help-message
       :mode-line helm-read-file-name-mode-line-string
       :action helm-projectile-file-actions
       :persistent-action #'helm-projectile-file-persistent-action
       :persistent-help "Preview file"))

     (helm-projectile-command "find-file-in-workspace-projects" 'helm-source-projectile-files-in-workspace "Find file in workspace: " t)

     (define-key projectile-command-map (kbd "w") #'helm-projectile-find-file-in-workspace-projects)))



;; Project index

(add-to-list 'projectile-known-projects "~/.emacs.d/")



;; Key Bindings

(define-key projectile-command-map (kbd "f") 'svjson/projectile-find-file-smart)




(provide 'config-projectile)

;;; config-projectile.el ends here
