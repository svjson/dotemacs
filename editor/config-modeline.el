;;; config-modeline.el --- Modeline config -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

(defvar svjson/minor-mode-icons
  '((copilot-mode      . "✈️")
    (blacken-mode      . "✨")
    (prettier-mode     . "✨")
    (paredit-mode      . "󰅲")
    (company-mode      . "🧠")
    (company-box-mode  . "📦")
    (which-key-mode    . "⌨️")
    (lsp-mode          . "🧬")
    (tree-climber-mode . "🌲")
    (flycheck-mode     . svjson/flycheck-icon)
    (yas-minor-mode    . "🧩"))
  "Icons for selected minor modes.")

(defvar svjson/minor-mode-tooltips
  '((flycheck-mode . svjson/flycheck-tooltip)))

(defvar svjson/minor-mode-extra-menu-items
  '((lsp-mode . (lambda () lsp-mode-menu))
    ;; (company-mode  ("Butterfly Effect" . butterfly)
    )
  "Alist of extra menu items for minor modes.
Each entry is (MODE . LIST-OF-(LABEL . FUNCTION))")

(defvar svjson/minor-mode-ignore-list
  '(auto-revert-mode
    company-mode
    company-box-mode
    company-search-mode
    dash-fontify-mode
    eldoc-mode
    lsp-completion-mode
    lsp-diagnostics-mode
    lsp-headerline-breadcrumb-mode
    lsp-lens-mode
    lsp-modeline-diagnostics-mode
    lsp-modeline-code-actions-mode
    lsp-modeline-workspace-status-mode
    text-scale-mode
    magit-blame-mode
    magit-wip-mode
    page-break-lines-mode
    smartparens-mode
    undo-tree-mode
    which-key-mode
    xref-etags-mode)
  "Minor modes that should not be shown in the modeline.")

(defvar svjson/minor-mode-default-icon "❔"
  "Default icon for minor modes not explicitly listed.")

(defun svjson/get-icon-for-mode (mode)
  "Get the icon to display in the modeline for the argument MODE.
First evaluate the presence of the mode in SVJSON/MINOR-MODE-ICONS,
and determine if it contains a string or a function symbol, otherwise
fall back to the default icon."
  (let ((entry (alist-get (car mode) svjson/minor-mode-icons)))
    (cond
     ((stringp entry) entry)
     ((functionp entry) (funcall entry))
     (t svjson/minor-mode-default-icon))))

(defun svjson/get-tooltip-for-mode (mode)
  (let ((entry (alist-get (car mode) svjson/minor-mode-tooltips)))
    (cond
     ((stringp entry) entry)
     ((functionp entry) (funcall entry))
     (t (format "Click for %s menu" mode)))))

(defun svjson/show-minor-mode-menu (mode)
  "Show the minor mode context menu for MODE, with optional custom items.
Falls back to a default menu if the mode defines none."
  (let* ((base-menu (minor-mode-menu-from-indicator mode))
         (extras (alist-get mode svjson/minor-mode-extra-menu-items))
         (extra-entries (mapcar (lambda (item)
                                  (vector (car item) (cdr item) t))
                                extras)))
    (if (and (listp base-menu) (stringp (car base-menu)))
        ;; Mode provides a menu, augment it
        (let* ((title (car base-menu))
               (body (cdr base-menu))
               (final (easy-menu-create-menu title (append extra-entries body))))
          (popup-menu final))
      ;; Mode does not provide a menu — use fallback
      (let ((fallback-menu (easy-menu-create-menu
                            (symbol-name mode)
                            (append
                             extra-entries
                             `([,(format "Describe %s" mode)
                                ,(lambda () (interactive) (describe-mode)) t]
                               [,(format "Customize %s" mode)
                                ,(lambda () (interactive) (customize-group mode)) t]
                               [,(format "Toggle %s" mode)
                                ,(lambda () (interactive)
                                   (call-interactively mode)) t])))))
        (popup-menu fallback-menu)))))

(use-package doom-modeline
  :ensure t
  :init
  ;; Set before loading doom-modeline
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-icon t)		 ;; Enable icons
  (setq doom-modeline-major-mode-icon t) ;; Show icon for major mode
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-minor-modes t)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-indent-info t)
  (setq doom-modeline-column-zero-based t)

  ;; Useful segments
  (setq doom-modeline-vcs-max-length 20)
  (setq doom-modeline-check-simple-format nil)
  (setq doom-modeline-env-version t) ;; Show python, node, etc

  ;; Enable LSP / Flycheck info
  (setq doom-modeline-lsp t)
  (setq doom-modeline-github nil) ;; You can turn this on if you authenticate
  (setq doom-modeline-mu4e nil)   ;; Turn on if you use mu4e for mail
  (setq doom-modeline-gnus nil)
  (setq doom-modeline-position-column-line-format '("%c:%l"))

  :config
  (column-number-mode 1)

  :hook
  (after-init . doom-modeline-mode))

(defun svjson/setup-custom-modeline ()
  (require 'doom-modeline)

	(doom-modeline-def-segment svjson-minor-modes
	  (let ((active-modes
		       (cl-remove-if-not
		        (lambda (mode-entry)
			        (let ((mode (car mode-entry)))
			          (and (memq mode local-minor-modes)
			               (not (memq mode svjson/minor-mode-ignore-list)))))
		        minor-mode-alist)))
		  (cl-loop for mode in active-modes
			         collect
			         (let* ((icon (svjson/get-icon-for-mode mode))
				              (tooltip (svjson/get-tooltip-for-mode mode))
				              (map (let ((m (make-sparse-keymap)))
				                     (define-key m [mode-line mouse-1]
						                             `(lambda () (interactive)
						                                (svjson/show-minor-mode-menu ',mode)))
				                     m)))
			           (propertize (concat " " icon)
				                     'mouse-face 'mode-line-highlight
				                     'help-echo tooltip
				                     'local-map map)))))

	(doom-modeline-def-modeline 'svjson-modeline
	  '(bar window-number modals buffer-info remote-host buffer-position parrot)
	  '(svjson-minor-modes major-mode))

	(setq-default mode-line-format '(:eval (doom-modeline 'svjson-modeline))))

(with-eval-after-load 'doom-modeline


  (add-hook 'doom-modeline-refresh-hook #'svjson/setup-custom-modeline)

  (add-hook 'doom-modeline-mode-hook #'svjson/setup-custom-modeline))

(provide 'config-modeline)
;;; config-modeline.el ends here
