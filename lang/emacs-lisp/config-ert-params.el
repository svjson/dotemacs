;;; config-ert-params.el --- summary -*- lexical-binding: t -*-



;; Forward declarations

(declare-function straight-use-package "straight-el")



;; Switch between loading ert-params from development dir or test installing with straight

(defconst svjson/ert-params-source 'devel)



;; Load path

(pcase svjson/ert-params-source
  ('devel
   (apply #'add-to-list 'load-path
          '("/home/svjson/devel/opensource/projects/ert-params/")))

  ('straight
   (straight-use-package
    '(scoot :type git
            :repo "/home/svjson/devel/opensource/projects/ert-params"
            :files ("scoot.el/*.el")))))



(require 'ert-params)



(provide 'config-ert-params)

;;; config-ert-params.el ends here
