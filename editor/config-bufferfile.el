;;; config-bufferfile.el --- summary -*- lexical-binding: t -*-



;; use-package

(use-package bufferfile
  :ensure t
  :vc (:url "https://github.com/jamescherti/bufferfile.el"
            :rev :newest))



;; Key Bindings

(global-set-key (kbd "M-m f c") 'bufferfile-copy)
(global-set-key (kbd "M-m f r") 'bufferfile-rename)
(global-set-key (kbd "M-m f x") 'bufferfile-delete)



(provide 'config-bufferfile)


;;; config-bufferfile.el ends here
