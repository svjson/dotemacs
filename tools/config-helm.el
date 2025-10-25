;;; config-helm.el --- summary -*- lexical-binding: t -*-



;;; Will be defined by helm-files
(defvar helm-find-files-map)
(declare-function helm-find-files-1 "helm-files.el")



;; use-package

(use-package helm
  :ensure t
  :init
  (setq completion-ignore-case nil
        helm-autoresize-max-height 30
        helm-autoresize-min-height 30
        helm-autoresize-mode 1
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

(require 'helm)
(require 'helm-core)
(require 'helm-command)


;; Helm buffer display config

(add-to-list 'display-buffer-alist
             '("\\*helm.*\\*"
               (display-buffer-at-bottom)
               (inhibit-same-window . t)
               (window-height . 0.3)))



;; Helm recipes

(defun svjson/helm-ff-complete ()
  "Safely complete filename without triggering preview errors."
  (interactive)
  (let ((display-buffer-alist nil))     ; prevent preview split errors
    (helm-execute-persistent-action)))


;; Here lies the Great Helm TAB War of 2025
;; Finally won by me, myself and I  after countless refreshes and nil sources.
(defun svjson/helm-complete-dwim ()
  "Extend Helm minibuffer input to the longest common prefix of visible candidates.
Does not refresh or trigger persistent actions."
  (interactive)
  (when (and (boundp 'helm-alive-p) helm-alive-p)
    (let* ((input helm-pattern)
           ;; get the visible candidates as plain strings
           (cands (mapcar (lambda (c)
                            (if (consp c) (car c) c))
                          (helm-get-candidates (helm-get-current-source))))
           ;; keep only those that begin with current input
           (matches (cl-remove-if-not
                     (lambda (s)
                       (string-prefix-p input s))
                     cands)))
      (when matches
        (let ((prefix (try-completion input matches)))
          (when (and (stringp prefix)
                     (not (string-equal prefix input)))
            ;; replace minibuffer text
            (delete-minibuffer-contents)
            (insert prefix)))))))


(defun svjson/helm-find-home ()
  "Open Helm find-files in ~/."
  (interactive)
  (helm-find-files-1 "~/"))


(defun svjson/helm-find-files-here ()
  "Launch `helm-find-files` in the directory of the current buffer."
  (interactive)
  (let ((default-directory (or (and buffer-file-name
                                    (file-name-directory buffer-file-name))
                               default-directory)))
    (helm-find-files nil)))


(defun svjson/helm-user-config ()
  "Visit user config files."
  (interactive)
  (let* ((base-dir user-emacs-directory)
         (files (append
                 (list (expand-file-name "init.el" base-dir))
                 (directory-files-recursively (expand-file-name "config" base-dir) "\\.el$")
                 (directory-files-recursively (expand-file-name "global" base-dir) "\\.el$")
                 (directory-files-recursively (expand-file-name "modes" base-dir) "\\.el$"))))
    (helm :sources (helm-build-sync-source "Emacs User Config"
                     :candidates files
                     :fuzzy-match t
                     :action '(("Open File" . find-file))))))



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
