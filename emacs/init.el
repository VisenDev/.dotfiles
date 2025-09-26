; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bubbles-game-theme 'difficult)
 '(bubbles-graphics-theme 'circles)
 '(custom-safe-themes
   '("6dbb88c9f23bad08cd4d52182100a1f899527c39ffdc8dc58d05cc558ce62e5e"
     "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(next-screen-context-lines 10)
 '(package-native-compile t)
 '(package-selected-packages
   '(cmake-mode evil gruber-darker-theme meson-mode mines sly zig-mode))
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

;;;; ==== FUN COMMANDS TO REMEMBER ====
;; spook
;; xref
;; time-mode
;; artist-mode

;; make hippie-expand use dabbrev first
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        ;;try-expand-all-abbrevs
        ;;try-expand-list
        ;;try-expand-line
        ;;try-complete-lisp-symbol-partially
        ;;try-complete-lisp-symbol
        ))

(defun indent-or-hippie-expand ()
  "Indent. If point didn't move, try `hippie-expand`."
  (interactive)
  (let ((pt (point)))
    (indent-for-tab-command)
    (when (= pt (point))
      (hippie-expand nil))))

;; Use in programming and text buffers
(add-hook 'prog-mode-hook
          (lambda () (local-set-key (kbd "TAB") #'indent-or-hippie-expand)))
(add-hook 'text-mode-hook
          (lambda () (local-set-key (kbd "TAB") #'indent-or-hippie-expand)))


;;;; ==== TIME ====
(display-time-mode)

;;;; ==== ADD PATH ====
(setenv "PATH" (format "%s:%s" "~/.local/bin/" (getenv "PATH")))

;;;; ==== SPECIAL ESHELL BINDING ====
(defun goto-eshell ()
  (interactive)
  (let ((eshell-exists nil))
    (dolist (buf (buffer-list))
      (when (string-equal "*eshell*" (buffer-name buf))
        (setq eshell-exists t)))
    (unless eshell-exists
      (eshell))
    (switch-to-buffer "*eshell*")
    (delete-other-windows)))

(define-key (current-global-map) (kbd "C-c k") 'goto-eshell)

;;;; ==== QUICK RETURN TO FILE ====
(defun goto-last-file-buffer ()
  (interactive)
  (let ((last-file nil))
    (catch 'break 
      (dolist (buf (buffer-list))
        (when (buffer-file-name buf)
          (switch-to-buffer buf)
          (throw 'break (buffer-file-name buf))
          )
      ))))

(define-key (current-global-map) (kbd "C-c j") 'goto-last-file-buffer)

;;;; ==== QUICK BUFSWAP ====
(defun quick-bufswap ()
  (interactive)
  (mode-line-other-buffer)
  (delete-other-windows)
  )
(define-key (current-global-map) (kbd "C-c n") 'quick-bufswap)

;;;; ==== QUICK DELETE OTHER WINDOWS ====
(define-key (current-global-map) (kbd "C-c o") 'delete-other-windows)

;;;; ==== PARTIAL KEY CHORD ====
(which-key-mode)

;;;; ==== IDO MODE ====
(fido-mode)

;;;; ==== BETTER SCROLL ====
(setq scroll-preserve-screen-position 'always)
(setq fast-but-imprecise-scrolling t)
(setq scroll-error-top-bottom t)
(setq scroll-conservatively 101)
(setq scroll-margin 10)

;;;; ==== DISABLE LINE WRAP ====
(setq-default truncate-lines t)

;;;; ==== SPACES INSTEAD OF TABS ====
(setq-default indent-tabs-mode nil
              tab-width 4)

;;;; ==== ALLOW TAB AUTOCOMPLETE ====
(setq tab-always-indent 'complete)

;;;; ==== SHOW COLUMN 80 LIMIT ====
(setq-default fill-column 80)
;(global-display-fill-column-indicator-mode 1)

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

(defun my-c-mode-style ()
  (c-set-offset 'arglist-intro '+)      ;; indent arguments relative to "("
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist) ;; keep hanging
  (c-set-offset 'arglist-close 0))      ;; align closing ")" with call

(add-hook 'c-mode-common-hook #'my-c-mode-style)

;;;; ==== REMEMBER RECENT FILES ====
(recentf-mode)
 
;;;; ==== DISABLE TOP BARS ====
(tool-bar-mode -1)

;;;; ==== DISABLE SCROLL BAR ====
(setq scroll-bar-mode nil)

;;;; ==== LINE NUMBERS ====
(global-display-line-numbers-mode)

;;;; ==== FASTER STARTUP ====
(setq frame-resize-pixelwise t)

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
;(setenv "LD_LIBRARY_PATH" "/usr/local/Cellar/libgccjit/14.2.0_1/lib/gcc/current/")
;(setenv "LIBRARY_PATH" "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib /usr/local/Cellar/libgccjit/14.2.0_1/lib/gcc/current/")

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
(let ((eshell-exists nil))
  (dolist (buf (buffer-list))
    (when (string-equal "*eshell*" (buffer-name buf))
      (setq eshell-exists t)))
  (unless eshell-exists
    (eshell)))

;;;; ==== ALLOW UPCASE AND DOWNCASE ====
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;;; ==== ODIN ====
(load "~/.dotfiles/emacs/odin-mode.el")

;;;; ==== RECOMPILE ====
(define-key global-map (kbd "C-c l") 'recompile)

;;;; ==== MELPA ====
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;;;; ==== C3 SYNTAX ====
(add-to-list 'auto-mode-alist '("\\.c3\\'" . c-mode))

;;;; ==== TCL CONFIG ====
(setq-default tcl-application "tclsh")
