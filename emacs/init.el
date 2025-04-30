; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   '("4acfb4e3d5e86206c4c3a834f4a9356beb25dc04c48e4e364006eff5625606ab"
     "425b54fd2e41eb91d523c340f99661471abf8926637dd539d2d82085d4aeb7c0"
     default))
 '(geiser-mode-smart-tab-p t)
 '(package-native-compile t)
 '(package-selected-packages
   '(darkmine-theme dracula-theme evil exec-path-from-shell exwm
		    markdown-mode sly w3m with-editor xkcd zig-mode))
 '(ring-bell-function #'ignore)
 '(visible-bell nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; ==== FULLSCREEN ====
(toggle-frame-fullscreen)

;;;; ==== QUICK INTERNET FUNCTIONS ====
(defun clhs ()
  (interactive)
  (eww "https://www.lispworks.com/documentation/HyperSpec/Front/Contents.htm"))

(defun google (search-terms)
  (interactive "sSearch:")
  (eww (concat "https://duckduckgo.com/search?q="
	       (replace-regexp-in-string " " "+" search-terms)))
  )

;;;; ==== ALLOW EMACS TO FIND LIBGCCJIT FOR NATIVE PACKAGE COMP ====
(setenv "LD_LIBRARY_PATH"
        (concat "/usr/local/Cellar/libgccjit/14.2.0_1/lib/gcc/current/:"
                (getenv "LD_LIBRARY_PATH")))

(setenv "PKG_CONFIG_PATH"
        (concat "/usr/local/Cellar/libgccjit/14.2.0_1/lib/pkgconfig:"
                (getenv "PKG_CONFIG_PATH")))

;;;; ==== CHECK NATIVE COMP ====
(defun check-native-comp ()
  (interactive)
  (if (native-comp-available-p)
    (message "Native eLisp compilation is available!")
    (message "Native eLisp compilation is not available  :(")
    )
  )

;;;; ==== OPEN CONFIG ====
(defun config ()
  (interactive)
  (find-file "~/.dotfiles/emacs/init.el"))

;;;; ==== SLY ====
(add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly)))))
(setq inferior-lisp-program "sbcl --dynamic-space-size 8gb")
;
;;;; ==== THEME ====
;(load-theme 'darkmine)
;(load-theme 'wheatgrass)
(load-theme 'leuven-dark)
;(load-theme 'tango)

;;;; ==== EVIL MODE ====
(setq evil-want-C-u-scroll t)
(setq evil-disable-insert-state-bindings t)
(require 'evil)
(evil-set-initial-state 'char-mode 'emacs) ;;make sure evil mode is disable in terminal
(setq evil-default-state 'normal)
(evil-mode 1)			    

;;;; ==== MY CUSTOM KEYBINDINGS ====

(define-key evil-normal-state-map (kbd "SPC") (kbd  "C-x b"))

;(Define-key evil-normal-state-map "\C-n" 'evil-paste-pop-next)
;(define-key evil-normal-state-map "\C-p" 'evil-paste-pop)

(xterm-mouse-mode)
(setq backup-directory-alist `(("." . "~/.emacs-backups")))  ;; Store backups in a specific folder

(set-face-attribute 'default nil :height 170)

;;;; ==== CUSTOM LISP KEYWORDS ====

;;;;(defvar sly-repl-font-lock-keywords lisp-font-lock-keywords-2)
;;;;(defun sly-repl-font-lock-setup ()
;;;;  (setq font-lock-defaults
;;;;        '(sly-repl-font-lock-keywords
;;;;         ;; From lisp-mode.el
;;;;         nil nil (("+-*/.<>=!?$%_&~^:@" . "w")) nil
;;;;         (font-lock-syntactic-face-function
;;;;         . lisp-font-lock-syntactic-face-function))))
;;;;      
;;;;(add-hook 'sly-repl-mode-hook 'sly-repl-font-lock-setup)
;;;;      
;;;;(defadvice sly-repl-insert-prompt (after font-lock-face activate)
;;;;  (let ((inhibit-read-only t))
;;;;    (add-text-properties
;;;;     sly-repl-prompt-start-mark (point)
;;;;     '(font-lock-face
;;;;      sly-repl-prompt-face
;;;;      rear-nonsticky
;;;;      (sly-repl-prompt read-only font-lock-face intangible)))))


;;melpa
;;
;
;(when (window-system)
;  (tool-bar-mode -1)    ;; hide toolbar
;  (scroll-bar-mode -1))  ;; hide scrollbar
;;;      (set-frame-size (selected-frame) 100 60)) ;; in px
;(global-visual-line-mode t)  ;; wrap text to words at the end of the window (def chars)
;;;(global-hl-line-mode t)      ;; highlight current line
;(global-font-lock-mode t)    ;; syntax highlight wherever
;(blink-cursor-mode 0)        ;; disabled. put (blink-cursor-blinks NN) for NN blinks. 
;;; def 10, 0 or negative = forever
;(column-number-mode)         ;; view column number in modeline
;(setq-default line-spacing 3) ;; increase line height
;(show-paren-mode 1)             ;; highlight matching parentheses
;(save-place-mode)               ;; remember point position when saving file
;(setq-default tab-width 2)
;(setq-default indent-tabs-mode nil) ;; convert tabs to spaces

;Keybindings
;(global-unset-key "\C-l") (global-unset-key "\C-h")
;(global-set-key "\C-l" (kbd "C-x <left>"))
;(global-set-key "\C-h" (kbd "C-x <right>"))

;(global-unset-key (kbd "SPC"))
;(global-unset-key (kbd "C-SPC"))
;(global-set-key (kbd "C-SPC") (kbd "C-x 1"))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(put 'upcase-region 'disabled nil)

