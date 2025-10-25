;;; config-magit.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:

(require 'config-projectile)

(defun svjson/magit-other-window ()
  "Open Magit status in other window.
Use the Git root of the current buffer if possible, otherwise fallback
to `svjson/last-projectile-project-root`."
  (interactive)
  (let* ((git-root (or (vc-call-backend 'Git 'root default-directory)
                       (when (fboundp 'magit-toplevel)
                         (ignore-errors (magit-toplevel)))))
         (root (or git-root svjson/last-projectile-project-root)))
    (if root
        (let ((buf (magit-status-setup-buffer root)))
          (pop-to-buffer buf))
      (message "No Git repository found and no fallback project root defined."))))

(use-package magit
  :ensure t
  :bind
  ("C-c m b" . magit-blame)
  ("C-c m m" . svjson/magit-other-window)
  ("C-c m M" . magit-status))

(use-package forge
  :ensure t
  :after magit)

(provide 'config-magit)

;;; config-magit.el ends here
