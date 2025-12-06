;;; config-package.el --- Configuration for package.el -*- lexical-binding: t; -*-


;; Ensure package sources
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;; Load use-package

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t
      use-package-always-defer t)



(provide 'config-package)

;;; config-package.el ends here
