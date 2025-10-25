;;; config-buffer-management.el --- summary -*- lexical-binding: t -*-



;; Close all file buffers for a root dir

(defun svjson/kill-file-buffers-in-dir (dir)
  "Kill all visiting file buffers whose file is inside DIR (recursively)."
  (interactive "DKill buffers under directory: ")
  (let ((dir (file-truename dir)))
    (dolist (buf (buffer-list))
      (let ((fname (buffer-file-name buf)))
        (when (and fname
                   (file-in-directory-p (file-truename fname) dir))
          (kill-buffer buf))))))



;; Open previous/next file in dir

(defun svjson--find-next-file-in-directory (backward)
  "Core logic to open the next or previous file in the same directory.
If BACKWARD is non-nil, goes to the previous file."
  (let* ((file (buffer-file-name)))
    (unless file
      (user-error "Current buffer is not visiting a file"))
    (let* ((dir (file-name-directory file))
           (files (seq-filter
                   (lambda (f)
                     (and (not (file-directory-p (expand-file-name f dir)))
                          (not (string-prefix-p "." f))))
                   (directory-files dir)))
           (files-sorted (sort files #'string<))
           (current (file-name-nondirectory file))
           (pos (cl-position current files-sorted :test #'string=)))
      (unless pos (user-error "Current file not found in directory listing"))
      (let ((next-pos (mod (+ pos (if backward -1 1)) (length files-sorted))))
        (find-file (expand-file-name (nth next-pos files-sorted) dir))))))

(defun svjson/next-file-in-directory ()
  "Open the next file (alphanum) in the same directory as the current buffer."
  (interactive)
  (svjson--find-next-file-in-directory nil))

(defun svjson/previous-file-in-directory ()
  "Open the previous file (alphanum) in the same directory as the current buffer."
  (interactive)
  (svjson--find-next-file-in-directory t))



;;; Key Bindings

;; Kill file buffers in root dir
(global-set-key (kbd "M-m k d") 'svjson/kill-file-buffers-in-dir)

;; Next/Previous file in dir
(global-set-key (kbd "C-x <down>") #'svjson/next-file-in-directory)
(global-set-key (kbd "C-x <up>") #'svjson/previous-file-in-directory)



(provide 'config-buffer-management)

;;; config-buffer-management.el ends here
