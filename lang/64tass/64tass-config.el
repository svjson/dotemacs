;;; 64tass-config.el --- summary -*- lexical-binding: t -*-

(require 'config-straight)



;; Switch between loading 64tass-mode from development dir or test installing with straight
(defconst svjson/64tass-source 'devel)

(pcase svjson/64tass-source
  ('devel
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/64tass-mode.el")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/64tass-mode.el/test")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/64tass-mode.el/packages/64tass-proc.el")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/64tass-mode.el/packages/64tass-proc.el/test")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/64tass-mode.el/packages/flycheck-64tass.el")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/64tass-mode.el/packages/flycheck-64tass.el/test")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/64tass-mode.el/packages/vice-emu-proc.el"))

  ('straight
   (straight-use-package
    '(scoot :type git
            :repo "/home/svjson/devel/opensource/projects/64tass.el"
            :files ("*.el" "packages/64tass-proc.el/*.el")))))

(require '64tass-mode)

(add-to-list 'auto-mode-alist '("\\.asm\\'" . 64tass-mode))




(provide '64tass-config)

;;; 64tass-config.el ends here
