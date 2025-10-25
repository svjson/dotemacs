;;; config-theme.el --- Theme setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package doom-themes
  :config
  ;;(load-theme 'doom-one t)
  (load-theme 'hc-zenburn t)

  ;; Optional tweaks
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)

  (custom-set-faces
   '(region ((t (:background "#4b0340"))))
   '(mc/region-face ((t (:background "#4b0340"))))
   '(magit-diff-hunk-region ((t (:background "#4b0340"))))))


(provide 'config-theme)

;;; config-theme.el ends here
