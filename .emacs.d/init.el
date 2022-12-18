(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;;; TODO: use use-package to install/configure packages automatically.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dumb-jump-selector 'ivy)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(line-number-display-limit nil)
 '(line-number-display-limit-width 2000000)
 '(package-selected-packages
   '(slime-company slime flycheck lsp-mode cargo-mode markdown-mode format-all highlight-indent-guides yaml-mode pdf-tools company-quickhelp xref ivy-xref counsel counsel counsel counsel-mode ivy dumb-jump company-ghci haskell-mode company geiser-chez geiser cargo all-the-icons-dired all-the-icons solaire-mode magit expand-region rust-mode paredit auctex monokai-pro-theme nyan-mode)))

;;; Load theme
(load-theme 'monokai-pro t)

;;; Windmove commands
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)

;;; Paredit (https://www.emacswiki.org/emacs/ParEdit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'geiser-repl-mode-hook      #'enable-paredit-mode)

;;; Expand region keyboard shortcut
(global-set-key (kbd "C-\\") 'er/expand-region)

;;; Dired keyboard shortcuts
(defun find-in-subtree (filename)
  (interactive "sFilename: ")
  (find-name-dired "" filename))
(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key (kbd "f") 'find-in-subtree)
            (local-set-key (kbd "c") 'find-file-other-window)))
(put 'dired-find-alternate-file 'disabled nil)

;;; Kill the other window easily
(defun kill-buffer-in-other-window ()
  (interactive)
  "I just find this handy sometimes when working in two windows."
  (other-window 1)
  (kill-buffer)
  (other-window -1))
(global-set-key (kbd "C-x c") 'kill-buffer-in-other-window)

;;; NYAAAAAA
(define-globalized-minor-mode global-nyan-mode nyan-mode
  (lambda () (nyan-mode 1)))
(global-nyan-mode 1)

;;; Turn off extras
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;; Highlight current line
(global-hl-line-mode 1)

;;; dumb-jump: useful for grepping within a directory quickly
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;;; solaire-mode: Makes contrast for menus a little better
(solaire-global-mode +1)

;;; all-the-icons: Makes dired prettier
(require 'all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;;; company mode: Autocompletion backend
(add-hook 'after-init-hook 'global-company-mode)

;;; Make company autocomplete more responsive
;;; see: https://emacs.stackexchange.com/a/23937
(setq company-idle-delay 0)

;;; define-word: Dictionary time
(global-set-key (kbd "C-c d") 'define-word-at-point)
(global-set-key (kbd "C-c D") 'define-word)

;;; ivy/swiper: Autocompletion frontend
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;; ivy overlay
;;; https://github.com/abo-abo/swiper/wiki/ivy-display-function
(setq ivy-display-function 'ivy-display-function-overlay)

;;; ivy completion type; https://oremacs.com/swiper/#completion-styles
;;; use default emacs completion (fuzzy)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))

;;; dumb-jump with completing-read
(setq xref-show-definitions-function #'xref-show-definitions-completing-read)

;;; from https://github.com/alexmurray/ivy-xref
(require 'ivy-xref)
(when (>= emacs-major-version 27)
  (setq xref-show-definitions-function #'ivy-xref-show-defs))
(setq xref-show-xrefs-function #'ivy-xref-show-xrefs)

;;; pdf-tools
(pdf-loader-install)

;;; format-all
(add-hook 'prog-mode-hook 'format-all-mode)
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

;;; LISP setup
(slime-setup '(slime-fancy slime-company))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;;; Give SLIME more heap
(setq slime-lisp-implementations
      '((sbcl ("sbcl" "--dynamic-space-size" "4096"))))
