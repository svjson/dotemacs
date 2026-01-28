;;; config-org.el --- summary -*- lexical-binding: t -*-

(require 'org)
(require 'org-agenda)


;; org general

(setq org-todo-keywords
      '((sequence "TODO" "ONGOING" "PAUSED" "|" "DONE")))

(setq org-todo-keyword-faces
      '(("ONGOING" . "orange")
        ("PAUSED" . "yellow")))

(setq org-tags-column -80)


;; Key Bindings (org general)


(with-eval-after-load 'org
  (let ((map org-read-date-minibuffer-local-map))
    (define-key map (kbd "s-<down>")  #'org-calendar-forward-week)
    (define-key map (kbd "s-<up>")    #'org-calendar-backward-week)
    (define-key map (kbd "s-<left>")  #'org-calendar-backward-day)
    (define-key map (kbd "s-<right>") #'org-calendar-forward-day)))

(define-key org-mode-map (kbd "s-<right>") #'org-shiftright)
(define-key org-mode-map (kbd "s-<left>") #'org-shiftleft)



;; org-agenda

(setq org-agenda-skip-scheduled-if-deadline-is-shown nil)
(setq org-agenda-skip-deadline-if-done nil)
(setq org-agenda-skip-scheduled-if-done nil)
(setq org-scheduled-past-days 99999)

(defun svjson/org-todo->TODO ()
  (interactive)
  (org-agenda-todo "TODO"))

(defun svjson/org-todo->ONGOING ()
  (interactive)
  (org-agenda-todo "ONGOING"))

(defun svjson/org-todo->PAUSED ()
  (interactive)
  (org-agenda-todo "PAUSED"))

(defun svjson/org-todo->DONE ()
  (interactive)
  (org-agenda-todo "DONE"))


;; Key Bindings (org-agenda)


(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "C-c <backspace>") #'svjson/org-todo->TODO)
  (define-key org-agenda-mode-map (kbd "C-c o") #'svjson/org-todo->ONGOING)
  (define-key org-agenda-mode-map (kbd "C-c p") #'svjson/org-todo->PAUSED)
  (define-key org-agenda-mode-map (kbd "C-c SPC") #'svjson/org-todo->DONE))




(provide 'config-org)

;;; config-org.el ends here
