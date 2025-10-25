;;; config-heed.el -*- lexical-binding: t; flycheck-disabled-checkers: (emacs-lisp-checkdoc); -*-

;;; Commentary:

;; Use heed either from source repo or install with straight

(declare-function straight-use-package "straight-el")

(defconst svjson/heed-source 'devel)

(pcase svjson/heed-source
  ('devel
   (add-to-list 'load-path "/home/svjson/devel/opensource/projects/heed-mode"))

  ('straight
   (straight-use-package
    '(scoot :type git
            :repo "/home/svjson/devel/opensource/projects/heed-mode"))))


(require 'heed-mode)

(provide 'config-heed)

;; config-heed.el ends here
