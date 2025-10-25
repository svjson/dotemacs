;;; config-aidermacs.el --- aidermacs config -*- lexical-binding: t; -*-


;; use-package

;; (use-package aidermacs
;;   :ensure nil
;;   :commands (aidermacs-mode)
;;   :bind (("C-c a" . aidermacs-transient-menu))
;;   :hook ((prog-mode . aidermacs-mode))
;;   :config
;;   (setq aidermacs-default-model "gpt-4o")
;;   (setq aidermacs-aider-command "aider"))
;; (package-delete (cadr (assoc 'aidermacs package-alist))) ;; if it thinks it's installed
;;(package-refresh-contents)

;; Installing aidermacs from melpa is currently bonkers at the time of writing.
;; Gotta do thangs manually, I suppose

(require 'aidermacs)
(require 'config-secrets)


;; Base config

(setq aidermacs-default-model "gpt-4o")
(setq aidermacs-aider-command "aider")

(setenv "OPENAI_API_KEY" (plist-get svjson-api-keys :OPENAI_API_KEY_PRIVATE))


;; Key Bindings

(global-set-key (kbd "C-c a") #'aidermacs-transient-menu)




(provide 'config-aidermacs)


;;; config-aidermacs.el ends here
