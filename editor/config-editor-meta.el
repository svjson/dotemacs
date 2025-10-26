;;; config-editor-meta.el --- summary -*- lexical-binding: t -*-



;; Disable GUI elements
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))


;; Terminate blinking cursor with extreme prejudice
(blink-cursor-mode -1)



(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(toggle-truncate-lines 1)

(use-package nlinum
  :commands (nlinum-mode))

(require 'windmove)
(windmove-default-keybindings)

(use-package scratches)

(use-package expand-region
  :bind
  ("C-x r e" . er/expand-region))

(add-hook 'window-configuration-change-hook
          (lambda () (set-window-fringes (selected-window) 5 2)))



;;; Page breaks and movement

(use-package page-break-lines
  :hook (after-init . global-page-break-lines-mode)
  :config
  (defvar page-break-lines-modes)
  (dolist (mode '(typescript-ts-mode typescript-mode text-mode js-ts-mode))
    (add-to-list 'page-break-lines-modes mode)))

(defun svjson/forward-page ()
  (interactive)
  (forward-page)
  (beginning-of-line))

(defun svjson/backward-page ()
  (interactive)
  (backward-page)
  (beginning-of-line))



;;; Overlays

(defun svjson/clear-window-overlays ()
  (dolist (o (overlays-in (window-start) (window-end)))
      (delete-overlay o)))



;;; Duplicate window state

(defun windmove-duplicate-state (dir)
  "Duplicate current window's state into the window in direction DIR.
If there is no window in that direction, split one and copy into it."
  (let* ((this (selected-window))
         (target (or (windmove-find-other-window dir)
                     ;; Create one if missing:
                     (split-window this nil dir)))
         (state (window-state-get this)))
    (window-state-put state target)
    (select-window this)
    (message "Duplicated window to the %s" dir)))

(defun windmove-duplicate-left  () (interactive) (windmove-duplicate-state 'left))
(defun windmove-duplicate-right () (interactive) (windmove-duplicate-state 'right))
(defun windmove-duplicate-up    () (interactive) (windmove-duplicate-state 'up))
(defun windmove-duplicate-down  () (interactive) (windmove-duplicate-state 'down))


;;; Key Bindings

;; Other window operations
(defvar other-window-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd ".") 'xref-find-definitions-other-window)
    map))

(global-set-key (kbd "M-q") other-window-map)
(define-key prog-mode-map (kbd "M-q") other-window-map)

;; Toggle line numbers
(global-set-key (kbd "C-x l") #'nlinum-mode)

;; Text size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Window state
(global-set-key (kbd "C-c C-w <left>") 'windmove-swap-states-left)
(global-set-key (kbd "C-c C-w <right>") 'windmove-swap-states-right)
(global-set-key (kbd "C-c C-w <up>") 'windmove-swap-states-up)
(global-set-key (kbd "C-c C-w <down>") 'windmove-swap-states-down)

(global-set-key (kbd "C-c C-s-w <left>") 'windmove-duplicate-left)
(global-set-key (kbd "C-c C-s-w <right>") 'windmove-duplicate-right)
(global-set-key (kbd "C-c C-s-w <up>") 'windmove-duplicate-up)
(global-set-key (kbd "C-c C-s-w <down>") 'windmove-duplicate-down)

;; Navigate page breaks
(global-set-key (kbd "C-x [") #'svjson/backward-page)
(global-set-key (kbd "C-x ]") #'svjson/forward-page)




(provide 'config-editor-meta)

;;; config-editor-meta.el ends here
