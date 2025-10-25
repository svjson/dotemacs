;;; config-typescript.el --- Emacs TypeScript + TSX IDE Setup Outline -*- lexical-binding: t; -*-

(require 'ecmascript-config)
(require 'config-tree-climber)
(require 'flycheck)



;; Nasty init-hook

(defun svjson/typescript-ts-mode-hook ()
  "Hook for `typescript-ts-mode` and `tsx-ts-mode`."
;;;(setq-local flycheck-eslint-args (list "--stdin-filename" buffer-file-name))

  ;; (add-hook 'before-save-hook #'svjson/lsp-organize-imports-if-connected
  ;;           nil t)

  (let* ((eslint-executable (expand-file-name "node_modules/.bin/eslint" (locate-dominating-file default-directory "node_modules")))
         (eslint-exec-exists (file-exists-p eslint-executable)))

    (when eslint-exec-exists
      (setq-local flycheck-javascript-eslint-executable eslint-executable)
      (flycheck-select-checker 'javascript-eslint))

    (lsp-deferred)

    (add-node-modules-path)
    (prettier-mode 1)
    (page-break-lines-mode 1)
    (tree-climber-mode 1)

    (unless eslint-exec-exists
      (message "Unable to locate eslint executable...")))


  (when (project-current)
    (setq flycheck-checker 'javascript-eslint)))



;; use-package

(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :hook ((typescript-ts-mode . svjson/typescript-ts-mode-hook)
         (tsx-ts-mode . svjson/typescript-ts-mode-hook))
  :config
  (setq-default typescript-indent-level 2)
  (setq-default typescript-ts-mode-indent-offset 2))

(require 'typescript-ts-mode)


;; flycheck

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'typescript-ts-mode))



;; Key Bindings
(define-key typescript-ts-mode-map (kbd "M-g t") #'svjson/toggle-src-test)
(define-key typescript-ts-mode-map (kbd "M-g T") #'svjson/toggle-src-test-other-window)



(provide 'config-typescript)

;;; config-typescript.el ends here
