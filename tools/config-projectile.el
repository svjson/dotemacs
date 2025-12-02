;;; config-projectile.el --- Modeline config -*- lexical-binding: t; -*-

(require 'config-treemacs)
(require 'cl-lib)
(require 'subr-x)



;; Forward declarations
(declare-function projectile-project-root "projectile")


;; Variables

(defvar svjson/last-projectile-project-root nil
  "Most recently used valid `projectile-project-root`.")



;; Hooks

(defun svjson/record-projectile-root ()
  "Update `svjson/last-projectile-project-root` when switching buffers."
  (when (buffer-file-name)
    (when-let ((proj-root (or (vc-call-backend 'Git 'root default-directory)
                              (when (fboundp 'magit-toplevel)
                                (ignore-errors (magit-toplevel)))
                              (ignore-errors (projectile-project-root)))))
      (when (vc-call-backend 'Git 'root proj-root)
        (setq svjson/last-projectile-project-root proj-root)))))



;; Commands

(defun svjson/projectile-find-file-smart ()
    "Try to find file in current project, or fallback to last known project."
    (interactive)
    (let ((default-directory
           (or (ignore-errors (projectile-project-root))
               svjson/last-projectile-project-root
               default-directory)))
      (call-interactively #'projectile-find-file)))



;; use-package

(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm
        projectile-enable-caching t)
  :hook (after-init . projectile-mode)
  :bind-keymap ("M-m p" . projectile-command-map)
  :bind (:map projectile-command-map
              ("f" . #'svjson/projectile-find-file-smart))
  :config
  (setq projectile-project-root-files-bottom-up
        (append '(".projectile") projectile-project-root-files-bottom-up))

  ;; which-key
  (with-eval-after-load 'which-key
    (when (fboundp 'which-key-add-key-based-replacements)
      (which-key-add-key-based-replacements "M-m p" "projectile")))

  ;; Track project root
  (add-hook 'buffer-list-update-hook #'svjson/record-projectile-root)

  ;; Treat ~/.emacs.d/ as a project root
  (add-to-list 'projectile-known-projects "~/.emacs.d/"))


(use-package helm-projectile
  :after (helm projectile)
  :hook (projectile-mode . helm-projectile-on)
  :config
  (defun svjson/helm-projectile--workspace-files ()
    "Collect workspace files from Treemacs projects."
    (require 'treemacs nil t)
    (when (and (featurep 'treemacs)
               (fboundp 'treemacs-current-workspace))
      (let ((workspace (treemacs-current-workspace)))
        (when workspace
          (let ((projectile-require-project-root nil))
            (cl-mapcan
             (lambda (project-path)
               (when (file-exists-p project-path)
                 (mapcar (lambda (file)
                           (expand-file-name file (file-name-as-directory project-path)))
                         (cl-remove-if
                          (lambda (f)
                            (string-match-p "/node_modules/" f))
                          (projectile-project-files project-path)))))
             (mapcar #'treemacs-project->path
                     (treemacs-workspace->projects workspace))))))))

  (defvar helm-source-projectile-files-in-workspace
    (helm-build-sync-source "Projectile files in workspace"
      :candidates (lambda ()
                    (with-helm-current-buffer
                      (or (svjson/helm-projectile--workspace-files) '())))
      :keymap helm-projectile-find-file-map
      :help-message 'helm-ff-help-message
      :mode-line helm-read-file-name-mode-line-string
      :action helm-projectile-file-actions
      :persistent-action #'helm-projectile-file-persistent-action
      :persistent-help "Preview file"))

  (helm-projectile-command
   "find-file-in-workspace-projects"
   'helm-source-projectile-files-in-workspace
   "Find file in workspace: " t)

  (define-key projectile-command-map (kbd "w")
              #'helm-projectile-find-file-in-workspace-projects))




(provide 'config-projectile)

;;; config-projectile.el ends here
