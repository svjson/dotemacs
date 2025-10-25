;;; config-completion.el --- Auto-completion with company -*- lexical-binding: t; -*-


;; Company

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1))

(use-package company-box
  :hook (company-mode . company-box-mode))


;; Corfu

(use-package corfu
  :ensure t
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1)
  :hook ((eval-expression-minibuffer-setup . corfu-mode))
  :config
  (setq corfu-excluded-modes '(helm-mode)))



(provide 'config-completion)

;;; config-completion.el ends here
