;;; config-global.el --- aidermacs config -*- lexical-binding: t; -*-

(setq shell-file-name "/bin/bash")

(defun svjson/reload-feature (feature)
  "Unload FEATURE and re-require it."
  (interactive
   (list  (intern (read-string "Feature: "))))
  (when (featurep feature)
    (unload-feature feature t))
  (require feature))



(provide 'config-global)


;;; config-global.el ends here
