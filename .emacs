;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;-------------------personal functions--------------------

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(defun open-init-emacs-config-file()
  (interactive)
  (find-file "~/.emacs"))
(global-set-key (kbd "<f9>") 'open-init-emacs-config-file)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  ;(add-to-list 'package-archives '("melpa" , "https://melpa.org/packages") t)
  (add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  )
(require 'cl)
;;add whatever packages you want here
(defvar lmn/packages '(
					   hungry-delete
					   ;; smex
					   swiper-helm
					   pyenv-mode
					   popwin
					   ;;neo-tree
		       ) "Default packages")
(defun lmn/packages-install-p()
  (loop for pkg in lmn/packages
		when (not (package-installed-p pkg)) do (return nil)
		finally (return t)))
(unless (lmn/packages-install-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg lmn/packages)
	(when (not (package-installed-p pkg))
  (package-install pkg))))

(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
											("9op" "VTAPI_open()")
											))
;;'------------------------------------------------------------------------------------


;;---------------End personlal functions--------------------
;;--------------------------------------personal configurations--------------------------------

(require 'company)
(setq inhibit-splash-screen t)
;(global-hl-line-mode t)
;;global-company-mode 1
(add-hook 'after-init-hook 'global-company-mode)
;(require 'auto-complete-config)
;(require 'auto-complete)
;; autocomplete paired brackets
(electric-pair-mode 1)
(require 'golden-ratio)
(golden-ratio-mode 1)
;; full screen
(run-with-idle-timer 1 nil 'w32-send-sys-command 61488)
;;windows number
(require 'window-number)
(window-number-meta-mode 1)
;;show line number
;(when (version<= "26.0.50" emacs-version )
;  (global-display-line-numbers-mode))
(global-linum-mode 1) 
(require 'org)
(setq org-src-fontify-natively t)
;; Select word is selected
(delete-selection-mode t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'tango-dark t)
(require 'hungry-delete)
(global-hungry-delete-mode)
(require 'swiper-helm)
(global-set-key (kbd "C-s") 'swiper)
(require 'popwin)
(popwin-mode t)
(global-set-key (kbd "M-<left>") 'pop-global-mark)
(global-set-key (kbd "M-<right>") 'push-mark-command)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; No backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
;;--------------------------------------End personal configurations--------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(company-minimum-prefix-length 1)
 '(linum-format "%7d")
 '(package-selected-packages
   (quote
	(company golden-ratio-scroll-screen golden-ratio ace-jump-mode evil-numbers evil helm-cscope auto-complete ag helm)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Î¢ÈíÑÅºÚ" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))


;-------------------helm--------------------
;(require 'helm)
(require 'helm-config)
(helm-mode 1)
;(require 'helm-ack)
(setq helm-grep-default-command
      "grep --color=always -d skip %e -n%cH -e %p %f"
      helm-grep-default-recurse-command
      "grep --color=always -d recurse %e -n%cH -e %p %f")
;;; Global-map
(global-set-key (kbd "M-x")                          'helm-M-x)
(global-set-key (kbd "C-;")                            'helm-mini)
(global-set-key (kbd "M-y")                          'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f")                     'helm-find-files)
;;---------------End helm--------------------
;;-------------------projectile--------------------
(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
;;---------------End projectile--------------------
;;------------------Cscope-------------------------
;; Load xcscope package
(require 'xcscope)
;(add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
;; Don't update database when searching
(setq cscope-do-not-update-database t)
;; Setup cscope in c, c++ major mode
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode)
              (cscope-setup))))
(global-set-key (kbd "C-,")                          'helm-cscope-find-this-symbol)
(global-set-key (kbd "C-'")                          'helm-cscope-find-global-definition)
(global-set-key (kbd "C-.")                          'helm-cscope-find-egrep-pattern)
(global-set-key (kbd "M-c")                        'helm-cscope-find-calling-this-function)
;;------------------End Cscope---------------------

;;------------------Evil------------------------------
(require 'undo-tree)
(global-undo-tree-mode)
(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)
(require 'evil-leader)
(evil-leader/set-leader "<SPC>")
(global-evil-leader-mode)
(require 'evil)
(evil-mode 1)

(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

;;------------------End Evil---------------------------
;;-----------------------ace-jump-mode--------------------------------
;;
;; ace jump mode major function
;; 
(add-to-list 'load-path "C:/Users/toshiba/AppData/Roaming/.emacs.d/elpa/ace-jump-mode-20140616.1615")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; 
;; enable a more powerful jump back function from ace jump mode
;;
;; (autoload
;;   'ace-jump-mode-pop-mark
;;   "ace-jump-mode"
;;   "Ace jump back:-)"
;;   t)
;; (eval-after-load "ace-jump-mode"
;;   '(ace-jump-mode-enable-mark-sync))
;; (define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;If you use viper mode :
;(define-key viper-vi-global-user-map (kbd "SPC") 'ace-jump-mode)
;;If you use evil
;;(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)
;;---------------------End ace-jump-mode-------------------------------

;;---------------------highlight-symbol-------------------------------
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;;---------------------End  highlight-symbol-------------------------------

;;---------------------dired-------------------------------
;; open current file folder( C-x C-j)
(require 'dired-x)
;; copy file to other window with dired
(setq dired-dwim-target t)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  )
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
;;---------------------End  dired-------------------------------
(put 'dired-find-alternate-file 'disabled nil)
