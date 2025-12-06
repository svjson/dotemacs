;;; config-chunkgrab.el -*- lexical-binding: t; flycheck-disabled-checkers: (emacs-lisp-checkdoc); -*-

;;; Commentary:

;; Use grabchunk.el from source

(add-to-list 'load-path "/home/svjson/devel/opensource/projects/chunkgrab.el/")

(require 'chunkgrab)

(global-chunkgrab-mode 1)


(provide 'config-chunkgrab)

;;; config-chunkgrab.el ends here
