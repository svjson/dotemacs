;;; config-gptel.el --- gptel config -*- lexical-binding: t; -*-


;; use-package

(use-package gptel
  :ensure t
  :config
  (setq gptel-model 'gpt-4o)       ;; Set the model you want to use
  (setq gptel-max-tokens 1500)	   ;; Set max tokens for the response
  (setq gptel-system-messages nil) ;; Configure system messages if needed

  ;; Enable company-mode for completion
  (use-package company
    :ensure t
    :config
    (add-hook 'gptel-mode-hook 'company-mode) ;; Enable company in gptel mode
    (setq company-minimum-prefix-length 1)
    (setq company-idle-delay 0.2)))

(require 'gptel)


;; Custom tweaks

(defun svjson/gptel-replace-region ()
  "Send region to gptel and replace it with the model's response."
  (interactive)
  (if (use-region-p)
      (let* ((region (buffer-substring-no-properties (region-beginning) (region-end)))
             (start (region-beginning))
             (end (region-end))
	           (prompt (read-string "Replace Region: ")))
	      (gptel-request
	          (concat prompt "\n\n" region)
	        :system "You are a coding assistant. Respond with only the modified code, without explanations, comments, or Markdown formatting. Never include code blocks. Do not say anything besides the raw code."
	        :callback (lambda (response _info)
		                  (when (stringp response)
			                  (delete-region start end)
			                  (goto-char start)
			                  (insert response)))))))

(defun svjson/gptel-rewrite-buffer ()
  "Ask GPT to rewrite the current buffer with a given instruction.
Ensures that only code is returned."
  (interactive)
  (let* ((prompt (read-string "Replace Buffer: "))
         (original (buffer-substring-no-properties (point-min) (point-max))))
    (gptel-request
	(concat prompt "\n\n" original)
      :system "You are a coding assistant. Respond with only the modified code, without explanations, comments, or Markdown formatting. Never include code blocks. Do not say anything besides the raw code."
      :callback (lambda (response)
                  (if (stringp response)
                      (progn
			(let ((inhibit-read-only t))
                          (erase-buffer)
                          (insert response)))
                    (message "Error: Request failed."))))))


;; Key Bindings

(defvar gpt-key-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "g") 'gptel-send)
    (define-key map (kbd "r") #'svjson/gptel-replace-region)
    (define-key map (kbd "b") #'svjson/gptel-rewrite-buffer)
    (define-key map (kbd "c") 'gptel-complete)
    (define-key map (kbd "e") 'gptel-edit)
    (define-key map (kbd "f") 'gptel-format)
    (define-key map (kbd "t") 'gptel-transpose)
    (define-key map (kbd "s") 'gptel-summary)
    map))

(global-set-key (kbd "M-m g") gpt-key-map)



(provide 'config-gptel)

;;; config-gptel.el ends here
