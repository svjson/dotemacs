;; config-flycheck.el --- flycheck configuration  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Imports flycheck and sets up faces and helper functions for displaying flycheck
;; status in the modeline

;;; Code:

(require 'flycheck)

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit))

(defface svjson/flycheck-ok-face
  '((t (:foreground "green")))
  "Face for flycheck icon when no issues.")

(defface svjson/flycheck-warning-face
  '((t (:foreground "goldenrod")))
  "Face for flycheck icon when only warnings.")

(defface svjson/flycheck-error-face
  '((t (:foreground "red")))
  "Face for flycheck icon when errors exist.")

(defun svjson/flycheck-icon ()
  (let* ((errors flycheck-current-errors)
         (levels (mapcar #'flycheck-error-level errors)))
    (cond
     ((memq 'error levels)
      (propertize "" 'face 'svjson/flycheck-error-face)) ;; red x
     ((memq 'warning levels)
      (propertize "" 'face 'svjson/flycheck-warning-face)) ;; yellow exclamation
     (t
      (propertize "" 'face 'svjson/flycheck-ok-face))))) ;; green check

(defun svjson/flycheck-tooltip ()
  (if (not (bound-and-true-p flycheck-mode))
      "Flycheck disabled"
    (let* ((counts (flycheck-count-errors flycheck-current-errors))
           (errors (or (cdr (assq 'error counts)) 0))
           (warnings (or (cdr (assq 'warning counts)) 0)))
      (format "Flycheck: %d error%s, %d warning%s"
              errors (if (= errors 1) "" "s")
              warnings (if (= warnings 1) "" "s")))))



(provide 'config-flycheck)

;;; config-flycheck.el ends here
