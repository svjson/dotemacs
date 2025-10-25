;;; config-warnings.el --- Package manager config -*- lexical-binding: t; -*-

;; Stop *Warnings* from popping up (but don't disable warnings)
(add-to-list 'display-buffer-alist
             '("\\*Warnings\\*"
               (display-buffer-no-window)))

(provide 'config-warnings)

;;; config-warnings.el ends here
