;; (setq user-full-name "Livey"
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

(setq doom-theme 'doom-dracula)

(setq display-line-numbers-type t)

(map! :leader
      :desc "comment line" "-" #'comment-line)

;; Add more custom keybindings here
;; Example:
;; (map! :leader
;;       :desc "description" "key" #'function)

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

;; Configure eshell to use lsd for ls
(after! eshell
  (defun eshell/ls (&rest args)
    "Use lsd instead of ls in eshell"
    (eshell-external-command "lsd" args)
    nil))

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
;; Note: Disabled because delete-other-windows causes issues with side windows
;; (add-hook 'server-after-make-frame-hook
;;           (lambda ()
;;             ;; Kill any buffer that looks like a "client" file
;;             (dolist (buf (buffer-list))
;;               (when (string-match-p "client" (buffer-name buf))
;;                 (kill-buffer buf)))
;;             ;; Keep only one window
;;             (delete-other-windows)))

;; Additional general settings
;; (setq auto-save-default t)
;; (setq make-backup-files t)
;; (global-auto-revert-mode t)

(after! flycheck
  (setq flycheck-checkers (append flycheck-checkers '(python-flake8))))

(after! ivy-posframe
  (ivy-posframe-mode 1))

(after! dired
  (setq dired-listing-switches "-alh")
  (setq insert-directory-program "lsd")
  (setq dired-use-ls-dired nil))

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

;; eee.el configuration for Yazi integration
(use-package! eee
  :config
  ;; Set terminal emulator (kitty is already installed)
  (setq ee-terminal-command "kitty")
  ;; Keybindings for ee- commands
  (map! :leader
        (:prefix ("e" . "external tools")
         :desc "Open Yazi file manager" "y" #'ee-yazi
         :desc "Open Yazi in project" "Y" #'ee-yazi-project
         :desc "Search with ripgrep+fzf" "r" #'ee-rg
         :desc "Find files with fzf" "f" #'ee-find
         :desc "LazyGit" "g" #'ee-lazygit)))
