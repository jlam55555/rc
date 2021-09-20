(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   '(("" "%(PDF)%(latex) %(file-line-error) -shell-escape %(extraopts) %(output-dir) %S%(PDFout)")))
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes nil)
 '(dumb-jump-selector 'ivy)
 '(global-nyan-mode t)
 '(haskell-mode-hook '(interactive-haskell-mode haskell-indentation-mode))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(line-number-display-limit nil)
 '(line-number-display-limit-width 2000000)
 '(nyan-animate-nyancat t)
 '(nyan-wavy-trail t)
 '(package-selected-packages
   '(company-quickhelp xref ivy-xref counsel "counsel" "counsel" "counsel-mode" ivy dumb-jump company-ghci sqlup-mode htmlize haskell-mode nov define-word company geiser-chez geiser cargo all-the-icons-dired all-the-icons solaire-mode pug-mode minimap fireplace monokai-theme magit expand-region rust-mode paredit auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'monokai-pro t)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'geiser-repl-mode-hook           #'enable-paredit-mode)

;;; allow dumb-jump to take precedence
(add-hook 'geiser-mode-hook
          (lambda ()
            (define-key geiser-mode-map (kbd "M-.") nil)))

(global-set-key (kbd "C-\\") 'er/expand-region)

(defun find-in-subtree (filename)
  (interactive "sFilename: ")
  (find-name-dired "" filename))

(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key (kbd "f") 'find-in-subtree)
            (local-set-key (kbd "c") 'find-file-other-window)))

(put 'dired-find-alternate-file 'disabled nil)

;;; C-x r b to access bookmark

(defun kill-buffer-in-other-window ()
  (interactive)
  "I just find this handy sometimes when working in two windows."
  (other-window 1)
  (kill-buffer)
  (other-window -1))

(global-set-key (kbd "C-x c") 'kill-buffer-in-other-window)

(define-globalized-minor-mode global-nyan-mode nyan-mode
  (lambda () (nyan-mode 1)))
(global-nyan-mode 1)

(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(beacon-mode 1)

;;; dumb-jump
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;;; solaire-mode
(solaire-global-mode +1)

;;; all-the-icons-dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;;; all-the-icons
(require 'all-the-icons)

;;; cargo
(add-hook 'rust-mode-hook 'cargo-minor-mode)

;;; dired-details
(add-to-list 'load-path (concat user-emacs-directory "/my-packages/dired-details"))
(load "dired-details")

;;; company mode
(add-hook 'after-init-hook 'global-company-mode)

;;; this doesn't work?
(add-hook 'geiser-repl-mode-hook
          (lambda () (company-mode -1)))

;;; define-word
(global-set-key (kbd "C-c d") 'define-word-at-point)
(global-set-key (kbd "C-c D") 'define-word)

;;; sentence-highlight
;;; https://www.emacswiki.org/emacs/sentence-highlight.el
(add-to-list 'load-path (concat user-emacs-directory "/my-packages/sentence-highlight"))
(load "sentence-highlight")

;;; ivy autocompletion
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
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
      '((t . ivy--regex-fuzzy)
        (t . ivy--regex-plus)))

;;; dumb-jump with completing-read
(setq xref-show-definitions-function #'xref-show-definitions-completing-read)

;;; from https://github.com/alexmurray/ivy-xref
(require 'ivy-xref)
;; xref initialization is different in Emacs 27 - there are two different
;; variables which can be set rather than just one
(when (>= emacs-major-version 27)
  (setq xref-show-definitions-function #'ivy-xref-show-defs))
;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
;; commands other than xref-find-definitions (e.g. project-find-regexp)
;; as well
(setq xref-show-xrefs-function #'ivy-xref-show-xrefs)

;;; company-ghci
(require 'company-ghci)
(push 'company-ghci company-backends)
;; (add-hook 'haskell-mode-hook 'company-mode)
;;; To get completions in the REPL
(add-hook 'haskell-interactive-mode-hook 'company-mode)

;;; for some reason this wasn't persisting above; have to set it here again
(setq haskell-mode-hook '(interactive-haskell-mode haskell-indentation-mode))
