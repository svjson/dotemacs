;;; config-ert-parametrized.el --- summary -*- lexical-binding: t -*-



;; Forward declarations

(declare-function straight-use-package "straight-el")



;; Switch between loading ert-params from development dir or test installing with straight

(defconst svjson/ert-parametrized-source 'devel)



;; Load path

(pcase svjson/ert-parametrized-source
  ('devel
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/ert-parametrized.el/")
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/ert-parametrized.el/test/"))

  ('straight
   (straight-use-package
    '(scoot :type git
            :repo "/home/svjson/devel/opensource/projects/ert-parametrized.el"
            :files ("ert-parametrized.el")))))



(require 'ert-parametrized)



(provide 'config-ert-parametrized)

;;; config-ert-parametrized.el ends here
