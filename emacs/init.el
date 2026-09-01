;; -*- lexical-binding: t; -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bubbles-game-theme 'difficult)
 '(bubbles-graphics-theme 'circles)
 '(column-number-mode t)
 '(custom-safe-themes
   '("6dbb88c9f23bad08cd4d52182100a1f899527c39ffdc8dc58d05cc558ce62e5e"
     "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7"
     default))
 '(display-time-mode t)
 '(doc-view-mupdf-use-svg nil)
 '(erc-accidental-paste-threshold-seconds 1)
 '(erc-autojoin-channels-alist
   '((Libera.Chat "##meshtasic" "#shirakumo" "#i2p" "#lisp" "#emacs"
                  "#commonlisp")))
 '(erc-hide-list '("JOIN" "PART" "QUIT"))
 '(erc-keep-place-indicator-follow t)
 '(erc-modules
   '(autoaway autojoin button completion fill imenu irccontrols keep-place list
              match menu move-to-prompt netsplit networks readonly ring sound
              stamp track unmorse))
 '(erc-nick "Visen")
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(mark-even-if-inactive nil)
 '(next-screen-context-lines 10)
 '(package-native-compile t)
 '(package-selected-packages
   '(bongo cmake-mode company free-keys gruber-darker-theme markdown-mode
           paredit php-mode slime))
 '(proced-auto-update-flag 'visible)
 '(ring-bell-function #'ignore)
 '(safe-local-variable-values
   '((Package . ANAPHORA) (Package . MARSHAL) (Package . DEMO-SCROLLBAR)
     (Package . DEMO-MENU) (Package . OPAL) (Syntax . Common-lisp)
     (Package CLOSETTE :USE LISP) (Package . INTERACTORS) (Package . GEM)
     (Package . DEMO-TWOP) (Package . KR) (Package . GARNET-GADGETS)
     (Package . GARNET-UTILS) (base . 10) (package . c32)
     (syntax . common-lisp) (Package . C32) (Package . COMMON-LISP-USER)
     (Package . ASDF) (Package . CL-USER) (Syntax . ANSI-Common-Lisp)
     (Syntax . Common-Lisp) (Lowercase . T) (Base . 10)
     (Syntax . COMMON-LISP) (Package . XLIB)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
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
;; proced

;;;; ==== UNBLUR PDF TEXT ====
(setq doc-view-resolution 200)

;;;; ==== EMACS SERVER ====
(defvar use-emacs-server nil)
(when use-emacs-server
  (server-start))

;;;; ==== COLLAPSE ====
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c <right>") 'hs-show-block)
(global-set-key (kbd "C-c <left>") 'hs-hide-block)

;;;; ==== DIRED ====
(setq dired-kill-when-opening-new-dired-buffer t)

;;;; ==== TRASH ====
(setq delete-by-moving-to-trash t)

;;;; ==== JOIN NEXT LINE ====
(defun join-next-line ()
  (interactive)
  (let ((p (point)))
    (move-end-of-line nil)
    (next-line)
    (join-line)
    (goto-char p)
    ))
(define-key (current-global-map) (kbd "C-c j") 'join-next-line)

;;;; ==== DONT ASK TO KILL PROCESSES BEFORE EXITING ====
(setq confirm-kill-processes nil)

;;;; ==== BETTER FILE INTERACTIONS ====
(ffap-bindings)

;;;; ==== AUTOCOMPLETE ====
;; (add-hook 'prog-mode-hook 'company-mode)

;;;; ==== BETTER LISP INTERACTIONS ====
(add-hook 'lisp-mode-hook 'paredit-mode)
(define-key lisp-mode-map (kbd "C-.") 'paredit-forward-slurp-sexp)
(define-key lisp-mode-map (kbd "M-F") 'paredit-forward-slurp-sexp)
(define-key lisp-mode-map (kbd "C-,") 'paredit-forward-barf-sexp)
(define-key lisp-mode-map (kbd "M-B") 'paredit-forward-barf-sexp)
(add-hook 'lisp-mode-hook 'electric-indent-mode)
(add-hook 'emacs-lisp-mode-hook 'electric-indent-mode)

;;;; ==== Auto-refresh dired on file change ====
(add-hook 'dired-mode-hook 'auto-revert-mode)

;;;; ==== Auto-refresh proced on file change ====
(add-hook 'proced-mode-hook 'auto-revert-mode)

;;;; ==== TIME ====
(display-time-mode)

;;;; ==== ADD PATH ====
(setenv "PATH" (format "%s:%s" "~/.local/bin/" (getenv "PATH")))

;;;; ==== ESHELL ====
(defun eshell-at-cwd ()
  "Opens eshell in the same buffer as the current buffer"
  (interactive)
  (let ((cwd (buffer-local-value 'default-directory (current-buffer))))
    (eshell)
    (eshell-kill-input)
    (unless (string= (buffer-local-value 'default-directory (current-buffer))
                     cwd)
      (insert "cd " cwd)
      (eshell-send-input)
      )
  ))

;;;; ==== MY CUSTOM KEYBINDINGS ====
(define-key (current-global-map) (kbd "C-c k") 'eshell-at-cwd)
(define-key (current-global-map) (kbd "C-c s") 'replace-string)
(define-key (current-global-map) (kbd "C-c a") 'align-regexp)
(define-key (current-global-map) (kbd "C-c r") 'rgrep)
(define-key (current-global-map) (kbd "C-;")   'other-window)
(define-key (current-global-map) (kbd "C-'")   'switch-to-buffer)

(define-key (current-global-map) (kbd "C-c n") 'mode-line-other-buffer)
(define-key (current-global-map) (kbd "C-c C-n") 'mode-line-other-buffer)

(define-key (current-global-map) (kbd "C-c o") 'delete-other-windows)
(define-key (current-global-map) (kbd "C-c C-o") 'delete-other-windows)

(define-key (current-global-map) (kbd "C-c l") 'project-compile)

;; Overwrite buffer-menu-other-window
(defun buffer-menu* ()
  (interactive)
  (buffer-menu)
  (next-line))
(define-key (current-global-map) (kbd "C-x C-b") 'buffer-menu*)

;;;; TODO
;; when entering image mode / document mode, disable line numbers mode

;;;; ==== JUMP TO SPECIAL BUFFER ====
(defvar *special-buffer* nil "A buffer that can be easily jumped to with C-z")
(defun switch-to-special-buffer ()
  "Switch to the *special-buffer* if not the current buffer, otherwise mode-line-other-buffer"
  (interactive)
  (if (eq *special-buffer* (current-buffer))
      (mode-line-other-buffer)
    (switch-to-buffer *special-buffer*)
    )
  )

(defun set-special-buffer ()
  (interactive)
  (message "set *special-buffer* to %s" (current-buffer))
  (setq *special-buffer* (current-buffer)))

(keymap-global-unset "C-z")
;; (define-key (current-global-map) (kbd "C-z") 'switch-to-special-buffer)
;; (define-key (current-global-map) (kbd "C-M-z") 'set-special-buffer)
(global-set-key (kbd "C-z") 'undo)


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
;; (setq-default truncate-lines t)

;;;; ==== SPACES INSTEAD OF TABS ====
(setq-default indent-tabs-mode nil
              tab-width 4)

;;;; ==== ALLOW TAB AUTOCOMPLETE ====
(setq tab-always-indent 'complete)

;;;; ==== SHOW COLUMN LIMIT ====
(setq-default fill-column 77) 
(global-display-fill-column-indicator-mode 1)

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
(recentf-mode 1)
;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
 
;;;; ==== DISABLE TOP BARS ====
(tool-bar-mode -1)

;;;; ==== DISABLE SCROLL BAR ====
(setq scroll-bar-mode nil)

;;;; ==== LINE NUMBERS ====
(global-display-line-numbers-mode)
(column-number-mode)

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
(unless use-emacs-server
  (toggle-frame-fullscreen))

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
;; (add-hook 'sly-mode-hook
;;           (lambda ()
;;             (unless (sly-connected-p)
;;               (save-excursion (sly)))))
(setq inferior-lisp-program "sbcl")

;;;; ==== SLIME ====
(setq slime-load-failed-fasl 'always)

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

;;;; ==== SET FONT SIZE ====
(set-face-attribute 'default nil :height 160)

;;;; ==== SET DEFUALT FONT TO TERMINUS ====
;;(set-frame-font "terminus")

;;;; ==== AUTOSTART ESHELL ====
(unless use-emacs-server
  (eshell))

;;;; ==== ALLOW UPCASE AND DOWNCASE ====
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;;; ==== MELPA ====
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;;;; ==== TCL CONFIG ====
(setq-default tcl-application "tclsh")

;;;; ==== DISABLE AUTO INDENTATION CHANGE ====
(electric-indent-mode -1)

;;;; ==== LITAC SYNTAX ====
(add-to-list 'auto-mode-alist '("\\.lita\\'" . c-mode))

;;;; ==== A FEW CUSTOM LISP KEYWORDS ====
(defvar *lisp-keywords*
  '(fn *let defclass/std class/std
       when-let if-let defstruct*
       defenum defield field defprocedure
       import))

(font-lock-add-keywords
 'lisp-mode
 `((,(regexp-opt
       (mapcar (lambda (kw)
                 (symbol-name kw))
               *lisp-keywords*)
       'symbols)
    0 font-lock-keyword-face))
 t)

;;;; ==== COPY PASTE ON MACOS ====
(defun darwin-yank ()
  (shell-command-to-string "pbpaste"))

(defun darwin-kill (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(when (string-equal system-type "darwin")
  (setq interprogram-cut-function 'darwin-kill)
  (setq interprogram-paste-function 'darwin-yank))



(setq treesit-language-source-alist
      '((c3 "https://github.com/c3lang/tree-sitter-c3")))
(add-to-list 'load-path "~/.dotfiles/emacs")
;; (load "~/.dotfiles/emacs/c3-ts-mode.el")
;;(require 'c3-ts-mode)


;; ORG MODE
(require 'org)
(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)
(set-face-attribute 'org-block nil
                    :inherit 'default)
(setq org-babel-default-header-args
      '((:results . "replace")
        (:exports . "both")))

;; ==== Some better bindings ====

(define-key (current-global-map) (kbd "M-o") 'other-window)

;; ===== From newcomer mode ======
(setopt delete-selection-mode t)
(setopt mode-line-compact 'long)
(setopt save-place-mode t)
(setopt dired-mouse-drag-files t)
(context-menu-mode)
(setopt mouse-drag-and-drop-region t)
(setopt mouse-drag-and-drop-region-cross-program t)
(setopt mouse-yank-at-point t)
(setopt package-autosuggest-mode t)
(setopt compilation-scroll-output 'first-error)
(setopt etags-regen-mode t)
(setopt vc-auto-revert-mode t)


