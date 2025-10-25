;;; config-yaml.el --- yaml mode editing -*- lexical-binding: t; -*-

(require 'yaml-ts-mode)

(add-to-list 'auto-mode-alist '("\\*.yaml" . yaml-ts-mode))

(add-hook 'yaml-ts-mode-hook
          (lambda ()
            (setq show-trailing-whitespace t)))

(define-key yaml-ts-mode-map (kbd "M-m d") #'base64-decode-region)
(define-key yaml-ts-mode-map (kbd "M-m e") #'base64-encode-region)

(provide 'config-yaml)

;;; config-yaml.el ends here
