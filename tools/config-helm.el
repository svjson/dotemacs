;;; config-helm.el --- summary -*- lexical-binding: t -*-



;;; Forward-declare helm symbols

(defvar helm-find-files-map)
(defvar helm-kill-when-done)
(declare-function helm-autoresize-mode "helm-core.el")
(declare-function helm-find-files-1 "helm-files.el")



;;; Inform autoloading

(autoload 'svjson/helm-find-home "config-helm-commands" nil t)
(autoload 'svjson/helm-find-files-here "config-helm-commands" nil t)
(autoload 'svjson/helm-user-config "config-helm-commands" nil t)
(autoload 'svjson/helm-complete-dwim "config-helm-commands" nil t)
(autoload 'svjson/helm-kill-runaway-buffers "config-helm-commands" nil t)



;; use-package

(use-package helm
  :ensure t
  :init
  (setq completion-ignore-case nil
        helm-autoresize-max-height 30
        helm-autoresize-min-height 30
        helm-autoresize-mode 1
        helm-kill-when-done t
	      helm-case-fold-search nil
        helm-display-header-line nil
	      helm-echo-input-in-header-line t
        helm-split-window-inside-p nil
	      read-file-name-completion-ignore-case nil)

  :custom
  (helm-ff-auto-update-initial-value nil)
  (helm-buffers-fuzzy-matching t)
  (helm-ff-skip-dots f)
  (helm-M-x-fuzzy-match t)
  (helm-recentf-fuzzy-match t)

  :bind (;; Global

         ;; Helm-global
         (:map helm-map
               ("TAB" . #'svjson/helm-complete-dwim)
               ("<tab>" . #'svjson/helm-complete-dwim))

	       ;; helm-find-files
	       )

  :config
  (helm-mode 1)
  (helm-autoresize-mode 1))

(use-package helm-xref
  :ensure t)


;; Helm buffer display config

(add-to-list 'display-buffer-alist
             '("\\*helm.*\\*"
               (display-buffer-at-bottom)
               (inhibit-same-window . t)
               (window-height . 0.3)))




;;; Key Bindings


; Global
(global-set-key (kbd "M-g e") 'svjson/helm-user-config)
(global-set-key (kbd "M-g h") #'svjson/helm-find-home)
(global-set-key (kbd "M-s o") #'helm-occur)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'svjson/helm-find-files-here)
(global-set-key (kbd "C-x b") #'helm-mini)
(global-set-key (kbd "M-y") #'helm-show-kill-ring)

; helm-find-files
(define-key helm-find-files-map (kbd "RET") #'helm-maybe-exit-minibuffer)
(define-key helm-find-files-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "<tab>") #'helm-execute-persistent-action)


(provide 'config-helm)

;;; config-helm.el ends here
