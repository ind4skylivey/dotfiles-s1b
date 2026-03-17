;; (setq user-full-name "il1v3y"
;;       user-mail-address "your-email@example.com")

(setq doom-font (font-spec :family "JetBrains Mono" :size 15))

(custom-theme-set-faces!
 'doom-one
 '(org-level-8 :inherit outline-3 :height 1.0)
 '(org-level-7 :inherit outline-3 :height 1.0)
 '(org-level-6 :inherit outline-3 :height 1.1)
 '(org-level-5 :inherit outline-3 :height 1.2)
 '(org-level-4 :inherit outline-3 :height 1.3)
 '(org-level-3 :inherit outline-3 :height 1.4)
 '(org-level-2 :inherit outline-2 :height 1.5)
 '(org-level-1 :inherit outline-1 :height 1.6)
 '(org-document-title :height 1.8 :bold t :underline nil))

(setq doom-theme 'doom-outrun-electric
      doom-themes-enable-bold t
      doom-themes-enable-italic t)

(after! doom-themes
  ;; Keep neon accents consistent across sidebars/modeline
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config))

(setq doom-modeline-height 32
      doom-modeline-bar-width 4
      doom-modeline-persp-name t
      doom-modeline-buffer-file-name-style 'truncate-with-project)

(setq evil-normal-state-cursor '(box "#24e5ff")
      evil-insert-state-cursor '(bar "#ff2afc")
      evil-visual-state-cursor '(hollow "#ff9e64"))

(custom-set-faces!
 '(cursor :background "#24e5ff")
 '(mode-line :background "#0a0f14" :foreground "#e6f6ff" :box (:line-width 1 :color "#ff2afc"))
 '(mode-line-inactive :background "#0a0f14" :foreground "#5a6782" :box (:line-width 1 :color "#1f2233"))
 '(line-number :foreground "#3a4361")
 '(line-number-current-line :foreground "#ff9e64" :weight bold)
 '(region :background "#1f2233")
 '(vertical-border :foreground "#1f2233"))

(setq display-line-numbers-type t)

(map! :leader
      :desc "comment line" "-" #'comment-line)

(map! :leader
      :desc "Toggle line wrap" "t w" #'visual-line-mode
      :desc "Copy file path" "f y" #'doom/copy-this-file
      :desc "Delete file" "f D" #'doom/delete-this-file
      :desc "Find file in project" "p f" #'projectile-find-file)

(setq org-directory "~/org/")

(setq org-modern-table-vertical 1)
(setq org-modern-table t)

(add-hook 'org-mode-hook #'hl-todo-mode)

(after! org
  (setq org-auto-tangle t))

;; Org Agenda configuration
;; (setq org-agenda-files '("~/org/"))

;; Org Capture templates
;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "~/org/tasks.org" "Tasks")
;;          "* TODO %?\n  %i\n  %a")))

;; Org Babel languages
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((emacs-lisp . t)
;;    (python . t)
;;    (rust . t)
;;    (shell . t)))

(setq-default vterm-shell "/bin/fish")
(setq-default explicit-shell-file-name "/bin/fish")
;; Yazi (y) needs a real TTY; let eshell hand it off to term automatically
(defvar eshell-visual-commands nil) ;; make sure it's bound even before eshell loads
(after! eshell
  (require 'em-term) ;; brings eshell-visual-commands defaults
  (add-to-list 'eshell-visual-commands "yazi"))

(defun +yazi-vterm-here ()
  "Launch yazi in a vterm at the current directory (or dired dir)."
  (interactive)
  (let ((default-directory (or (and (derived-mode-p 'dired-mode) (dired-current-directory))
                               default-directory)))
    (vterm)
    (vterm-send-string "yazi")
    (vterm-send-return)))

(map! :leader
      :desc "Yazi (vterm)" "o y" #'+yazi-vterm-here)

;; Disable exit confirmation
(setq confirm-kill-emacs nil)

;; Start with eshell
(setq initial-buffer-choice 'eshell)

;; Suppress native compilation warnings
(setq native-comp-async-report-warnings-errors nil)

;; Prevent workspace auto-restore (stops old "client" buffer from appearing)
(after! persp-mode
  (setq persp-auto-resume-time -1))

;; Don't split windows on emacsclient startup
(add-hook 'server-after-make-frame-hook
          (lambda ()
            ;; Kill any buffer that looks like a "client" file
            (dolist (buf (buffer-list))
              (when (string-match-p "client" (buffer-name buf))
                (kill-buffer buf)))
            ;; Keep only one window
            (delete-other-windows)))

;; Faster which-key popup
(setq which-key-idle-delay 0.3)

;; Better scrolling performance
(setq scroll-margin 3
      scroll-conservatively 101)

;; Faster LSP performance
(setq lsp-idle-delay 0.5
      lsp-log-io nil)

;; Better undo with evil
(setq evil-want-fine-undo t)

;; Keep cursor at center when jumping
(setq evil-scroll-count 0)

;; Vim-like clipboard
(setq select-enable-clipboard t)

;; Auto-save and backups (helpful for security research)
(setq auto-save-default t
      auto-save-timeout 20
      make-backup-files t
      backup-directory-alist '((".*" . "~/.emacs.d/backups")))

;; Show file path in title bar
(setq frame-title-format '("%b – Doom Emacs"))

;; Highlight current line in all buffers
(global-hl-line-mode 1)

;; Better search highlighting
(setq lazy-highlight-initial-delay 0)

;; Better git commit messages (for red team documentation)
(setq git-commit-summary-max-length 72)

;; Highlight hex colors in programming modes
(add-hook 'prog-mode-hook #'rainbow-mode)

;; Auto-close parens/brackets
(electric-pair-mode t)

;; Additional general settings
;; (setq auto-save-default t)
;; (setq make-backup-files t)
;; (global-auto-revert-mode t)

(after! flycheck
  (setq flycheck-checkers (append flycheck-checkers '(python-flake8))))

(after! ivy-posframe
  (ivy-posframe-mode 1))

(after! dired
  (setq dired-listing-switches "-alh --group-directories-first"
        dired-kill-when-opening-new-dired-buffer t))  ; Don't create multiple dired buffers

(after! exwm
  (setq exwm-workspace-number 4))

(after! beacon
  (beacon-mode 1))

(after! rainbow-mode
  (add-hook 'css-mode-hook #'rainbow-mode)
  (add-hook 'web-mode-hook #'rainbow-mode))

(after! olivetti
  (add-hook 'text-mode-hook 'olivetti-mode))

;; LSP Mode configuration
;; (after! lsp-mode
;;   (setq lsp-rust-server 'rust-analyzer)
;;   (setq lsp-php-server-command '("intelephense" "--stdio")))

;; Projectile for project management
;; (after! projectile
;;   (setq projectile-project-search-path '("~/projects/")))

;; Magit configuration
;; (after! magit
;;   (setq magit-repository-directories '(("~/projects" . 2))))

;; Company autocomplete
;; (after! company
;;   (setq company-idle-delay 0.2)
;;   (setq company-minimum-prefix-length 2))

;; Treemacs file explorer
;; (after! treemacs
;;   (setq treemacs-width 35))
