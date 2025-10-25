;;; -*- lexical-binding: t; flycheck-disabled-checkers: (emacs-lisp-checkdoc); -*-

(use-package dashboard
  :config
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-items '((recents  . 10)
			  (projects . 10)
			  (bookmarks . 5)))
  (setq dashboard-startup-banner "~/.emacs.d/assets/logo.png")
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-center-content t)

  (setf (alist-get 'recents dashboard-item-generators) #'svjson/dashboard-insert-recents)
  (setf (alist-get 'projects dashboard-item-generators) #'svjson/dashboard-insert-projects)

  (dotimes (i 10)
    (let ((key (number-to-string i)))
      (define-key dashboard-mode-map (kbd key)
		  `(lambda () (interactive) (svjson/dashboard-open-indexed-item ,i)))))

  (dashboard-setup-startup-hook))

(require 'dashboard)
(require 'dashboard-widgets)

(defun svjson/dashboard-number-lines-in-section (section-title)
  "Prefix each entry line under SECTION-TITLE with a number."
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward (concat "^" (regexp-quote section-title)) nil t)
      (forward-line 1)
      (let ((i 1))
        (while (and (not (eobp))
                    (not (looking-at-p "^[^ \t\n]"))) ; stop on next section
          (when (looking-at-p "^\\s-+\\S-") ; actual item line
            (let ((inhibit-read-only t))
              (beginning-of-line)
              (insert (format "%d. " (- i 1)))
              (setq i (1+ i))))
          (forward-line 1))))))

(defun svjson/dashboard-insert-recents (list-size)
  (dashboard-insert-recents list-size)
  (svjson/dashboard-number-lines-in-section "Recent Files: "))

(defun svjson/dashboard-insert-projects (list-size)
  (dashboard-insert-projects list-size)
  (svjson/dashboard-number-lines-in-section "Projects: "))

(defun svjson/dashboard-open-indexed-item (number)
  (let ((section (dashboard--current-section)))
    (when section
      (dashboard--goto-section section)
      (dotimes (_ number)
	      (forward-line))
      (dashboard-return))))

;; Dashboard setup

(defun svjson/switch-to-dashboard ()
  "Always refresh and switch to the dashboard buffer."
  (interactive)
  (dashboard-refresh-buffer)
  (switch-to-buffer "*dashboard*"))

(global-set-key (kbd "C-c d") #'svjson/switch-to-dashboard)

(provide 'config-dashboard)
