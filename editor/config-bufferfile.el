;;; config-bufferfile.el --- summary -*- lexical-binding: t -*-



;; use-package

(use-package bufferfile
  :vc (:url "https://github.com/jamescherti/bufferfile.el"
            :rev :newest)
  :bind (("M-m f c" . bufferfile-copy)
         ("M-m f r" . bufferfile-rename)
         ("M-m f x" . bufferfile-delete)))



(provide 'config-bufferfile)


;;; config-bufferfile.el ends here
