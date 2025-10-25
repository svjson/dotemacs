;;; sh-config.el --- Minimal Emacs config entry point -*- lexical-binding: t; -*-

(require 'sh-script)


(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2)))



(provide 'sh-config)

;;; sh-config.el ends here
