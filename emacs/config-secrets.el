;;; config-secrets.el --- Package manager config -*- lexical-binding: t; -*-

(defvar svjson-tokens nil)
(defvar svjson-api-keys nil)


(defun svjson/token (token)
  (plist-get (plist-get svjson-tokens token) :token))

(defun svjson/token-user (token)
  (plist-get (plist-get svjson-tokens token) :user)))



(provide 'config-secrets)

;;; config-secrets.el ends here
