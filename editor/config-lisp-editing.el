;;; config-lisp-editing.el --- Package manager config -*- lexical-binding: t; -*-


;; Paredit
(use-package paredit
  :ensure t
  :hook (emacs-lisp-mode . enable-paredit-mode)
  :config
  ;; Unbind or remap problematic defaults
  (define-key paredit-mode-map (kbd "C-d") nil) ;; don't override delete-char
  (define-key paredit-mode-map (kbd "C-<left>") nil)
  (define-key paredit-mode-map (kbd "C-<right>") nil)
  (define-key paredit-mode-map (kbd "s-<left>") 'paredit-forward-barf-sexp)
  (define-key paredit-mode-map (kbd "s-<right>") 'paredit-forward-slurp-sexp)
  (define-key paredit-mode-map (kbd "s-S-<left>") 'paredit-backward-slurp-sexp)
  (define-key paredit-mode-map (kbd "s-S-<right>") 'paredit-backward-barf-sexp)

  (define-key paredit-mode-map (kbd "M-s") nil) ;; maybe used for isearch
  (define-key paredit-mode-map (kbd "C-M-u") nil)
  (define-key paredit-mode-map (kbd "M-m j s") 'paredit-split-sexp)
  (define-key paredit-mode-map (kbd "C-M-<right>") 'forward-sexp)
  (define-key paredit-mode-map (kbd "C-M-<left>") 'backward-sexp))

(global-set-key (kbd "C-M-<right>") 'forward-sexp)
(global-set-key (kbd "C-M-<left>") 'backward-sexp)



;; Smartparens

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :bind
  ("M-m j u" . sp-unwrap-sexp)
  ("M-m j r" . sp-rewrap-sexp)
  :config
  (dolist (mode '(emacs-lisp-mode lisp-mode lisp-interaction-mode))
    (sp-local-pair mode "'" nil :actions nil)))

(defun apply-slurp-bindings ()
  "Select paredit or smartparens slurp bindings depending on mode."
  (when (not (derived-mode-p 'lisp-mode 'emacs-lisp-mode 'scheme-mode 'clojure-mode))
    (global-set-key (kbd "s-<left>") 'sp-forward-barf-sexp)
    (global-set-key (kbd "s-<right>") 'sp-forward-slurp-sexp)
    (global-set-key (kbd "s-S-<left>") 'sp-backward-slurp-sexp)
    (global-set-key (kbd "s-S-<right>") 'sp-backward-barf-sexp)))

;; Add the setup function to hooks
(add-hook 'prog-mode-hook #'apply-slurp-bindings)
(add-hook 'text-mode-hook #'apply-slurp-bindings)

(which-key-add-key-based-replacements "M-m j" "sexp ops")




(provide 'config-lisp-editing)

;;; config-lisp-editing.el ends here
