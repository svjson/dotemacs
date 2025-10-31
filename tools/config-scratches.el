;; config-scratches.el --- flycheck configuration  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Imports scratches.el and hooks up the scratches-command-map

;;; Code:

(use-package scratches
  :ensure t
  :commands
  (scratches-mode
   scratches-global-mode
   scratches-new-scratch-dwim
   scratches-visit-scratch
   scratches-kill-all-scratches)
  :bind-keymap
  ("C-c C-r" . scratches-command-map)
  :init
  ;; Set defaults that don't require loading the package
  (setq scratches-save-location (expand-file-name "scratches" user-emacs-directory))
  (setq scratches-untitled-name "Scratch"))



(provide 'config-scratches)

;; config-scratches.el ends here
