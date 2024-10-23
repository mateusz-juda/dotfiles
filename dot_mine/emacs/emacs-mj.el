;;(setq debug-on-error t)



;; something is wrong with tramp and bellow paths, ssh does not work
;; (setenv "PATH" (concat "/Library/TeX/texbin" (getenv "PATH")))
;; (setq exec-path (append '("/Library/TeX/texbin") exec-path))


(setq user-emacs-directory "~/configs/emacs/emacs.d")

;;(byte-recompile-directory (expand-file-name "~/configs/emacs/emacs.d") 0)

(add-to-list 'load-path "~/configs/emacs/")
(add-to-list 'load-path "~/configs/emacs/emacs.d/additional")

(require 'package)
(setq package-check-signature nil)
(setq package-archives '(
			 ("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ))

(setq package-user-dir "~/.emacs.mypackages.d")
(add-to-list 'load-path package-user-dir)

(package-initialize)

(setq package-selected-packages
      '(ccls use-package undo-tree string-inflection
	     smart-tab
	     lsp lsp-ui
	     projectile project markdown-preview-mode
	     helm-fuzzy helm-lsp helm-ls-lgit helm-projectile
	     flymake flx-ido danneskjold-theme company clang-format
	     xclip
	     ))
(package-install-selected-packages)

;;;
;;; emacs server
;;;
; https://www.gnu.org/software/emacs//draft/manual/html_node/emacs/TCP-Emacs-server.html
; http://andy.wordpress.com/2013/01/03/automatic-emacsclient/

;; TODO server-host should depends on running host (dns lookup for me-local.capdnet ??)
;; (setq server-use-tcp t)
;; (setq server-host "10.3.7.1")
;; (setq server-port "8090")
;; (setq server-auth-dir "~/tmp/emacsserver")
;;(load "server")
;;(unless (server-running-p) (server-start))

;;;;
;;; TAB
;;;;
(require 'smart-tab)
(global-smart-tab-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)


;;;; xclip
;;(require 'xclip)
;;(xclip-mode 1)


;;   (defun check-expansion ()
;;     (save-excursion
;;       (if (looking-at "\\_>") t
;;         (backward-char 1)
;;         (if (looking-at "\\.") t
;;           (backward-char 1)
;;           (if (looking-at "->") t nil)))))

;;   (defun do-yas-expand ()
;;     (let ((yas/fallback-behavior 'return-nil))
;;       (yas/expand)))

;;   (defun tab-indent-or-complete ()
;;     (interactive)
;;     (if (minibufferp)
;;         (minibuffer-complete)
;;       (if (or (not yas/minor-mode)
;;               (null (do-yas-expand)))
;;           (if (check-expansion)
;;               (company-complete-common)
;;             (indent-for-tab-command)))))

;; (global-set-key [tab] 'tab-indent-or-complete)



;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;
(require 'string-inflection)

;; default
(global-set-key (kbd "C-c C-u") 'string-inflection-all-cycle)

;; for ruby
(add-hook 'ruby-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-ruby-style-cycle)))

;; for java
(add-hook 'java-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-java-style-cycle)))

;; for python
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-python-style-cycle)))

;; for c++
(add-hook 'c++-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-u") 'string-inflection-java-style-cycle)))

;;;;;;;;;;;
;;;;;;;;;;;


;;(require 'drag-stuff)
;;(drag-stuff-global-mode t)
;;(drag-stuff-define-keys)

;;;;;;;;;;;;;
;;;;;;;;;;;;

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)


;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
(setq inhibit-startup-echo-area-message "guerry")

;; This is bound to f11 in Emacs
;(toggle-frame-fullscreen)
;; Who use the bar to scroll?
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

;;(desktop-save-mode 1)

(global-set-key "\C-cn" 'make-frame)
(global-set-key "\C-ck" 'delete-frame)

(defalias 'yes-or-no-p 'y-or-n-p)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(windmove-default-keybindings 'meta)
(global-set-key "\M-`" 'other-frame)
;; does not work with ipython ein beacsue of bug (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'c-mode-hook
;;           (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; (add-hook 'python-mode-hook
;;           (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; (require 'ipython)


;;;;
;;;;   Frame
;;;;
;; (require 'framemove)
;; ;;(framemove-default-keybindings)
;; (global-set-key (kbd "C-c <left>")  'windmove-left)
;; (global-set-key (kbd "C-c <right>") 'windmove-right)
;; (global-set-key (kbd "C-c <up>")    'windmove-up)
;; (global-set-key (kbd "C-c <down>")  'windmove-down)
;; (windmove-default-keybindings)
;; (setq framemove-hook-into-windmove t)

(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)




(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$|.+~$"))


(require 'helm)
(require 'helm-config)
(require 'helm-files)
(require 'helm-ls-git)
(setq helm-M-x-fuzzy-match t)
(setq helm-mode-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)
(helm-mode 1)

;;(require 'helm-fuzzy)
;;(with-eval-after-load 'helm
 ;; (helm-fuzzy-mode 1))

(setq completion-styles `(basic partial-completion emacs22 initials
                                ,(if (version<= emacs-version "27.0") 'helm-flex 'flex)))
(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-c f") 'helm-for-files)
(global-set-key (kbd "M-x") 'helm-M-x)


;;;;;;
;;;;;;
;;;;;;


(require 'clang-format)
;; convert yaml file to one line
;; python -c 'import yaml,json,sys; doc=yaml.load(sys.stdin, Loader=yaml.FullLoader); print(json.dumps(doc));' < ~/work/dmg-nfdc/LS3/.clang-format

(if (file-exists-p "~/work/dmg-nfdc/clang-format.emacs")
(setq-default clang-format-style
       ;;"file" - doesno work with trump because (buffer-file-name) is with /ssh:
       (with-temp-buffer
         (insert-file-contents "~/work/dmg-nfdc/clang-format.emacs")
         (buffer-string)
         )
       )
)

(global-set-key (kbd "C-c m f") 'clang-format-buffer)

;;(setq c++-mode-hook nil)
;; (add-hook 'c++-mode-hook
;;           (lambda () (add-hook 'after-save-hook
;;                                (lambda () (interactive)
;;                                  (if (string-match "\\(h\\|hpp\\|hxx\\|c\\|cpp\\|cxx\\)$" (buffer-file-name))
;;                                      (progn
;;                                        (clang-format-buffer)
;;                                        (print "clang done")
;;                                        (if (buffer-modified-p)
;;                                            (if (y-or-n-p-with-timeout "Do you want to save after clang-format?" 1 t)
;;                                                (progn
;;                                                  (save-buffer)
;;                                                  (print "Buffer saved"))
;;                                              (progn
;;                                                (revert-buffer nil t)
;;                                                (print "Buffer reverted"))
;;                                              )
;;                                          (print "Buffer not modified")
;;                                          )
;;                                        )
;;                                    ))
;;                                  nil 'local)))


(add-to-list 'load-path "~/configs/emacs/s.el")
(add-to-list 'load-path "~/configs/emacs/projectile")
(require 'projectile)
(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-enable-caching t)

(projectile-global-mode)

;;(setq projectile-switch-project-action 'projectile-dired)
;;(setq projectile-switch-project-action 'projectile-find-file)

;; MJ failback bugfix for eglot
;; (defun project-root (project)
;;   (car (project-roots project)))
;; (require 'eglot)
;; ;;(add-to-list 'eglot-server-programs '((c++-mode c-mode)  "127.0.0.1:8001"))
;; (add-to-list 'eglot-server-programs '((c++-mode c-mode)  "~/configs/bin/ccls_wrap"))

;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
(setq lsp-idle-delay 1.500)
(setq lsp-enable-file-watchers nil)
(setq lsp-enable-symbol-highlighting t)
(setq lsp-ui-doc-enable nil)
(setq lsp-lens-enable nil)
(setq lsp-ui-sideline-enable nil)
(setq lsp-ui-sideline-enable nil)
(setq lsp-modeline-code-actions-enable nil)
(setq lsp-diagnostics-provider :none)
(setq lsp-ui-sideline-enable nil)
(setq lsp-modeline-diagnostics-enable nil)
(setq lsp-completion-show-kind nil)

(use-package lsp-ui)
(use-package lsp-mode
  :commands lsp
  :config
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'lsp)

;;  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log-error"))
  )

;;(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)
;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))
(setq ccls-executable "ccls_wrap")


(setq projectile-known-projects '())
(projectile-add-known-project "~/configs/emacs/")


(setq explicit-shell-file-name "/bin/bash")

(setq projectile-file-exists-remote-cache-expire nil)

(global-set-key (kbd "C-c s")
#'(lambda () (interactive)
                (let (
                      (shell-file-name "/bin/bash")
                      )
                  (projectile-switch-project)
                  )))




(require 'whitespace)
(setq-default show-trailing-whitespace t)
; ;;(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
;;(global-whitespace-mode 1)



(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups






;(add-to-list 'custom-theme-load-path "~/Dropbox/configs/emacs/zenburn-emacs")
;(load-theme 'zenburn t)
;;(add-to-list 'load-path "~/Dropbox/configs/emacs/zenburn-emacs/")
;;(require 'zenbrun)
;;(zenbrun)

;;;(load-theme 'hc-zenburn t)
(load-theme 'danneskjold t)

;(require 'yasnippet)
;(yas-global-mode 1)

;(global-set-key (kbd "C-i") 'yas/expand) ;; doesn't work
;(setq yas/also-auto-indent-first-line t)

;; (require 'semantic/ia)
;; (require 'semantic/bovine/gcc)
;; (if (not (file-exists-p "~/.semanticdb")) (make-directory
;;                                            "~/.semanticdb"))
;; (setq semanticdb-default-save-directory (expand-file-name
;;                                          "~/.semanticdb/project"))
;; (setq semanticdb-default-system-save-directory (expand-file-name
;;                                                 "~/.semanticdb/system"))
;; (semantic-mode 1)

;; (setq capd-config-cflags (shell-command-to-string "$HOME/work/capd/bin/capd-config --cflags"))
;; (setq capd-config-include-path (split-string (replace-regexp-in-string
;; 					      "-I\\(\\(\\w\\|[./]\\)*\\)" "\\1"
;; 					      (replace-regexp-in-string "-[^I]\\(\\w\\|-\\|_\\)*" "" capd-config-cflags))))

;; (dolist (path capd-config-include-path)
;;   (semantic-add-system-include path 'c++-mode)
;;   (semantic-add-system-include path 'c-mode)
;; )


;; (add-to-list 'load-path "~/Dropbox/configs/emacs/auto-complete")
;; (add-to-list 'load-path "~/Dropbox/configs/emacs/auto-complete/lib/ert")
;; (add-to-list 'load-path "~/Dropbox/configs/emacs/auto-complete/lib/fuzzy")
;; (add-to-list 'load-path "~/Dropbox/configs/emacs/auto-complete/lib/emacs-mjpopup")
;; (add-to-list 'load-path "~/Dropbox/configs/emacs/auto-complete-clang")
;; (require 'auto-complete-config)
;; (require 'auto-complete-clang)


;; (add-to-list 'ac-dictionary-directories "~/Dropbox/configs/emacs/dict")

;; (global-auto-complete-mode t)
;; (setq ac-auto-start 2)
;; (setq ac-dwim t)                        ;Do what i mean
;; (setq ac-override-local-map nil)        ;don't override local map
;; (setq ac-use-fuzzy t)
;; (ac-set-trigger-key "TAB")
;; (setq ac-auto-start nil)

;; (custom-set-variables
;;  '(ac-sources
;;    '(
;;      ac-source-semantic
;;      ac-source-gtags
;;      ac-source-imenu
;;      ac-source-abbrev
;;      ac-source-words-in-buffer
;;      ac-source-files-in-current-dir
;;      ac-source-filename
;;      ;; ac-freq-word
;;      )))


;; (defun my-ac-cc-mode-setup ()
;;   (add-to-list 'ac-user-dictionary '("and" "bool" "compl" "do" "export" "goto" "namespace" "or_eq" "return"
;;    "struct" "try" "using" "xor" "and_eq" "break" "const" "double" "extern"
;;    "if" "new" "private" "short" "switch" "typedef" "virtual" "xor_eq" "asm"
;;    "case" "const_cast" "dynamic_cast" "false" "inline" "not" "protected"
;;    "signed" "template" "typeid" "void" "auto" "catch" "continue" "else"
;;    "float" "int" "not_eq" "public" "sizeof" "this" "typename" "volatile"
;;    "bitand" "char" "default" "enum" "for" "long" "operator" "register"
;;    "static" "throw" "union" "wchar_t" "bitor" "class" "delete" "explicit"
;;    "friend" "mutable" "or" "reinterpret_cast" "static_cast" "true"
;;    "unsigned" "while"))
;;   (setq ac-sources (append '(ac-source-clang
;;                              ac-source-yasnippet
;;                              ) ac-sources)))

;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ;;(ac-config-default) ;; yasnipset probelms !!!!
;; (setq ac-clang-flags "")
;; (setq ac-clang-flags
;;       (mapcar (lambda (item)(concat "-I" item))
;; 	      capd-config-include-path
;;                ))


;; (setq ac-use-menu-map t)
;; (define-key ac-menu-map "\C-n" 'ac-next)
;; (define-key ac-menu-map "\C-p" 'ac-previous)


;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "TAB") 'company-select-next)
;;      (define-key company-active-map [tab] 'company-select-next)))
;; (setq company-selection t) <-- this doesn't make sense -- Dmitry


(require 'company)
(setq company-idle-delay 0)
(add-hook 'after-init-hook 'global-company-mode)
(push 'company-rtags company-backends)
;;(setq company-backends (delete 'company-semantic company-backends))
(global-company-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq company-backends '((
                                      company-yasnippet
                                      company-files ;;
                                      company-dabbrev-code
                                      company-rtags
                                      company-keywords)
                                     company-dabbrev))))




;; Do we need it?
;;(require 'member-function)
;;(setq mf--source-file-extension "cpp")

;; (require 'color)

;; (let ((bg (face-attribute 'default :background)))
;;   (custom-set-faces
;;    '(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;;    '(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;    '(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;    '(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;    '(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

(column-number-mode)
(setq fill-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;;----------------------------------------------------------------------------
;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
;;----------------------------------------------------------------------------
;(setq tab-always-indent 'complete) ;; use 't when auto-complete is disabled
;;(add-to-list 'completion-styles 'initials t)

;; hook AC into completion-at-point
;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (setq completion-at-point-functions '(auto-complete)))
;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)




(setq locale-coding-system 'iso-8859-2)
(set-terminal-coding-system 'iso-8859-2)
(set-keyboard-coding-system 'iso-8859-2)
(set-selection-coding-system 'iso-8859-2)
(prefer-coding-system 'iso-8859-2)

;;(add-hook 'LaTeX-mode-hook 'flyspell-mode)

(setq-default ispell-program-name "aspell")

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)


(autoload 'dirtree "dirtree" "Add directory to tree view" t)


;; Helm in conflict with ido
;; (require 'ido)
;; (require 'flx-ido)
;; (setq ido-enable-flex-matching t)
;; (flx-ido-mode 1)
;; (ido-everywhere 1)
;; (setq ido-use-faces nil)
;; (setq ido-use-filename-at-point 'nil)
;; (setq ido-file-extensions-order '("/" ".cpp" ".h" ".hpp" ".c" ".am" ".ac"))
;; (setq ido-ignore-extensions t)
;; (setq completion-ignored-extensions
;;      (append completion-ignored-extensions '("~" ".o" ".la" ".lo" ".log" ".lock" ".a")))
;; (ido-mode t)




;; ;;;
;; ;;; Hacks from http://www.emacswiki.org/emacs/InteractivelyDoThings
;; ;;;


;; ;; Display ido results vertically, rather than horizontally
;;   (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;;   (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;;   (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
;;   (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
;;     (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
;;     (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
;;   (add-hook 'ido-setup-hook 'ido-define-keys)



  (require 'bookmark)
  (setq enable-recursive-minibuffers t)
;;  (define-key ido-file-dir-completion-map [(meta control ?b)] 'ido-goto-bookmark)
  ;; (defun ido-goto-bookmark (bookmark)
  ;;   (interactive
  ;;    (list (bookmark-completing-read "Jump to bookmark"
  ;;     				   bookmark-current-bookmark)))
  ;;   (unless bookmark
  ;;     (error "No bookmark specified"))
  ;;   (let ((filename (bookmark-get-filename bookmark)))
  ;;     (if (file-directory-p filename)
  ;; 	(progn
  ;; 	  (ido-set-current-directory filename)
  ;; 	  (setq ido-text ""))
  ;;       (progn
  ;; 	(ido-set-current-directory (file-name-directory filename))))
  ;;     (setq ido-exit        'refresh
  ;; 	  ido-text-init   ido-text
  ;; 	  ido-rotate-temp t)
  ;;     (exit-minibuffer)))


;;;
;;;
;;;
;;;





(require 'ibuffer)
(setq ibuffer-saved-filter-groups
  (quote (("default"
            ("capdRedHom-include"
              (filename . "/capdRedHom.*/include"))
            ("capdRedHom-src"
              (filename . "/capdRedHom.*/src"))
            ("capdRedHom-tests"
              (filename . "/capdRedHom.*/tests"))
            ("capdRedHom-programs"
              (filename . "/capdRedHom.*/programs"))
            ("capdRedHom"
              (filename . "/capdRedHom.*/"))
            ("capdExt"
              (filename . "/capdExt/"))
            ("capdDynSys"
              (filename . "/capdDynSys/"))
            ("capd"
              (filename . "/capd/"))
            ("Programming" ;; prog stuff not already in MyProjectX
              (or
                (mode . c-mode)
                (mode . c++-mode)
                (mode . perl-mode)
                (mode . python-mode)
                (mode . ruby-mode)
                (mode . emacs-lisp-mode)
                ;; etc
                ))
            ("ERC"   (mode . erc-mode))))))

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 40 40 :left )
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              filename-and-process)))

(add-hook 'ibuffer-mode-hook
  (lambda ()
    (ibuffer-switch-to-saved-filter-groups "default")))

(defun my-ibuffer ()
  "Open ibuffer with cursour pointed to most recent buffer name"
  (interactive)
  (let ((recent-buffer-name (buffer-name)))
    (ibuffer)
    (ibuffer-jump-to-buffer recent-buffer-name)))

(global-set-key (kbd "C-x C-b") 'my-ibuffer)



;(add-to-list 'load-path "~/Dropbox/configs/emacs/eproject")
;(require 'eproject)
;(require 'eprojecT-extras)



;;(add-to-list 'load-path "~/configs/emacs/template/lisp")
;;(require 'template)
;;(template-initialize)
;(add-to-list 'template-find-file-commands
;	     '(insert )do-exit-minibuffer)
;;(global-set-key "\C-ct" 'template-new-file)




;;(require 'ack-and-a-half)
;; Create shorter aliases
;;(defalias 'ack 'ack-and-a-half)
;;(defalias 'ack-same 'ack-and-a-half-same)
;;(defalias 'ack-find-file 'ack-and-a-half-find-file)
;;(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)



;(require 'bookmark+)
;(setq bookmark-default-file  "~/configs/emacs/bookmarks-mj.bkm")
;(bookmark-load bookmark-default-file t)


;;;;
;;;; Org
;;;;
;;(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-x oa" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done t)
(setq org-startup-truncated nil)
(setq org-agenda-files (list "~/Dropbox/Org/work.org"
                             "~/Dropbox/Org/home.org"))
(setq org-default-notes-file "~/Dropbox/Org/notes.org")


(setq org-latex-pdf-process (quote ("texi2dvi --pdf --clean --verbose
--batch %f" "bibtex %b" "texi2dvi --pdf --clean --verbose --batch %f"
"texi2dvi --pdf --clean --verbose --batch %f")))

;;;;
;;;; LaTex
;;;;
;; (latex-preview-pane-enable)

;;;;

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 30)
(setq recentf-max-saved-items 1000)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
;;(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key "\C-x\ \C-r" 'recentf-ido-find-file)
(run-at-time (current-time) 300 'recentf-save-list)


;;;;;
;;;;Undo tree
;;;;;

(global-undo-tree-mode)
(setq undo-tree-visualizer-diff t)
(setq undo-tree-visualizer-timestamps t)
(global-set-key "\C-x\ U" 'undo) ;; old undo

;;;
;;; Copy/Pase
;;;
(global-set-key "\C-x\ \C-y" 'helm-show-kill-ring)


;(setq tramp-default-proxies-alist '())

(setq tramp-default-method "ssh")
; (add-to-list 'tramp-default-proxies-alist
; ;;		       '("mnich-capd" "\\`capd\\'" "/ssh:mnich:")
;                       '(nil "\\`root\\'" "/ssh:%h:")
;		       )
;          (add-to-list 'tramp-default-proxies-alist
;                       '((regexp-quote (system-name)) nil nil))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-default-file-method (quote selected-window)))

;; http://cillian.wordpress.com/2012/04/11/emacs-23-tramp-sudo-to-another-username-on-a-remote-machine/
;; (defconst my-mode-line-buffer-identification
;; (list '(:eval
;; 	(let ((host-name
;; 	       (or (file-remote-p default-directory 'host)
;; 		   (system-name))))
;; 	  (if (string-match "^[^0-9][^.]*\\(\\..*\\)" host-name)
;; 	      (substring host-name 0 (match-beginning 1))
;; 	    host-name)))
;;       ": %12b"))

;; (setq-default mode-line-buffer-identification my-mode-line-buffer-identification)
;; (add-hook 'dired-mode-hook '(lambda ()
;; 			      (setq mode-line-buffer-identification my-mode-line-buffer-identification)))






(setq ediff-diff-options "-w")
(setq-default ediff-ignore-similar-regions t)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; (if (locate-library "ediff")
;;     (progn
;;       (autoload 'ediff-files "ediff")
;;       (autoload 'ediff-buffers "ediff")

;;        (eval-after-load "ediff" '(progn
;;   			  (message "doing ediff customisation")
;; 			  (setq
;; 			   diff-switches               "-u"
;; 			   ediff-diff-options "-w"

;; 			   ediff-custom-diff-options   "-U3"
;; 				ediff-split-window-function 'split-window-horizontally
;; 				ediff-window-setup-function 'ediff-setup-windows-plain)

;; 			  ;;(add-hook 'ediff-startup-hook 'fit-frame)
;; 			  ;;(add-hook 'ediff-cleanup-hook 'fit-frame)
;; 			  ;;(add-hook 'ediff-suspend-hook 'fit-frame)
;; 			  ))))


(setq save-place-file "~/.emacs.d/saveplace")
(save-place-mode 1)
;(setq-default save-place t)
;(require 'saveplace)




(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new (file-name-base filename))
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(global-set-key "\C-cx" 'copy-file-name-to-clipboard)




;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;
;;;;;  my tools
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;


(defun tmpbuf (buf)
  "open a buffer, if it doesn't exist, open a new one"
  (interactive "sBuffer name: ")
  (switch-to-buffer
   (get-buffer-create (concat "*" buf "*"))))




(defun find-next-unsafe-char (&optional coding-system)
  "Find the next character in the buffer that cannot be encoded by
coding-system. If coding-system is unspecified, default to the coding
system that would be used to save this buffer. With prefix argument,
prompt the user for a coding system."
  (interactive "Zcoding-system: ")
  (if (stringp coding-system) (setq coding-system (intern coding-system)))
  (if coding-system nil
    (setq coding-system
          (or save-buffer-coding-system buffer-file-coding-system)))
  (let ((found nil) (char nil) (csets nil) (safe nil))
    (setq safe (coding-system-get coding-system 'safe-chars))
    ;; some systems merely specify the charsets as ones they can encode:
    (setq csets (coding-system-get coding-system 'safe-charsets))
    (save-excursion
      ;;(message "zoom to <")
      (let ((end  (point-max))
            (here (point    ))
            (char  nil))
        (while (and (< here end) (not found))
          (setq char (char-after here))
          (if (or (eq safe t)
                  (< char ?\177)
                  (and safe  (aref safe char))
                  (and csets (memq (char-charset char) csets)))
              nil ;; safe char, noop
            (setq found (cons here char)))
          (setq here (1+ here))) ))
    (and found (goto-char (1+ (car found))))
    found))





;; (require 'ein)

;; (setq mj-ein-urls '("http://rysy-mvf.capdnet:8888" "http://localhost:8888"  "http://localhost:8889" "http://10.3.8.126:8888" "http://10.3.8.126:8889"))
;; (setq ein:filename-translations
;;       (lambda (url-or-port)
;;         (when (equal url-or-port 8888)
;;           (ein:tramp-create-filename-translator mj-ein-urls))))
;; (setq ein:url-or-port mj-ein-urls)
;; (setq ein:default-url-or-port  "http://rysy-mvf.capdnet:8888")


;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;
;;;;;  CAPD
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;


(defun capd-home-path ()
  (let ( (capd-home "~/work/capd/") )
    (if (ignore-errors (tramp-file-name-p (tramp-dissect-file-name default-directory)))
        (let ( (vec (tramp-dissect-file-name default-directory)))
          (tramp-make-tramp-file-name
           (tramp-file-name-method vec)
           (tramp-file-name-user vec)
           (tramp-file-name-host vec)
           capd-home ))
      capd-home )
    )
  )

(defun capd-projects (capd-work)
  (mapcar (lambda (item) (concat capd-work "/" item))
          (list
           ;;"capdDynSys4"
           "capdRedHom"
           "capdRedHom_modules_unofficial"
           ;;"./")
          )
          )
  )

(defun capd-projects-path ()
  (capd-projects (capd-home-path))
  )

(global-set-key (kbd "C-c j")
                #'(lambda () (interactive)
                    (let (
                          (shell-file-name "/bin/bash")
                          (projectile-known-projects (capd-projects-path))
                          )
                      (projectile-find-file-in-known-projects)
                    )))

(global-set-key (kbd "C-c J")
                #'(lambda () (interactive)
                    (let (
                          (shell-file-name "/bin/bash")
                          )
                      (helm-projectile)
                      )))


(defun capd-packages ()
  '("capdRedHom" "capdRedHom_modules_unofficial" "capdAlg" "capdAux" "capdDynSys" "capdDynSys4" "capdExt" "capdExtHom" "capdMake")
)

(defun capd-modules (package)
  (let (
        (dir nil)
        )

    (setq dir (concat (capd-home-path) "/" package "/include/capd"))
    (if (file-directory-p dir)
        (progn
          (setq modules (remove-if-not (lambda (file) (and (not (string= file "."))
                                                           (not (string= file ".."))
                                                           (file-directory-p (concat dir "/" file))
                                                           )
                                         )
                                       (directory-files dir)
                                       ))
          (sort modules 'string<)
          )
      ()
      )
    )
  )

(defun capd-modules-all ()
  (sort
   (apply 'append
	  (mapcar
	   (lambda (package)
	     (capd-modules package))
	   (capd-packages))
	   )
   'string<)
  )

(defun capd-known-files ()
  (let ((projectile-require-project-root nil)
        (all-files nil)
        (projectile-known-projects (capd-projects-path)))
    (mapcar
      (lambda (project)
        (let ((default-directory project))
          (setq all-files (append all-files (mapcar (lambda (file)
                                                    (expand-file-name file project))
                                                    (projectile-current-project-files))))))
      projectile-known-projects
      )
    all-files)
  )

(defun capd-headers ()
  (mapcar (lambda (file)
	    (string-match ".*/include/\\(capd/.*\\.\\(h\\|hpp\\|hxx\\)\\)$" file)
	    (match-string 1 file))
	  (remove-if-not (lambda (file)
			   (string-match ".*/include/\\(capd/.*\\.\\(h\\|hpp\\|hxx\\)\\)$" file))
			 (capd-known-files)))
  )


(defun capd-file-package (filename)
  (let* (
         (matched (string-match ".*/\\(capdRedHom\\|capdRedHom_modules_unofficial\\|capdAlg\\|capdAux\\|capdDynSys\\|capdDynSys4\\|capdExt\\|capdExtHom\\|capdMake\\)/.*" filename))
         )
    (if matched
        (match-string 1 filename)
      (error (format "No CAPD file %s, cannot match package" filename))
      )
    )
)

(defun capd-file-module (filename)
  (let* (
         (capd-package (capd-file-package filename))
         (matched (string-match (format "%s\\(/include/capd/\\(.*\\)/\\)" capd-package)  filename))
         )
    (if matched
        (match-string 2 filename)
      (cond
       ((string-match (format "%s\\(/src/\\(mp\\)?capd/\\(.*\\)/\\)" capd-package)  filename)
        (match-string 3 filename))
       ((string-match (format "%s/tests/\\(.*\\)/.*" capd-package)  filename)
        (match-string 1 filename))
       ((string-match (format "%s/\\(example\\|program\\)s/.*" capd-package)  filename)
        (match-string 1 filename))
       (t
        (error (format "No CAPD file %s, cannot match module" filename)))
       )
      )
    )
)

(defun capd-file-class (filename)
  (let* (
         (filename-base (file-name-base filename))
         )
    (if (string-match "^\\(.*\\)Test$" filename-base)
         (setq filename-base (match-string 1 filename-base))
      )
    filename-base)
  )



(defun capd-file-type (filename)
  (let* (
         (extension (file-name-extension filename))
         (capd-package (capd-file-package filename))
         )
    (cond
     ((string-match (format "%s/include/.*" capd-package)  filename)
      (if (string= "h" extension)
          'header
        'header-impl))
     ((string-match (format "%s/src/.*" capd-package)  filename)
      'impl)
     ((string-match (format "%s/tests/.*Test\\.cpp" capd-package)  filename)
      'test)
     ((string-match (format "%s/tests/.*TestMain\\.cpp" capd-package)  filename)
      'test-main)
     ((string-match (format "%s/\\(examples\\|programs\\|tests\\)/.*\\.cpp" capd-package)  filename)
      'bin-cpp)
     ((string-match (format "%s/\\(examples\\|programs\\|tests\\)/.*\\.h" capd-package)  filename)
      'bin-header)
     ((string-match (format "%s/\\(examples\\|programs\\|tests\\)/.*\\.hpp" capd-package)  filename)
      'bin-header-impl)
     (t
      (error (format "Cannot match file type for %s" filename)))
     )
    )
)


(defun capd-file-switch (filename file-type)
  (let* (
         (capd-class (capd-file-class filename))
         (capd-package (capd-file-package filename))
         (capd-module (capd-file-module filename))
         )
    (string-match (format "\\(.*/%s\\)/" capd-package)  filename)
    (let* (
           (capd-package-path (match-string 1 filename))
           )

      (cond
       ((eq file-type 'header)
        (format "%s/include/capd/%s/%s.h" capd-package-path capd-module capd-class))
       ((eq file-type 'header-impl)
        (format "%s/include/capd/%s/%s.hpp" capd-package-path capd-module capd-class))
       ((eq file-type 'impl)
        (format "%s/src/capd/%s/%s.cpp" capd-package-path capd-module capd-class))
       ((eq file-type 'instantation)
        (format "%s/src/capd/%s/%s" capd-package-path capd-module capd-class))
       ((eq file-type 'test)
        (format "%s/tests/%s/%sTest.cpp" capd-package-path capd-module capd-class))
       ((eq file-type 'test-main)
        (format "%s/tests/%s/%sTestMain.cpp" capd-package-path capd-module capd-module))
       (t
        (error (format "Cannot switch for %s (%s)" file-type filename)))
       )
      )
    )
)


;;(setq template-expansion-alist ())
(add-to-list 'template-expansion-alist
	     '("CAPD-FILE" (insert (format "%s" (file-name-base (buffer-file-name))))))
(add-to-list 'template-expansion-alist
	     '("CAPD-PACKAGE" (insert (format "%s" (capd-file-package (buffer-file-name))))))
(add-to-list 'template-expansion-alist
	     '("CAPD-MODULE" (insert (format "%s" (capd-file-module (buffer-file-name))))))
(add-to-list 'template-expansion-alist
	     '("CAPD-CLASS" (insert (format "%s" (capd-file-class (buffer-file-name))))))
(add-to-list 'template-expansion-alist
             '("CAPD-FILE-GUARD" (insert (upcase
                                                  (format "CAPD_FILE_%s_%s_%s" (capd-file-package (buffer-file-name))
                                                         (capd-file-module (buffer-file-name))
                                                         (capd-file-class (buffer-file-name))))
                                         )))


;;(format "%s" template-expansion-alist)

(defun capd-select-template (filename)
  (let* (
         (file-type (capd-file-type filename))
         )
    (cond
     ((eq file-type 'header)
      "~/.templates/CAPD-TEMPLATE.h.tpl")
     ((eq file-type 'header-impl)
      "~/.templates/CAPD-TEMPLATE.hpp.tpl")
     ((eq file-type 'impl)
      "~/.templates/CAPD-TEMPLATE.cpp.tpl")
     ((eq file-type 'test)
      "~/.templates/CAPDTest-TEMPLATE.cpp.tpl")
     ((eq file-type 'test-main)
      "~/.templates/CAPDTestMain-TEMPLATE.cpp.tpl")
     ((eq file-type 'bin-cpp)
      "~/.templates/CAPD-TEMPLATE.cpp.tpl")
     ((eq file-type 'bin-header)
      "~/.templates/CAPD-TEMPLATE.h.tpl")
     ((eq file-type 'bin-header-impl)
      "~/.templates/CAPD-TEMPLATE.hpp.tpl")
     ((t)
      (error (format "Cannot match template for %s (%s)" file-type filename)))
     )
    )
)


(defun capd-add-file (class-name)
  "Switch between CAPD header/implementation/tests files"
  (interactive "MClass name: ")

  (let* (
         (curr-package (capd-file-package (buffer-file-name)))
         (curr-module (capd-file-module (buffer-file-name)))
         (package (ido-completing-read
                   "Select package: "
                   (capd-packages)
                   nil t curr-package ))
         (module (ido-completing-read
                  "Select module: "
                  (capd-modules package)
                  nil t curr-module))
         (filename (concat (capd-home-path) "" package "/include/capd/" module "/" class-name ".h"))
         )
    (if (file-exists-p filename)
        (find-file filename)
      (progn
        ;;(write-region "" nil filename nil t nil t)
        (find-file filename)
        (template-new-file nil (capd-select-template filename))
        (set-buffer-modified-p t)
        )
      )
    )
)


(defun capd-switch (frame)
  "Switch between CAPD header/implementation/tests files"
  (interactive)
  (let* ( (file-type (intern (ido-completing-read
                              "Complete a file type: "
                              '("header" "header-impl" "impl" "test" "test-main")
                              nil t )))

          (filename (capd-file-switch (buffer-file-name) file-type))
          )

    (other-window frame) ;; so when we split emacs frame, then we have them in one next to the other

    (if (file-exists-p filename)
        (find-file filename)
      (progn
      ;;(write-region "" nil filename nil t nil t)
        (find-file filename)
        (template-new-file nil (capd-select-template filename))
        (set-buffer-modified-p t)
        )
      )
  )
)


(defun capd-generate-instantanations ()
  ""
  (interactive)
  (let* (
        (capd-class (capd-file-class (buffer-file-name)))
        (capd-package (capd-file-package (buffer-file-name)))
        (capd-module (capd-file-module (buffer-file-name)))

        (filename-base (concat (capd-file-switch (buffer-file-name) 'instantation)))
        (valid_types '("CubicalComplexes" "SimplicialComplexes" "GeneralizedComplexes" "ProdSimplicialComplexes"))
        (types_selected (ido-completing-read
                "Complete types: "
                (append '("all") valid_types)
                ))
        (splits (string-to-number (ido-completing-read
                 "Complete number of splits: "
                 '("5")
                 )))
        (types_list (if (string= "all" types_selected)
                   valid_types
                 (list types_selected)))
        )
    (mapcan (lambda (types)
              (mapcan (lambda (split)
                        (let (
                              (template-expansion-alist template-expansion-alist)
                              (filename (concat filename-base "_" types "_" (number-to-string split) ".cpp"))
                              )
                          (add-to-list 'template-expansion-alist
                                       '("CAPD-CLASS" (insert capd-class)))
                          (add-to-list 'template-expansion-alist
                                       '("CAPD-MODULE" (insert capd-module)))
                          (add-to-list 'template-expansion-alist
                                       '("CAPD-TYPES" (insert types)))
                          (add-to-list 'template-expansion-alist
                                       '("CAPD-TYPES-SPLITS" (insert (number-to-string splits))))
                          (add-to-list 'template-expansion-alist
                                       '("CAPD-TYPES-SPLIT" (insert (number-to-string split))))

                          (other-frame 0)

                          (if (file-exists-p filename)
                              ()
                            ;;(message (concat "Exists: " filename))
                            (progn
                              ;;(write-region "" nil filename nil t nil t)
                              (find-file filename)
                              (template-new-file nil "~/.templates/CAPDInstances-TEMPLATE.cpp.tpl")
                              (set-buffer-modified-p t)
                              (save-buffer)
                              )
                            )

                          )
                        )
                      (number-sequence 0 splits)
                      )
              )
            types_list)
    )
  )

(defun capd-insert-previous-class-name ()
  ""
  (interactive)
  (insert (capd-file-class (buffer-name (car (car (window-prev-buffers))))))
  )


(defun capd-insert-class-name ()
  ""
  (interactive)
  (insert (capd-file-class (buffer-name (current-buffer))))
  )


(defun capd-default-h-files ()
  (sort
   (apply 'append (mapcar (lambda (boost-path)
                            (if (file-exists-p boost-path)
                               (let ((default-directory boost-path))
                                 (apply 'append (mapcar (lambda (p)(file-expand-wildcards p))
                                                        '("boost/*/*.hpp" "boost/*.hpp"
                                                          "boost/range/algorithm*/*.hpp"
                                                          "boost/algorithm/*/*.hpp"
                                                          "boost/range/adaptor/*.hpp"
                                                          "boost/numeric/*/*.hpp"
                                                          "boost/accumulators/*.hpp"
                                                          "boost/accumulators/statistics/*.hpp"
                                                          "*.h" "*/*.h"
                                                          )
                                                        ))
                                 )
                               ))
            '("/usr/local/include" "/usr/include")))
  'string<)
)

(setq capd-default-h-files-cache (capd-default-h-files))

(defun capd-add-include ()
  (interactive)

  (let* (
         (file-list (apply 'append
                           (list
                            (capd-headers)
                            capd-default-h-files-cache
                            '(
                              "array"
                              "cassert"
                              "map"
                              "vector"
                              "algorithm"
                              "utility"
                              "sstream"
                              "string"
                              "iostream"
                              "iterator"
                              "fstream"
                              "iosfwd"
                              "deque"
                              "queue"
                              "list"
                              "limits"
                              "numeric"
                              "cstring"
                              "cmath"
                              "stdio.h"
                              "unistd.h"
                              "exception"
                              "stdexcept"
                              "functional"
                              "type_traits"
                              "unordered_set"
                              "unordered_map"
                              )
                            ))
                    )
         (file (ido-completing-read
                "Complete a file type: "
                file-list
                nil t ))
         )
    (with-current-buffer (current-buffer)
      (save-excursion
        (goto-char (point-max))
        (if (search-backward "#include" nil t)
            ()
          (error "We nedd at least one #include directive in the file"))
        (end-of-line)
        (insert (format "\n#include <%s>" file))
        ))
    )
)


(global-set-key "\C-co" (lambda () (interactive) (capd-switch 0)))
(global-set-key "\C-cO" (lambda () (interactive) (capd-switch 1)))
(global-set-key "\C-ca" 'capd-add-file)
(global-set-key "\C-ci" 'capd-add-include)
(global-set-key "\C-cb" 'capd-insert-previous-class-name)
(global-set-key "\C-cc" 'capd-insert-class-name)






























;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;
;;;;;  C++ project
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;


(defun mj-cpp-home-path ()
  (let ( (mj-cpp-home "~/work/cts_projects") )
    (if (ignore-errors (tramp-file-name-p (tramp-dissect-file-name default-directory)))
        (let ( (vec (tramp-dissect-file-name default-directory)))
          (tramp-make-tramp-file-name
           (tramp-file-name-method vec)
           (tramp-file-name-user vec)
           ;;(tramp-file-name-domain vec)
           (tramp-file-name-host vec)
           ;;(tramp-file-name-port vec)
           mj-cpp-home ))
      mj-cpp-home )
    )
  )

(defun mj-cpp-project-path (project)
  (concat (mj-cpp-home-path) "/" project))

(defun mj-cpp-project-package-path (project package)
  (concat (mj-cpp-project-path project) "/src/" package))

(defun mj-cpp-project-package-module-path (project package module)
  (concat (mj-cpp-project-package-path project package) "/" module))

(defun mj-cpp-project-package-module-tests-path (project package module)
  (concat (mj-cpp-project-path project) "/tests/" package "/" module))


(defun mj-cpp-projects ()
  (list
   "capdCTS"
   )
  )

(defun mj-cpp-packages (project)
  (let (
        (dir (concat (mj-cpp-project-path project) "/src" ))
        )
  (remove-if-not
  (lambda (file) (and (not (string= file "."))
                      (not (string= file ".."))
                      (file-directory-p (concat dir "/" file))
                      )
    )
  (directory-files dir nil "capd.*")
  )
  )
  )

(defun mj-cpp-modules (project package)
  (let (
        (dir nil)
        )

    (setq dir (mj-cpp-project-package-path project package))
    (if (file-directory-p dir)
        (progn
          (setq modules (remove-if-not (lambda (file) (and (not (string= file "."))
                                                           (not (string= file ".."))
                                                           (file-directory-p (concat dir "/" file))
                                                           )
                                         )
                                       (directory-files dir)
                                       ))
          (sort modules 'string<)
          )
      ()
      )
    )
  )

(defun mj-cpp-projects-path ()
  (mapcar
   (lambda (project)
     (mj-cpp-project-path project))
   (mj-cpp-projects))
  )

(global-set-key (kbd "C-c j")
                #'(lambda () (interactive)
                    (let (
                          (shell-file-name "/bin/bash")
                          (projectile-known-projects (mj-cpp-projects-path))
                          )
                      (projectile-find-file-in-known-projects)
                    )))

(global-set-key (kbd "C-c J")
                #'(lambda () (interactive)
                    (let (
                          (shell-file-name "/bin/bash")
                          )
                      (helm-projectile)
                      )))



(defun mj-cpp-known-files ()
  (let ((projectile-require-project-root nil)
        (all-files nil)
        (projectile-known-projects (mj-cpp-projects-path)))
    (mapcar
      (lambda (project)
        (let ((default-directory project))
          (setq all-files (append all-files (mapcar (lambda (file)
                                                    (expand-file-name file project))
                                                    (projectile-current-project-files))))))
      projectile-known-projects
      )
    all-files)
  )

(defun mj-cpp-headers ()
  (mapcar (lambda (file)
	    (string-match ".*/capd[^/]*/\\(.*\\.\\(h\\|hpp\\|hxx\\)\\)$" file)
	    (match-string 1 file))
	  (remove-if-not (lambda (file)
			   (string-match ".*/capd[^/]*/\\(.*\\.\\(h\\|hpp\\|hxx\\)\\)$" file))
			 (mj-cpp-known-files)))
  )


(defun mj-cpp-file-project-package-module (filename)
  (let* (
         (matched (string-match "\\(.*/\\)*\\([^/]*\\)/\\(src\\|tests\\)/\\([^/]*\\)/\\([^/]*\\)/[^/]*$" filename))
         )
    (if matched
        (list (match-string 2 filename) (match-string 4 filename) (match-string 5 filename))
      (error (format "No CAPD file %s, cannot match package" filename))
      )
    )
)

(defun mj-cpp-file-project (filename)
  (nth 0 (mj-cpp-file-project-package-module filename))
)

(defun mj-cpp-file-package (filename)
  (nth 1 (mj-cpp-file-project-package-module filename))
)

(defun mj-cpp-file-module (filename)
  (nth 2 (mj-cpp-file-project-package-module filename))
)

(defun mj-cpp-file-basename (filename)
  (let* (
         (filename-base (file-name-base filename))
         )
    (if (string-match "^\\(.*\\)_test$" filename-base)
         (setq filename-base (match-string 1 filename-base))
      )
    (if (string-match "^\\(.*\\)_py$" filename-base)
         (setq filename-base (match-string 1 filename-base))
      )
   filename-base
  ))

(defun mj-cpp-file-class (filename)
  (let* (
         (filename-base (mj-cpp-file-basename filename))
         )
    (string-inflection-upper-camelcase-function filename-base))
  )


(defun mj-cpp-file-type (filename)
  (let* (
         (extension (file-name-extension filename))
         (mj-impl-path (format "%s/src/%s/%s" (mj-cpp-file-project filename) (mj-cpp-file-package filename) (mj-cpp-file-module filename)))
         (mj-tests-path (format "%s/tests/%s/%s" (mj-cpp-file-project filename) (mj-cpp-file-package filename) (mj-cpp-file-module filename)))
         )
    (cond
     ((string-match (format "%s/.*\\.h" mj-impl-path)  filename)
      'header)
     ((string-match (format "%s/.*\\.hpp" mj-impl-path)  filename)
      'header-impl)
     ((string-match (format "%s/.*\\.cpp" mj-impl-path)  filename)
      'impl)
     ((string-match (format "%s/.*_py\\.cc" mj-impl-path )  filename)
      'py-cc)
     ((string-match (format "%s/.*\\.cc" mj-impl-path )  filename)
      'impl)
     ((string-match (format "%s/.*\\.py" mj-impl-path )  filename)
      'py)
     ((string-match (format "%s/.*_test\\.cc" mj-tests-path)  filename)
      'test)

     ((string-match (format "%s/.*_test_main\\.cc" mj-tests-path)  filename)
      'test-main)
     (t
      (error (format "Cannot match file type for '%s' and\n'%s'\n%s" filename mj-impl-path mj-tests-path)))
     )
    )
)


(defun mj-cpp-file-switch (filename file-type)
  (let* (
         (mj-cpp-class (mj-cpp-file-class filename))
         (mj-cpp-project (mj-cpp-file-project filename))
         (mj-cpp-package (mj-cpp-file-package filename))
         (mj-cpp-module (mj-cpp-file-module filename))
         (mj-cpp-file-basename (mj-cpp-file-basename filename))
         )

    (cond
     ((eq file-type 'header)
      (format "%s/%s.h" (mj-cpp-project-package-module-path mj-cpp-project mj-cpp-package mj-cpp-module) mj-cpp-file-basename))
     ((eq file-type 'header-impl)
      (format "%s/%s.hpp" (mj-cpp-project-package-module-path mj-cpp-project mj-cpp-package mj-cpp-module) mj-cpp-file-basename))
     ((eq file-type 'impl)
      (format "%s/%s.cc" (mj-cpp-project-package-module-path mj-cpp-project mj-cpp-package mj-cpp-module) mj-cpp-file-basename))
     ((eq file-type 'py-cc)
      (format "%s/%s_py.cc" (mj-cpp-project-package-module-path mj-cpp-project mj-cpp-package mj-cpp-module) mj-cpp-file-basename))
     ((eq file-type 'py)
      (format "%s/%s.py" (mj-cpp-project-package-module-path mj-cpp-project mj-cpp-package mj-cpp-module) mj-cpp-file-basename))
     ((eq file-type 'test)
      (format "%s/%s_test.cc" (mj-cpp-project-package-module-tests-path mj-cpp-project mj-cpp-package mj-cpp-module) mj-cpp-file-basename))
     ((eq file-type 'test-main)
      (format "%s/%s_test_main.cc" (mj-cpp-project-package-module-tests-path mj-cpp-project mj-cpp-package mj-cpp-module) mj-cpp-module))
     (t
      (error (format "Cannot switch for %s (%s)" file-type filename)))
     )
    )
  )


;;(setq template-expansion-alist ())
(add-to-list 'template-expansion-alist
             '("MJ-CPP-FILE" (insert (format "%s" (file-name-base (buffer-file-name))))))
(add-to-list 'template-expansion-alist
	     '("MJ-CPP-FILE-BASENAME" (insert (format "%s" (mj-cpp-file-basename (buffer-file-name))))))
(add-to-list 'template-expansion-alist
	     '("MJ-CPP-PACKAGE" (insert (format "%s" (mj-cpp-file-package (buffer-file-name))))))
(add-to-list 'template-expansion-alist
	     '("MJ-CPP-MODULE" (insert (format "%s" (mj-cpp-file-module (buffer-file-name))))))
(add-to-list 'template-expansion-alist
	     '("MJ-CPP-CLASS" (insert (format "%s" (mj-cpp-file-class (buffer-file-name))))))
(add-to-list 'template-expansion-alist
             '("MJ-CPP-FILE-GUARD" (insert (upcase (string-inflection-underscore-function
                                                    (format "CAPD_FILE_%s_%s_%s" (mj-cpp-file-package (buffer-file-name))
                                                         (mj-cpp-file-module (buffer-file-name))
                                                         (mj-cpp-file-class (buffer-file-name)))))
                                         )))


;;(format "%s" template-expansion-alist)

(defun mj-cpp-select-template (filename)
  (let* (
         (file-type (mj-cpp-file-type filename))
         )
    (cond
     ((eq file-type 'header)
      "~/.templates/MJ-CPP-TEMPLATE.h.tpl")
     ((eq file-type 'header-impl)
      "~/.templates/MJ-CPP-TEMPLATE.hpp.tpl")
     ((eq file-type 'impl)
      "~/.templates/MJ-CPP-TEMPLATE.cpp.tpl")
     ((eq file-type 'test)
      "~/.templates/MJ-CPPTest-TEMPLATE.cpp.tpl")
     ((eq file-type 'test-main)
      "~/.templates/MJ-CPPTestMain-TEMPLATE.cpp.tpl")
     ((eq file-type 'bin-cpp)
      "~/.templates/MJ-CPP-TEMPLATE.cpp.tpl")
     ((eq file-type 'bin-header)
      "~/.templates/MJ-CPP-TEMPLATE.h.tpl")
     ((eq file-type 'bin-header-impl)
      "~/.templates/MJ-CPP-TEMPLATE.hpp.tpl")
     ((t)
      (error (format "Cannot match template for %s (%s)" file-type filename)))
     )
    )
)


(defun mj-cpp-add-file (class-name)
  "Switch between CAPD header/implementation/tests files"
  (interactive "MClass name: ")

  (let* (
         (curr-project (mj-cpp-file-project (buffer-file-name)))
         (curr-package (mj-cpp-file-package (buffer-file-name)))
         (curr-module (mj-cpp-file-module (buffer-file-name)))
         (project (ido-completing-read
                   "Select project: "
                   (mj-cpp-projects)
                   nil t curr-project ))

         (package (ido-completing-read
                   "Select package: "
                   (mj-cpp-packages project)
                   nil t curr-package ))
         (module (ido-completing-read
                  "Select module: "
                  (mj-cpp-modules project package)
                  nil t curr-module))
         (filename (concat (mj-cpp-project-package-module-path project package module) "/"
                           (string-inflection-underscore-function class-name)
                           ".h"))
         )
    (if (file-exists-p filename)
        (find-file filename)
      (progn
        ;;(write-region "" nil filename nil t nil t)
        (find-file filename)
        (template-new-file nil (mj-cpp-select-template filename))
        (set-buffer-modified-p t)
        )
      )
    )
)

(defun mj-cpp-switch (frame)
  "Switch between CAPD header/implementation/tests files"
  (interactive)
  (let* ( (file-type (intern (ido-completing-read
                              "Complete a file type: "
                              '("header" "header-impl" "impl" "py-cc" "py" "test" "test-main")
                              nil t )))

          (filename (mj-cpp-file-switch (buffer-file-name) file-type))
          )

    (other-window frame) ;; so when we split emacs frame, then we have them in one next to the other

    (if (file-exists-p filename)
        (find-file filename)
      (progn
      ;;(write-region "" nil filename nil t nil t)
        (find-file filename)
        (template-new-file nil (mj-cpp-select-template filename))
        (set-buffer-modified-p t)
        )
      )
  )
)



(defun mj-cpp-insert-previous-class-name ()
  ""
  (interactive)
  (insert (mj-cpp-file-class (buffer-name (car (car (window-prev-buffers))))))
  )


(defun mj-cpp-insert-class-name ()
  ""
  (interactive)
  (insert (mj-cpp-file-class (buffer-name (current-buffer))))
  )


(defun mj-cpp-default-h-files ()
  (sort
   (apply 'append (mapcar (lambda (boost-path)
                            (if (file-exists-p boost-path)
                               (let ((default-directory boost-path))
                                 (apply 'append (mapcar (lambda (p)(file-expand-wildcards p))
                                                        '("boost/*/*.hpp" "boost/*.hpp"
                                                          "boost/range/algorithm*/*.hpp"
                                                          "boost/algorithm/*/*.hpp"
                                                          "boost/range/adaptor/*.hpp"
                                                          "boost/numeric/*/*.hpp"
                                                          "boost/accumulators/*.hpp"
                                                          "boost/accumulators/statistics/*.hpp"
                                                          "*.h" "*/*.h")
                                                        ))
                                 )
                               ))
            '("/usr/local/include" "/usr/include")))
  'string<)
)

(setq mj-cpp-default-h-files-cache (mj-cpp-default-h-files))


(defun mj-cpp-add-include ()
  (interactive)

  (let* (
         (file-list (apply 'append
                           (list
                            (mj-cpp-headers)
                            mj-cpp-default-h-files-cache
                            '(
                              "array"
                              "cassert"
                              "map"
                              "vector"
                              "algorithm"
                              "utility"
                              "sstream"
                              "string"
                              "iostream"
                              "iterator"
                              "fstream"
                              "iosfwd"
                              "deque"
                              "queue"
                              "list"
                              "limits"
                              "numeric"
                              "cstring"
                              "cmath"
                              "stdio.h"
                              "unistd.h"
                              "exception"
                              "stdexcept"
                              "functional"
                              "type_traits"
                              "unordered_set"
                              "unordered_map"
                              )
                            ))
                    )
         (file (ido-completing-read
                "Complete a file name: "
                file-list
                nil t ))
         )
    (with-current-buffer (current-buffer)
      (save-excursion
        (goto-char (point-max))
        (if (search-backward "#include" nil t)
            ()
          (error "We nedd at least one #include directive in the file"))
        (end-of-line)
        (insert (format "\n#include <%s>" file))
        ))
    )
)


(global-set-key "\C-co" (lambda () (interactive) (mj-cpp-switch 0)))
(global-set-key "\C-cO" (lambda () (interactive) (mj-cpp-switch 1)))
(global-set-key "\C-ca" 'mj-cpp-add-file)
(global-set-key "\C-ci" 'mj-cpp-add-include)
(global-set-key "\C-cb" 'mj-cpp-insert-previous-class-name)
(global-set-key "\C-cc" 'mj-cpp-insert-class-name)
