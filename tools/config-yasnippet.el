;;; config-yasnippet.el --- Configuration for yasnippet in Emacs -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; This file configures yasnippet to enhance the coding experience
;; by providing snippet expansion capabilities.

;;; Code:

(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode)
  :config
  (define-key yas-minor-mode-map (kbd "C-<return>") 'yas-expand))


(use-package yasnippet-snippets)

(provide 'config-yasnippet)
;;; config-yasnippet.el ends here
