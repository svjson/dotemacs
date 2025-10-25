;;; config-messages.el --- Package manager config -*- lexical-binding: t; -*-

(defvar svjson/messages-buffer-follow nil)


;; Buffer convenience functions

(defun svjson/clear-messages-buffer ()
  "Clear the *Messages* buffer."
  (interactive)
  (with-current-buffer "*Messages*"
    (let ((inhibit-read-only t))
      (erase-buffer))))

(defun svjson/follow-messages-buffer ()
  "Ensure *Messages* buffer is always scrolled to bottom."
  (when (and svjson/messages-buffer-follow
             (get-buffer "*Messages*"))
    (with-current-buffer "*Messages*"
      (goto-char (point-max))
      (let ((window (get-buffer-window "*Messages*")))
        (when window
          (set-window-point window (point-max)))))))

(defun svjson/toggle-messages-buffer-follow ()
  "Toggle follow on Messages buffer."
  (interactive)
  (setq svjson/messages-buffer-follow (not svjson/messages-buffer-follow))
  (message "*Messages* tail/follow: %s" (if svjson/messages-buffer-follow "On" "Off")))


;; Hooks

(add-hook 'post-command-hook 'svjson/follow-messages-buffer)


;; Key Bindings

(global-set-key (kbd "C-c c m c") #'svjson/clear-messages-buffer)
(global-set-key (kbd "C-c c m f") #'svjson/toggle-messages-buffer-follow)
(global-set-key (kbd "C-c c m m") (lambda () (interactive) (display-buffer "*Messages*")))



(provide 'config-messages)

;;; config-messages.el ends here
