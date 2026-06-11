
(defvar my-current-project-root nil)
(setq inhibit-startup-message t) ;Don't show splash screen
(menu-bar-mode -1)               ;Flash when the bell rings
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq visible-bell t)

;; Enable line numbers on some modes
(global-display-line-numbers-mode 1)
(dolist (mode '(org-mode-hook term-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Use ESC to cancel prompts (C-g)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;;------------------------------------------------------------
;; Prevent generating backup and auto-save files everywhere.
;; Instead, generate them within the .emacs.d/.tmp/ folder
;;------------------------------------------------------------

;; Backup files are stored in .../.tmp/backups
(setq backup-directory-alist `((".". ,(expand-file-name ".tmp/backups/" user-emacs-directory))))

;; Auto save files are stored in .../.tmp/auto-saves
(make-directory (expand-file-name ".tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "/tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*"  ,(expand-file-name ".tmp/auto-saves/" user-emacs-directory) t )))

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents (package-refresh-contents))



;; Initialize use-packages on non-linux platforms
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

;;------------------------------------------------------------
;; Theme, icons, fonts and modeline
;;------------------------------------------------------------
(use-package naysayer-theme :ensure t)
(use-package doom-themes :ensure nil)
(add-to-list 'custom-theme-load-path "~/.emacs.d/custom_themes/")
;;(use-package doom-modeline :ensure t :init (doom-modeline-mode 1) :config (line-number-mode 1) (column-number-mode 1))

(use-package doom-modeline
  :ensure t
  :init
  ;; visual shape
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 4)

  ;; icons
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)

  ;; buffer / project info
  (setq doom-modeline-buffer-name t)
  (setq doom-modeline-highlight-modified-buffer-name t)
  (setq doom-modeline-project-name t)

  ;; position
  (setq doom-modeline-position-column-line-format '("%l:%c"))
  (setq doom-modeline-percent-position '(-3 "%p"))

  ;; useful status
  (setq doom-modeline-lsp t)
  (setq doom-modeline-selection-info t)

  ;; reduce noise
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-github nil)
  (setq doom-modeline-mu4e nil)

  :config
  (doom-modeline-mode 1)
  (line-number-mode 1)
  (column-number-mode 1))

;; Theme and font
(load-theme 'naysayer t)
(set-face-attribute 'default nil :font "Victor Mono" :height 120)
;; This will install in the default fonts folder for Linux/macOS/BSDs
;; but for Windows this will download to the specified folder
(use-package nerd-icons
  :ensure t 
  :config
  (unless (find-font (font-spec :name "Nerd Icons"))
    (nerd-icons-install-fonts
     (when (eq system-type 'windows-nt)
       "~/.emacs.d/nerd-icons/"))))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))


;; ------------------------------------------------------------
;; C/C++ code formating
;; ------------------------------------------------------------
(require 'cc-mode)

(c-add-style
 "marciovmf-c"
 '("bsd"
   (c-basic-offset . 2)
   (indent-tabs-mode . nil)

   ;; Important: enable electric newlines around braces.
   (c-auto-newline . t)

   ;; Put braces on their own lines.
   (c-hanging-braces-alist
    . ((defun-open . (before after))
       (defun-close . (before after))

       (class-open . (before after))
       (class-close . (before after))

       (inline-open . (before after))
       (inline-close . (before after))

       (block-open . (before after))
       (block-close . (before after))

       (substatement-open . (before after))
       (statement-case-open . (before after))

       ;; allow inline initializer lists. Do not force line breaks.
       ;; int a[] = { 1, 2, 3 };
       (brace-list-open)
       (brace-list-close)))

   (c-offsets-alist
    . ((defun-open . 0)
       (defun-close . 0)

       (substatement-open . 0)
       (block-open . 0)
       (block-close . 0)

       (brace-list-open . 0)
       (brace-list-close . 0)

       (statement-block-intro . +)
       (statement-cont . +)
       (arglist-intro . +)
       (arglist-close . 0)))))

;; Enforce 80 character long lines
(defvar marciovmf-c-line-limit 80)

(defun marciovmf-c--first-long-line ()
  (save-excursion
    (goto-char (point-min))
    (catch 'bad
      (while (not (eobp))
        (end-of-line)
        (let ((col (current-column)))
          (when (> col fill-column)
            (throw 'bad (cons (line-number-at-pos) col))))
        (forward-line 1))
      nil)))

(defun marciovmf-c-check-line-length ()
  (let ((bad (marciovmf-c--first-long-line)))
    (when bad
      (goto-char (point-min))
      (forward-line (1- (car bad)))
      (user-error "Line %d is %d columns; limit is %d"
                  (car bad) (cdr bad) fill-column))))

(defun marciovmf-c-line-limit-setup ()
  (setq-local fill-column marciovmf-c-line-limit)

  ;; Visual marker at column 80.
  (display-fill-column-indicator-mode 1)

  ;; Auto-wrap comments.
  (auto-fill-mode 1)

  ;; Block save if any line is too long.
  (add-hook 'before-save-hook
            #'marciovmf-c-check-line-length
            nil
            t))


(defun my-c-mode-setup ()
  (c-set-style "marciovmf-c")
  (setq-local c-basic-offset 2)
  (setq-local indent-tabs-mode nil)
  (setq-local c-auto-newline t)
  (marciovmf-c-line-limit-setup))

(add-hook 'c-mode-hook #'my-c-mode-setup)
(add-hook 'c++-mode-hook #'my-c-mode-setup)
(add-hook 'objc-mode-hook #'my-c-mode-setup)

;; 
(defun my-c-like-word-syntax ()
  "Treat underscore as part of words."
  (modify-syntax-entry ?_ "w"))

(add-hook 'c-mode-hook #'my-c-like-word-syntax)
(add-hook 'c++-mode-hook #'my-c-like-word-syntax)
(add-hook 'objc-mode-hoOk #'my-c-like-word-syntax)
(add-hook 'python-mode-hook #'my-c-like-word-syntax)
(add-hook 'elisp-mode-hook #'my-c-like-word-syntax)
(add-hook 'cmake-mode-hook #'my-c-like-word-syntax)


;; ------------------------------------------------------------
;; which-key
;; Built into Emacs 30+, installed as package on older Emacs
;; ------------------------------------------------------------

(unless (or (package-installed-p 'which-key)
            (package-built-in-p 'which-key))
  (package-install 'which-key))

(use-package which-key
  :ensure nil
  :diminish which-key-mode
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.5))

;; ------------------------------------------------------------
;; Ivy + Counsel
;; ------------------------------------------------------------
(use-package ivy :diminish :config (ivy-mode 1))
(use-package ivy-rich :after ivy :config (ivy-rich-mode 1))

(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
(ivy-rich-modify-column
 'ivy-switch-buffer
 'ivy-rich-switch-buffer-major-mode
 '(:width 20 :face error))

;; ------------------------------------------------------------
;; Sort buffer switcher: file buffers first, special buffers last
;; ------------------------------------------------------------

(require 'cl-lib)

(defun my-buffer-candidate-file-backed-p (candidate)
  "Return non-nil if CANDIDATE names a buffer visiting a file."
  (when-let ((buffer (get-buffer candidate)))
    (buffer-file-name buffer)))

(defun my-buffer-position (candidate)
  "Return CANDIDATE's position in `buffer-list', or a large number."
  (let ((buffer (get-buffer candidate)))
    (or (cl-position buffer (buffer-list))
        most-positive-fixnum)))

(defun my-ivy-sort-buffers-file-first (a b)
  "Sort file-backed buffers before non-file buffers.
Within each group, preserve Emacs' normal buffer recency order."
  (let ((a-file (my-buffer-candidate-file-backed-p a))
        (b-file (my-buffer-candidate-file-backed-p b)))
    (cond
     ;; File buffers first
     ((and a-file (not b-file)) t)
     ((and (not a-file) b-file) nil)

     ;; Same group: preserve recent-buffer order
     (t (< (my-buffer-position a)
           (my-buffer-position b))))))

(with-eval-after-load 'ivy
  ;; For counsel-switch-buffer
  (setf (alist-get 'counsel-switch-buffer ivy-sort-functions-alist)
        #'my-ivy-sort-buffers-file-first)

  ;; Also useful if you ever call ivy-switch-buffer directly
  (setf (alist-get 'ivy-switch-buffer ivy-sort-functions-alist)
        #'my-ivy-sort-buffers-file-first))


(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ;("C-<tab>" . counsel-switch-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ; Don't start searches with ^

;;------------------------------------------------------------
;; Projectile
;;------------------------------------------------------------
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (let ((work-path "c:/work/"))
    (when (file-directory-p work-path)
      (setq projectile-project-search-path (list work-path))))
  :config
  (projectile-mode +1)
  (setq projectile-indexing-method 'hybrid)
  :bind-keymap
  ("C-x p" . projectile-command-map))
  (setq projectile-switch-project-action 'projectile-dired)

;;------------------------------------------------------------
;; Dashboard
;;------------------------------------------------------------
(use-package dashboard
  :ensure t
  :init
  ;(setq dashboard-startup-banner 'logo)
  (setq dashboard-startup-banner "~/.emacs.d/way_of_emacs_transparent.png")
  (setq dashboard-center-content t)
  (setq dashboard-vertically-center-content t)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-icon-type 'nerd-icons)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq initial-buffer-choice #'dashboard-open)
  (use-package page-break-lines
    :ensure t
    :config
    (global-page-break-lines-mode 1))
  (setq dashboard-items '((recents . 5)
			  (projects . 5)
			  (bookmarks . 5)))
  :hook (dashboard-mode . page-break-lines-mode)
  :config (dashboard-setup-startup-hook))


;; ------------------------------------------------------------
;; clangd / eglot
;; ------------------------------------------------------------
(use-package eglot
  :ensure t
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode) . ("clangd"))))

;; Toggle inlay annotations with F3
(with-eval-after-load 'eglot
  (defvar my-eglot-inlay-hints-enabled nil) ;; inlays disabled by default

  (defun my-eglot-apply-inlay-hints ()
    (when (bound-and-true-p eglot--managed-mode)
      (eglot-inlay-hints-mode
       (if my-eglot-inlay-hints-enabled 1 -1))))

  (defun my-eglot-toggle-inlay-hints ()
    (interactive)
    (setq my-eglot-inlay-hints-enabled
          (not my-eglot-inlay-hints-enabled))

    ;; Apply to all existing Eglot buffers.
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (my-eglot-apply-inlay-hints)))

    (message "Eglot inlay hints %s"
             (if my-eglot-inlay-hints-enabled
                 "enabled"
               "disabled")))

  ;; Apply preference to new Eglot buffers.
  (add-hook 'eglot-managed-mode-hook #'my-eglot-apply-inlay-hints)

  ;; Global-ish binding while in Eglot buffers.
  (define-key eglot-mode-map (kbd "<f3>")
              #'my-eglot-toggle-inlay-hints))

;; LSP diagnostic messages
(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook (lambda () (eldoc-mode -1))))

(defun my-flymake-show-line-diagnostics ()
  (interactive)
  (let* ((line-beg (line-beginning-position))
         (line-end (line-end-position))
         (diagnostics (flymake-diagnostics line-beg line-end)))
    (if diagnostics
        (message "%s"
                 (mapconcat
                  (lambda (diag)
                    (flymake-diagnostic-text diag))
                  diagnostics
                  " | "))
      (message "No diagnostics on this line"))))


;; Completion popup
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.15)
  (corfu-auto-prefix 2)
  (corfu-preview-current nil)
  (corfu-cycle t))

;; Extra completion sources
(use-package cape
  :ensure t
  :init
  ;; Useful generic completions.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;; Documentation popup
(use-package eldoc-box
  :ensure t
  :after eglot
  :bind
  (:map eglot-mode-map ("C-c h" . eldoc-box-help-at-point)))

;; ------------------------------------------------------------
;; Automatic stuff
;; ------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f6ea954a9544b0174a876d195387f444da441535ee88c7fb0fc346af08b0d228"
     "be0d9f0e72a4ebc4a59c382168921b082b4dc15844bdaf1353c08157806b3321"
     "42a6583a45e0f413e3197907aa5acca3293ef33b4d3b388f54fa44435a494739"
     "87fa3605a6501f9b90d337ed4d832213155e3a2e36a512984f83e847102a42f4"
     "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0"
     "e14289199861a5db890065fdc5f3d3c22c5bac607e0dbce7f35ce60e6b55fc52"
     "df6dfd55673f40364b1970440f0b0cb8ba7149282cf415b81aaad2d98b0f0290"
     "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33"
     "5c8a1b64431e03387348270f50470f64e28dfae0084d33108c33a81c1e126ad6"
     "460c75b0ef8befdfd5f93c110be9da2df45132c114b9c946a728a8ccc3ff983f"
     "3ea04bc210ec6a73db28ce2cf4b8d141d91797b52f3245a948435babb8bdfc26"
     "09276f492e8e604d9a0821ef82f27ce58b831f90f49f986b4d93a006c12dbcdb"
     "2ab8cb6d21d3aa5b821fa638c118892049796d693d1e6cd88cb0d3d7c3ed07fc"
     "1f8bd4db8280d5e7c5e6a12786685a7e0c6733b0e3cf99f839fb211236fb4529"
     "d12b1d9b0498280f60e5ec92e5ecec4b5db5370d05e787bc7cc49eae6fb07bc0"
     "0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     "6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425"
     "93011fe35859772a6766df8a4be817add8bfe105246173206478a0706f88b33d"
     "088cd6f894494ac3d4ff67b794467c2aa1e3713453805b93a8bcb2d72a0d1b53"
     "dd4582661a1c6b865a33b89312c97a13a3885dc95992e2e5fc57456b4c545176"
     "9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9"
     "fffef514346b2a43900e1c7ea2bc7d84cbdd4aa66c1b51946aade4b8d343b55a"
     "4d5d11bfef87416d85673947e3ca3d3d5d985ad57b02a7bb2e32beaf785a100e"
     "ff24d14f5f7d355f47d53fd016565ed128bf3af30eb7ce8cae307ee4fe7f3fd0"
     "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd"
     "dfb1c8b5bfa040b042b4ef660d0aab48ef2e89ee719a1f24a4629a0c5ed769e8"
     "7ec8fd456c0c117c99e3a3b16aaf09ed3fb91879f6601b1ea0eeaee9c6def5d9"
     "456697e914823ee45365b843c89fbc79191fdbaff471b29aad9dcbe0ee1d5641"
     "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93"
     "70c88c01b0b5fde9ecf3bb23d542acba45bb4c5ae0c1330b965def2b6ce6fac3"
     "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19"
     "02d422e5b99f54bd4516d4157060b874d14552fe613ea7047c4a5cfa1288cf4f"
     default))
 '(package-selected-packages
   '(all-the-icons-ivy-rich cape cmake-mode command-log-mode corfu
			    counsel counsel-projectile dashboard
			    doom-modeline doom-themes eglot eldoc-box
			    evil naysayer-theme nerd-icons-dired
			    no-littering orderless page-break-lines
			    projectile))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;------------------------------------------------------------
;; Global keybindings
;;------------------------------------------------------------

;; Keybindings
(global-set-key (kbd "C-0") 'text-scale-set)                ; Reset text scale to default
(global-set-key (kbd "C-<up>") 'text-scale-increase)        ; Increase text scale
(global-set-key (kbd "C-<down>") 'text-scale-decrease)      ; Decrease text scale

;;------------------------------------------------------------
;; Custom functions
;;------------------------------------------------------------

;; compile command
(setq projectile-project-compilation-cmd "cmake --build .build")

;; Compile current project
(defun my-projectile-compile ()
  (interactive)
  (let ((compilation-read-command nil))
    (projectile-compile-project nil)))

;; Clean current project
(defun my-projectile-clean ()
  (interactive)
  (projectile-run-async-shell-command-in-root
   "cmake --build .build --target clean"))

(global-set-key (kbd "<f5>") #'my-projectile-compile)
(global-set-key (kbd "S-<f5>") #'my-projectile-clean)

(add-hook 'c-mode-common-hook #'hs-minor-mode)              ; Folding mode enabled for c source

;; Misc configuration
(save-place-mode 1)    ; remember cursor position in files
(recentf-mode 1)       ; remember recently opened files
(savehist-mode 1)      ; remember minibuffer history
(setq desktop-restore-frames t) ; remember open frames

;; Cursor line highlight
(global-hl-line-mode 1) ; highlight cursor line
(set-face-attribute 'hl-line nil              
		    :background "#003366"     ; background color
		    :inherit nil
		    :foreground 'unspecified  ; do not override foreground colors
		    :underline nil)           ; do not underline the cursor line

;; Kill all buffers
(defun killall ()
  (interactive)
  (let ((kill-buffer-query-functions nil))
    (dolist (buffer (buffer-list))
      (when (buffer-live-p buffer)
        (with-current-buffer buffer
          ;; Avoid "Buffer modified; kill anyway?"
          (set-buffer-modified-p nil))
        (kill-buffer buffer))))

  (if (fboundp 'dashboard-open)
      (dashboard-open)
    (message "dashboard-open is not available")))


;; Set window title with current project (if any) + full path of current file 
(defun my-frame-title ()
  (let* ((name
          (cond
           (buffer-file-name
            (expand-file-name buffer-file-name))
           ((eq major-mode 'dired-mode)
            (expand-file-name default-directory))
           (t
            (buffer-name))))
         (project-name
          (when (and (fboundp 'projectile-project-p)
                     (ignore-errors (projectile-project-p)))
            (let ((pname (ignore-errors (projectile-project-name))))
              (unless (or (null pname)
                          (string= pname "-"))
                pname)))))
    (if project-name
        (format "Emacs - [ %s ] - %s" project-name name)
      (format "Emacs - %s" name))))

(setq frame-title-format
      '((:eval (my-frame-title))))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'my-project-dashboard)
(setq projectile-switch-project-action #'my-project-dashboard)
(with-eval-after-load 'evil (evil-set-initial-state 'my-project-dashboard-mode 'motion))

;; ------------------------------------------------------------
;; Evil mode + custom normal mode keybindings
;; ------------------------------------------------------------

(use-package evil :ensure t :config (evil-mode 1))

(defun my-yank-current-buffer-file-path ()
  "Copy the full path of the current buffer's file."
  (interactive)
  (if-let ((file buffer-file-name))
      (let ((path (file-truename file)))
        (kill-new path)
        (message "Copied path: %s" path))
    (message "Current buffer is not visiting a file")))


;; I always used C-k on VIM for my stuff because K is the most
;; reachable key from home row with my right hand.
;; Unfortunately, on emacs, C-k is bound to kill-line and I don't want to remove that.
;; This function ensures evil normal mode overrides it.
(defvar my-evil-c-k-map (make-sparse-keymap)
  "My Evil normal-mode C-k prefix map.")

(with-eval-after-load 'evil
  ;; Make C-k a prefix in Evil normal mode.
  ;; This overrides any existing Evil normal-mode meaning of C-k.
  ;; Also for buffers in motion-mode like *compilation*, *grep*, buffer, help, dired, etc
  (define-key evil-normal-state-map (kbd "C-k") my-evil-c-k-map)
  (define-key evil-motion-state-map (kbd "C-k") my-evil-c-k-map)

  ;; Remove this if you only want normal mode.
  ;; (define-key evil-visual-state-map (kbd "C-k") my-evil-c-k-map)

  ;; C-k prefix bindings
  (define-key my-evil-c-k-map (kbd "k") #'kill-current-buffer)
  (define-key my-evil-c-k-map (kbd "f") #'counsel-projectile-find-file)
  (define-key my-evil-c-k-map (kbd "b") #'counsel-switch-buffer)
  (define-key my-evil-c-k-map (kbd "y") #'my-yank-current-buffer-file-path)
  (define-key my-evil-c-k-map (kbd "p") #'projectile-switch-project)
  (define-key my-evil-c-k-map (kbd "l") #'my-flymake-show-line-diagnostics)
  (define-key my-evil-c-k-map (kbd "s") #'save-buffer)
  (define-key my-evil-c-k-map (kbd "0") #'dashboard-open))

  ;; The End
