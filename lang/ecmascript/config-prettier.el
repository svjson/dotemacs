;;; config-prettier.el -*- lexical-binding: t; -*-


(use-package prettier
  :hook ((tsx-ts-mode . prettier-mode)
         (web-mode . prettier-mode))
  :bind
  ("C-c f r" . prettier-prettify-region))




(provide 'config-prettier)

;;; config-prettier.el ends here
