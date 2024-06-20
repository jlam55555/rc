;;; package --- Summary
;;; Commentary:
;;; This header is just to appease flycheck.
;;; Code:

;; Turn off extra visual elements
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Stop creating backups.
(setq make-backup-files nil)

;; hl-line.el
(global-hl-line-mode 1)

;; package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package.el
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-verbose t)

;; diminish.el
(use-package diminish)

;; bind-key.el
;; for unbind-key
(use-package bind-key)

;; paredit.el
(use-package paredit
  :config
  ;; These collide with the windmove bindings.
  (unbind-key "M-<up>" paredit-mode-map)
  (unbind-key "M-<down>" paredit-mode-map)
  :hook
  (emacs-lisp-mode . enable-paredit-mode)
  (eval-expression-minibuffer-setup-hook . enable-paredit-mode))

;; windmove.el
(use-package windmove
  :bind (("M-<left>" . windmove-left)
	 ("M-<right>" . windmove-right)
	 ("M-<up>" . windmove-up)
	 ("M-<down>" . windmove-down)))

;; expand-region.el
(use-package expand-region
  :bind ("C-\\" . er/expand-region))

;; format-all.el
(use-package format-all
  :diminish
  :hook
  (prog-mode . format-all-mode)
  (format-all-mode . format-all-ensure-formatter))

;; ivy/counsel/swiper: narrowing completion tools
(use-package ivy
  :diminish
  :config
  (setq ivy-re-builders-alist
	;; Fuzzy search for commands only (M-x). This would
	;; give too many matches for swiper.
	'((counsel-M-x . ivy--regex-fuzzy)
	  (t . ivy--regex-plus)))
  (ivy-mode))
(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)))
(use-package counsel
  :diminish
  :after ivy
  :config (counsel-mode)
  ;; Finish company completions in minibuffer.
  ;; Alternatively (and probably better) is complete-symbol,
  ;; which allows you to do a narrowing search inline.
  ;; Which maybe makes company-mode obsolete.
  :bind ("C-c C-x C-c" . counsel-company))

;; flycheck.el: syntax checking (& integration with lsp)
(use-package flycheck
  :init (global-flycheck-mode))

;; lsp.el: language server protocol
(use-package lsp-mode
  :hook (prog-mode . lsp)
  :commands lsp
  :config
  ;; If lsp doesn't exist or isn't installed, don't warn.
  (setq lsp-warn-no-matched-clients nil))
(use-package lsp-ivy
  :after lsp-mode
  :commands lsp-ivy-workspace-symbol)

;; projectile.el: package management
(use-package projectile
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))
(use-package projectile-ripgrep)

;; company.el: completion front-end
(use-package company
  :config (global-company-mode))

;;; init.el ends here

;; custom.el
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven))
 '(package-selected-packages
   '(company projectile-ripgrep projectile lsp-ivy lsp-mode flycheck diminish counsel swiper ivy format-all paredit expand-region)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:extend t :foreground "#8D8D84" :slant italic))))
 '(hl-line ((t (:extend t :background "color-117")))))
