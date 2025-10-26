;;; config-org.el --- summary -*- lexical-binding: t -*-

(require 'org)



(setq org-todo-keywords
      '((sequence "TODO" "ONGOING" "PAUSED" "|" "DONE")))

(setq org-todo-keyword-faces
      '(("ONGOING" . "orange")
        ("PAUSED" . "yellow")))

;; Key Bindings


(with-eval-after-load 'org
  (let ((map org-read-date-minibuffer-local-map))
    (define-key map (kbd "s-<down>")  #'org-calendar-forward-week)
    (define-key map (kbd "s-<up>")    #'org-calendar-backward-week)
    (define-key map (kbd "s-<left>")  #'org-calendar-backward-day)
    (define-key map (kbd "s-<right>") #'org-calendar-forward-day)))

(define-key org-mode-map (kbd "s-<right>") #'org-shiftright)
(define-key org-mode-map (kbd "s-<left>") #'org-shiftleft)

(provide 'config-org)

;;; config-org.el ends here
