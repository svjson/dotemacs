;;; config-multiple-cursors.el --- Multiple cursors configuration -*- lexical-binding: t; -*-


;; use-package

(use-package multiple-cursors
  :ensure t)

(require 'multiple-cursors)



;; Make kill ring behave with mc

(defun svjson/mc-kill-ring-save ()
  "Save regions from all cursors into the kill ring, joined by newlines."
  (interactive)
  (unless multiple-cursors-mode
    (user-error "Not in multiple-cursors-mode"))
  (let ((regions '()))
    ;; Collect from fake cursors
    (dolist (region (mc/region-strings))
      (push region regions))
    ;; Include real cursor's region
    (when (use-region-p)
      (push (buffer-substring-no-properties (region-beginning) (region-end)) regions))
    (if regions
        (let* ((joined (string-join (reverse regions) "\n")))
          (kill-new joined)
          (message "Copied %d regions to kill-ring" (length regions)))
      (message "No active regions to copy."))))

(defun svjson/kill-ring-save-advice (orig-fn &rest args)
  "Dispatch to `svjson/mc-kill-ring-save` when multiple cursors are active."
  (if (and (bound-and-true-p multiple-cursors-mode)
           ;; ensure at least one fake cursor has a region
           (or (use-region-p)
               (seq-some (lambda (c)
                           (> (abs (- (overlay-start c) (overlay-end c))) 0))
                         (mc/all-fake-cursors))))
      (svjson/mc-kill-ring-save)
    (apply orig-fn args)))

(advice-add 'kill-ring-save :around #'svjson/kill-ring-save-advice)


;; Key Bindings

(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this-dwim)
(global-set-key (kbd "C-c m c") 'mc/mark-all-dwim)
(global-set-key (kbd "C-ä") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-ä") 'mc/unmark-next-like-this)


(provide 'config-multiple-cursors)

;;; config-multiple-cursors ends here
