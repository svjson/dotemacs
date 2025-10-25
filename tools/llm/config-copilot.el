;;; config-copilot.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:

(require 'config-markdown)



(unless (package-installed-p 'copilot)
  (package-vc-install "https://github.com/copilot-emacs/copilot.el"))

(require 'copilot)

(use-package copilot
  :hook (prog-mode . copilot-mode)
  :config
  (with-eval-after-load 'copilot
    (setq copilot-enable-predicates nil) ;; don't auto-trigger at all
    (setq copilot-disable-predicates '(always)) ;; always prevent idle triggers
    ;;(global-set-key (kbd "M-<iso-lefttab>") #'copilot-complete)
    ))

(defun svjson/copilot-complete-or-toggle ()
  "Trigger Copilot completion manually."
  (interactive)
  (unless copilot-mode
    (copilot-mode 1))
  (copilot-complete))



;; Key Bindings

(define-key prog-mode-map (kbd "M-S-<iso-lefttab>") #'svjson/copilot-complete-or-toggle)
(define-key markdown-mode-map (kbd "M-S-<iso-lefttab>") #'svjson/copilot-complete-or-toggle)

(define-key copilot-completion-map (kbd "<tab>") #'copilot-accept-completion)
(define-key copilot-completion-map (kbd "<return>") #'copilot-accept-completion)
(define-key copilot-completion-map (kbd "M-P") #'copilot-previous-completion)
(define-key copilot-completion-map (kbd "M-N") #'copilot-next-completion)




(provide 'config-copilot)

;;; config-copilot.el ends here
