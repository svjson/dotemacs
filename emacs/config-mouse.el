;;; config-mouse.el --- mouse config -*- lexical-binding: t; -*-


;; Mouse banishment - so that it doesn't give focus to eldoc popups


(defun svjson/mouse-command-p (command)
  "Return non-nil if COMMAND is bound to any mouse-related input."
  (let ((mouse-event-p
         (lambda (event)
           (and (vectorp event)
                (seq-some
                 (lambda (el)
                   (or (mouse-event-p el)
                       (memq el '(wheel-up wheel-down wheel-left wheel-right))))
                 event)))))
    (seq-some
     (lambda (key-seq)
       (funcall mouse-event-p key-seq))
     (where-is-internal command))))

(defun svjson/banish-mouse-unless-using-it ()
  "Move the mouse pointer to (0,0) unless the command is mouse-related."
  (when (or (and (display-graphic-p)
                 (not (svjson/mouse-command-p this-command)))
            (memq (symbol-name this-command) '(ignore-preserving-kill-region)))
    (set-mouse-position (selected-frame) 0 0)))


(defun svjson/kill-dead-file-buffers ()
  "Kill all file-visiting buffers whose files no longer exist on disk."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (let ((file (buffer-file-name)))
        (when (and file
                   (not (file-remote-p file))
                   (not (file-exists-p file))
                   (not (buffer-modified-p)))
          (kill-buffer buf))))))

(add-hook 'pre-command-hook #'svjson/banish-mouse-unless-using-it)




(provide 'config-mouse)


;;; config-mouse.el ends here
