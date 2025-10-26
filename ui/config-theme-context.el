;;; config-theme-context.el -*- lexical-binding: t; flycheck-disabled-checkers: (emacs-lisp-checkdoc); -*-

(require 'color)


;; Vars

(defvar svjson/current-context nil)
(defconst svjson/theme-contexts nil)



;; Local configuration

(let ((local-file (expand-file-name "config/svjson-theme-contexts.el" user-emacs-directory)))
  (when (file-exists-p local-file)
    (load local-file)))



;; Theme context loading and switching

(defun svjson/context-theme (theme)
  "Load THEME ephemerally - no persistence, no stacking."
  (interactive
   (list (intern (completing-read "Theme: " (custom-available-themes)))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))

(defun svjson/show-context ()
  (interactive)
  (if svjson/current-context
      (message "=> %s" svjson/current-context)
    (message "No context set")))

(defun svjson/enable-context-theme (theme-name)
  (let ((context-theme (seq-find (lambda (th) (string-equal theme-name (plist-get th :name))) svjson/theme-contexts)))
    (svjson/context-theme (plist-get context-theme :theme))
    (setq svjson/current-context theme-name)
    (dired (plist-get context-theme :root))))


(defun svjson/helm-theme-context ()
  (interactive)
  (require 'helm)
  (helm :sources (helm-build-sync-source "Theme Context"
                   :candidates (mapcar (lambda (th) (plist-get th :name)) svjson/theme-contexts)
                   :fuzzy-match t
                   :action #'svjson/enable-context-theme)))



;; Color manipulation

(defun svjson/hex-6 (color-name)
  (apply #'color-rgb-to-hex (append (color-name-to-rgb color-name) '(2))))

(defun brighten-hex-color-at-point (&optional percent)
  "Brighten the hex color at point by PERCENT (default 20)."
  (interactive "P")
  (let* ((percent (or percent 20))
         (bounds (bounds-of-thing-at-point 'sentence))
         (hex (string-trim (and bounds (buffer-substring-no-properties
                                        (car bounds) (cdr bounds))))))
    (message "%s" hex)
    (if (and hex (string-match-p "^#\\([0-9a-fA-F]\\{6\\}\\)$" hex))
        (let ((bright (svjson/hex-6 (color-lighten-name hex percent))))
          (delete-region (car bounds) (cdr bounds))
          (insert bright))
      (user-error "No hex color at point"))))


;; Local configuration

(let ((local-file (expand-file-name "config/svjson-theme-contexts.el" user-emacs-directory)))
  (when (file-exists-p local-file)
    (load local-file)))



;; Key Bindings

(global-set-key (kbd  "M-m w") #'svjson/show-context)
(global-set-key (kbd "M-m c") #'svjson/helm-theme-context)

(with-eval-after-load 'dashboard
  (define-key dashboard-mode-map (kbd "g") #'svjson/helm-theme-context))



(provide 'config-theme-context)

;;; config-theme-context.el ends here
