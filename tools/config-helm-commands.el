;;; config-helm-commands.el --- summary -*- lexical-binding: t -*-


(declare-function helm-execute-persistent-action "helm-core")
(declare-function helm-find-files-1 "helm-files")
(declare-function helm-get-candidates "helm-core")
(declare-function helm-get-current-source "helm-core")
(declare-function helm-build-sync-source "helm-sources")
(defvar helm-pattern)



;;;###autoload
(defun svjson/helm-ff-complete ()
  "Safely complete filename without triggering preview errors."
  (interactive)
  (let ((display-buffer-alist nil))     ; prevent preview split errors
    (helm-execute-persistent-action)))


;; Here lies the Great Helm TAB War of 2025
;; Finally won by me, myself and I  after countless refreshes and nil sources.
;;;###autoload
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


;;;###autoload
(defun svjson/helm-find-home ()
  "Open Helm find-files in ~/."
  (interactive)
  (helm-find-files-1 "~/"))


;;;###autoload
(defun svjson/helm-find-files-here ()
  "Launch `helm-find-files` in the directory of the current buffer."
  (interactive)
  (let ((default-directory (or (and buffer-file-name
                                    (file-name-directory buffer-file-name))
                               default-directory)))
    (helm-find-files nil)))


;;;###autoload
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




;;;###autoload
(defun svjson/helm-kill-runaway-buffers ()
  (interactive)
  (mapc (lambda (b)
          (when (string-match-p "\\`[*]helm" (buffer-name b))
            (kill-buffer b)))
        (buffer-list)))




;;; config-helm-commands.el ends here
