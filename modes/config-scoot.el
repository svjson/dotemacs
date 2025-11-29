;;; config-scoot.el --- summary -*- lexical-binding: t -*-

(declare-function straight-use-package "straight-el")

;; Switch between loading scoot from development dir or test installing with straight
(defconst svjson/scoot-source 'devel)

(pcase svjson/scoot-source
  ('devel
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/scoot/scoot.el/")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/scoot/scoot.el/test/")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/scoot/system_test/emacs/tests"))

  ('straight
   (straight-use-package
    '(scoot :type git
            :repo "/home/svjson/devel/opensource/projects/scoot"
            :files ("scoot.el/*.el")))))

(require 'scoot)


(provide 'config-scoot)

;;; config-scoot.el ends here
