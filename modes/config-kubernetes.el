;;; config-kubernetes.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 1))

(provide 'config-kubernetes)

;;; config-kubernetes.el ends here
