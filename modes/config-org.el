;;; config-org.el --- summary -*- lexical-binding: t -*-

(require 'org)

(setq org-todo-keywords
      '((sequence "TODO" "ONGOING" "PAUSED" "|" "DONE")))

(setq org-todo-keyword-faces
      '(("ONGOING" . "orange")
        ("PAUSED" . "yellow")))

(define-key org-mode-map (kbd "s-<right>") #'org-shiftright)
(define-key org-mode-map (kbd "s-<left>") #'org-shiftleft)

(provide 'config-org)

;;; config-org.el ends here
