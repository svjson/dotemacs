;;; config-dired.el --- Early initialization -*- lexical-binding: t; -*-



(defun dired-jump-to-first-file-by-letter ()
  "Jump to the first file in Dired whose name starts with a given letter."
  (interactive)
  (let ((char (read-char "Jump to file starting with: "))
        (case-fold-search t))
    (goto-char (point-min))
    (unless (re-search-forward "\\.\\." nil t)
      (re-search-forward "\\." nil t))

    (re-search-backward " " nil t)

    (let ((found nil)
          (col (1+ (current-column))))
      (while (and (null found)
                  (re-search-forward (format  " %c" char) nil t))
        (setq found (not (< (current-column) col)))))
    (dired-move-to-filename)))


;; Key Bindings

(eval-after-load 'dired-mode
  '(define-key dired-mode-map (kbd ",") #'dired-jump-to-first-file-by-letter))



(provide 'config-dired)

;;; config-dired.el ends here
