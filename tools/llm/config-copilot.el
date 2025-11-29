;;; config-copilot.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:

(require 'config-markdown)



;; Forward declarations

(declare-function copilot-accept-completion "copilot")
(declare-function copilot-previous-completion "copilot")
(declare-function copilot-next-completion "copilot")



(defvar svjson/copilot/init-complete nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq svjson/copilot/init-complete t)))

(defun svjson/maybe-enable-copilot (&rest _)
  (when (and svjson/copilot/init-complete
             (derived-mode-p 'prog-mode)
             (get-buffer-window (current-buffer) 'visible)
             (not (bound-and-true-p copilot-mode)))

    (message "Loading copilot for buffer %s" (current-buffer))

    (require 'copilot nil t)

    (when (featurep 'copilot)
      (copilot-mode 1))))

(add-to-list 'window-selection-change-functions #'svjson/maybe-enable-copilot)
(add-hook 'find-file-hook #'svjson/maybe-enable-copilot)
(add-hook 'buffer-list-update-hook #'svjson/maybe-enable-copilot)

(use-package copilot
  :bind (:map copilot-completion-map
              ("<tab>" . #'copilot-accept-completion)
              ("<return>" . #'copilot-accept-completion)
              ("M-P" . #'copilot-previous-completion)
              ("M-N" . #'copilot-next-completion))
  :config
  (with-eval-after-load 'copilot
    (setq copilot-enable-predicates nil) ;; don't auto-trigger at all
    (setq copilot-disable-predicates '(always)) ;; always prevent idle triggers

    (define-key prog-mode-map (kbd "M-S-<iso-lefttab>") #'svjson/copilot-complete-or-toggle)
    (define-key markdown-mode-map (kbd "M-S-<iso-lefttab>") #'svjson/copilot-complete-or-toggle)))

(defun svjson/copilot-complete-or-toggle ()
  "Trigger Copilot completion manually."
  (interactive)
  (unless copilot-mode
    (copilot-mode 1))
  (copilot-complete))



;; Key Bindings




(provide 'config-copilot)

;;; config-copilot.el ends here
