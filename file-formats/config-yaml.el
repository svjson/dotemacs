;;; config-yaml.el --- yaml mode editing -*- lexical-binding: t; -*-

(use-package yaml-ts-mode
  :straight (:type built-in)
  :mode (("\\.ya?ml\\'" . yaml-ts-mode))
  :hook (yaml-ts-mode . (lambda () (setq show-trailing-whitespace t)))
  :config
  (define-key yaml-ts-mode-map (kbd "M-m d") #'base64-decode-region)
  (define-key yaml-ts-mode-map (kbd "M-m e") #'base64-encode-region))

(provide 'config-yaml)

;;; config-yaml.el ends here
