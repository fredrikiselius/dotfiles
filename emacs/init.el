;; init.el --- Emacs configuration

;; Install packages
;; --------------------------------

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(all-the-icons
    auctex
    better-defaults
    lua-mode
    elpy
    flycheck
    flyspell
    doom-themes
    neotree
    atom-one-dark-theme
    py-autopep8))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; Basic Configuration
;; --------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'atom-one-dark t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(menu-bar-mode -1)
(tool-bar-mode 0)

;; Font
(set-frame-font "Tamsyn 14" nil t)

;; Store all backup and autosaves in tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Doom Config
;; --------------------------------
(doom-themes-neotree-config)

;; NeoTree Configuration
;; --------------------------------
(setq neo-smart-open t)

;; Python Configuration
;; --------------------------------
(elpy-enable)

;; use flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; LaTex Configuration
;; --------------------------------
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
(when (require 'flycheck nil t)
  (add-hook 'LaTeX-mode-hook 'flycheck-mode))

;; Spell-checking
(setq ispell-program-name "hunspell")
(setq ispell-directory "en_US")
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (matlab-mode material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
