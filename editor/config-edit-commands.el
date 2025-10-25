;;; config-edit-commands.el --- summary -*- lexical-binding: t -*-

(require 'thingatpt)



;; use move-text

(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))



;; Move/Kill whitespace forward / backward

(defun svjson/move-whitespace (fn)
  "Move until whitespace ends using FN."
  (interactive)
  (let ((start (point)))
    (funcall fn " \t")
    (list (min start (point)) (max start (point)))))

(defun svjson/move-whitespace-backward ()
  "Move backwards until whitespace ends."
  (interactive)
  (svjson/move-whitespace #'skip-chars-backward))

(defun svjson/kill-whitespace-backward ()
  "Kill all horizontal whitespace before point on the current line."
  (interactive)
  (apply #'kill-region (svjson/move-whitespace-backward)))

(defun svjson/move-whitespace-forward ()
  "Move forwards until whitespace ends."
  (interactive)
  (svjson/move-whitespace #'skip-chars-forward))

(defun svjson/kill-whitespace-forward ()
  "Kill all horizontal whitespace after point on the current line."
  (interactive)
  (apply #'kill-region (svjson/move-whitespace-forward)))



;;; Number manipulation

(defun svjson/mod-number-at-point (mod)
  "Modify the numeric thing at point by addition of MOD.

Use a negative value of MOD for subtraction."
  (interactive)
  (save-excursion
    (when (thing-at-point-looking-at "[0-9]+")
      (replace-match
       (number-to-string (+ mod (string-to-number (match-string 0))))
       t t))))

(defun svjson/inc-number-at-point ()
  "Increase the number at point by one."
  (interactive)
  (svjson/mod-number-at-point 1))

(defun svjson/dec-number-at-point ()
  "Increase the number at point by one."
  (interactive)
  (svjson/mod-number-at-point -1))



;;; Case conversion
(defun svjson/convert-region-case (start end case-type)
  "Convert region content, START to END, to specified CASE-TYPE.

CASE-TYPE can be one of `kebab, `snake, or `camel."
  (interactive "r
sCase type (kebab, snake, camel): ")
  (let* ((content (string-trim (buffer-substring-no-properties start end)))
         (words (split-string content "[^a-zA-Z0-9]+" t))
         (inter (downcase (replace-regexp-in-string "[^a-zA-Z0-9]+" "\t" content)))
         (result ;; (pcase case-type
          ;;   ("kebab" (string-join words "-"))
          ;;   ("snake" (string-join words "_"))
          ;;   ("camel" (concat (car words) (mapconcat #'capitalize (cdr words) "")))
          ;;   (_ (error "Invalid case type: %s" case-type)))
          ))
    (delete-region start end)
    (insert inter)))



;;; Key Bindings

;; Marks
(global-set-key (kbd "C-c C-SPC") 'pop-global-mark)

;; Kill Whitespace
(global-set-key (kbd "s-<backspace>") #'svjson/kill-whitespace-backward)
(global-set-key (kbd "s-<delete>") #'svjson/kill-whitespace-forward)

;; Move whitespace
(global-set-key (kbd "M-S-<left>") #'svjson/move-whitespace-backward)
(global-set-key (kbd "M-S-<right>") #'svjson/move-whitespace-forward)

;; Line manipulation
(global-set-key (kbd "M-j") (lambda () (interactive)  (join-line -1)))
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; Number manipulation
(global-set-key (kbd "C-c +") #'svjson/inc-number-at-point)
(global-set-key (kbd "C-c -") #'svjson/dec-number-at-point)

;; Comments
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)



(provide 'config-edit-commands)

;;; config-edit-commands.el ends here
