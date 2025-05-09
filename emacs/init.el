; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     default))
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(package-native-compile t)
 '(package-selected-packages '(evil gruber-darker-theme sly))
 '(ring-bell-function #'ignore)
 '(scroll-bar-mode nil)
 '(url-proxy-services '(("http" . "127.0.0.1:4000")))
 '(visible-bell nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; ==== PARTIAL KEY CHORD ====
(which-key-mode)

;;;; ==== IDO MODE ====
(icomplete-vertical-mode);

;;;; ==== C CODING STYLE ====
(c-add-style "1tbs"
             '("java"
               (c-hanging-braces-alist
		(defun-open after)
		(class-open after)
		(inline-open after)
		(block-close . c-snug-do-while)
		(statement-cont)
		(substatement-open after)
		(brace-list-open)
		(brace-entry-open)
		(extern-lang-open after)
		(namespace-open after)
		(module-open after)
		(composition-open after)
		(inexpr-class-open after)
		(inexpr-class-close before)
		(arglist-cont-nonempty))
               (c-offsets-alist
		(access-label . -))))
(setq c-default-style "1tbs")
 
;;;; ==== SHOW 80 COLUMN LINE ====
(display-fill-column-indicator-mode 1)

;;;; ==== DISABLE TOP BARS ====
(menu-bar-mode -1)

;;;; ==== DISABLE SCROLL BAR ====
(setq scroll-bar-mode nil)

;;;; ==== LINE NUMBERS ====
(global-display-line-numbers-mode)

;;;; ==== FUNCTION TO REMOVE BUFFERS ====
(defun kill-all-buffers ()
  (interactive)
  (mapcar #'kill-buffer (buffer-list))
  (scratch-buffer)
  )

;;;; ==== I2P PROXY ====
(setq url-proxy-services '(("http" . "localhost:4444")))

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
(setenv "LD_LIBRARY_PATH" "/usr/local/Cellar/libgccjit/14.2.0_1/lib/gcc/current/")
(setenv "LIBRARY_PATH" "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib /usr/local/Cellar/libgccjit/14.2.0_1/lib/gcc/current/")

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
(load-theme 'gruber-darker)
;(load-theme 'darkmine)
;(load-theme 'wheatgrass)
;(load-theme 'leuven-dark)
;(load-theme 'tango)

;;;; ==== EVIL MODE ====
(defun setup-evil ()
  (setq evil-want-C-u-scroll t)
  (setq evil-disable-insert-state-bindings t)
  (require 'evil)
  (evil-set-initial-state 'char-mode 'emacs) ;;make sure evil mode is disable in terminal
  (setq evil-default-state 'normal)
  (define-key evil-normal-state-map (kbd "SPC") (kbd  "C-x b"))
  (evil-mode 1)			    
)


;;;; ==== MAKE LIST BUFFERS TAKE FOCUS ====
(define-key global-map [remap list-buffers] 'buffer-menu-other-window)

;;;; ==== SUPPORT MOUSE BETTER ====
(xterm-mouse-mode)

;;;; ==== PUT BACKUP FILES IN SPECIAL DIRECTORIES ====
(setq backup-directory-alist `(("." . "~/.emacs-backups")))

;;;; ==== ENSURE NEW WINDOWS ARE VERTICAL ====
(set-face-attribute 'default nil :height 170)

;;;; ==== AUTOSTART ESHELL ====
(eshell)

(put 'upcase-region 'disabled nil)
