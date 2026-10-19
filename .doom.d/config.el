;; (setq user-full-name "il1v3y"
;;       user-mail-address "your-email@example.com")

(setq doom-font (font-spec :family "VictorMono Nerd Font" :size 16 :weight 'medium))

;; Operator Mono style italics, both themes (no colors here)
(custom-set-faces!
 '(font-lock-comment-face :slant italic)
 '(font-lock-doc-face :slant italic)
 '(font-lock-keyword-face :slant italic :weight bold))

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

;; Light/dark auto switch. Noctalia's toggle writes
;; org.gnome.desktop.interface color-scheme, which xdg-desktop-portal
;; exposes as org.freedesktop.appearance color-scheme (0 none, 1 dark,
;; 2 light) and announces via the SettingChanged dbus signal.
;; Fallback when the portal is unreachable: ask gsettings once.
(defvar +lv/dark-theme 'doom-outrun-electric)
(defvar +lv/light-theme 'doom-s1b-cyber-light)

(defun +lv/apply-evil-cursors (light)
  (if light
      (setq evil-normal-state-cursor '(box "#ff00c8")
            evil-insert-state-cursor '(bar "#7a2cff")
            evil-visual-state-cursor '(hollow "#b35c00"))
    (setq evil-normal-state-cursor '(box "#ff2fd6")
          evil-insert-state-cursor '(bar "#ff2afc")
          evil-visual-state-cursor '(hollow "#ff9e64"))))

(defun +lv/system-prefers-light-p ()
  "Non-nil when the desktop color scheme is light."
  (let ((v (ignore-errors
             (require 'dbus)
             (dbus-call-method :session "org.freedesktop.portal.Desktop"
                               "/org/freedesktop/portal/desktop"
                               "org.freedesktop.portal.Settings" "ReadOne"
                               "org.freedesktop.appearance" "color-scheme"))))
    (while (consp v) (setq v (car v)))
    (if (integerp v)
        (= v 2)
      (string-match-p "light"
                      (or (ignore-errors
                            (shell-command-to-string
                             "gsettings get org.gnome.desktop.interface color-scheme"))
                          "")))))

(defun +lv/load-light-dark (light)
  (let ((theme (if light +lv/light-theme +lv/dark-theme)))
    (+lv/apply-evil-cursors light)
    (unless (and (memq theme custom-enabled-themes)
                 (eq theme doom-theme))
      (setq doom-theme theme)
      (mapc #'disable-theme custom-enabled-themes)
      (load-theme theme t))))

(defun +lv/sync-system-theme (&rest _)
  "Apply the light or dark theme matching the system color scheme."
  (interactive)
  (+lv/load-light-dark (+lv/system-prefers-light-p)))

(defun +lv/toggle-light-dark ()
  "Manually flip between the light and dark themes."
  (interactive)
  (+lv/load-light-dark (not (eq doom-theme +lv/light-theme))))

(defun +lv/portal-setting-changed (ns key value)
  (when (and (equal ns "org.freedesktop.appearance")
             (equal key "color-scheme"))
    (while (consp value) (setq value (car value)))
    (+lv/load-light-dark (eql value 2))))

(when (and (featurep 'dbusbind) (require 'dbus nil t))
  (ignore-errors
    (dbus-register-signal :session nil
                          "/org/freedesktop/portal/desktop"
                          "org.freedesktop.portal.Settings" "SettingChanged"
                          #'+lv/portal-setting-changed)))

(setq doom-theme (if (+lv/system-prefers-light-p) +lv/light-theme +lv/dark-theme))
(+lv/apply-evil-cursors (eq doom-theme +lv/light-theme))

(map! :leader
      (:prefix "t"
       :desc "Light/dark theme" "L" #'+lv/toggle-light-dark))

(custom-theme-set-faces! 'doom-outrun-electric
 '(default :background "#341c5e")
 '(fringe :background "#341c5e")
 '(solaire-default-face :background "#26154a")
 '(hl-line :background "#44227a")
 '(solaire-hl-line-face :background "#44227a")
 '(cursor :background "#ff2fd6")
 '(mode-line :background "#1a0b3a" :foreground "#f5eaff" :box (:line-width 1 :color "#ff1744"))
 '(mode-line-active :background "#1a0b3a" :foreground "#f5eaff" :box (:line-width 1 :color "#ff1744"))
 '(mode-line-inactive :background "#26154a" :foreground "#8a72b8" :box (:line-width 1 :color "#4a2c80"))
 '(line-number :background "#341c5e" :foreground "#7a5cb8")
 '(line-number-current-line :background "#4a2585" :foreground "#ff1744" :weight bold)
 '(region :background "#7b2fd6" :foreground "#ffffff" :distant-foreground "#ffffff")
 '(show-paren-match :background "#00f0ff" :foreground "#1a0b3a" :weight bold)
 '(vertical-border :foreground "#ff1744")
 '(minibuffer-prompt :foreground "#ff1744" :weight bold)
 '(error :foreground "#ff1744" :weight bold)
 '(font-lock-warning-face :foreground "#ff1744" :weight bold)
 '(isearch :background "#ff1744" :foreground "#ffffff" :weight bold)
 '(lazy-highlight :background "#5c1030" :foreground "#ff8fa3")
 '(evil-ex-substitute-matches :background "#5c1030" :foreground "#ff8fa3" :strike-through t)
 '(evil-ex-substitute-replacement :foreground "#ff1744" :weight bold :underline t)
 '(doom-modeline-bar :background "#ff1744")
 '(doom-modeline-evil-normal-state :foreground "#ff1744" :weight bold)
 '(org-level-1 :foreground "#ff1744" :weight bold :height 1.2)
 '(outline-1 :foreground "#ff1744" :weight bold)
 '(magit-section-heading :foreground "#ff1744" :weight bold)
 '(flycheck-error :underline (:style wave :color "#ff1744")))

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

;; ===== gh-use auto-switch for eshell (2026-10-16) =====
(defvar +gh-profile-enabled t "Non-nil: auto-run gh-use on directory change.")
(defvar +gh-profile-repos-base "/media/il1v3y/HD2/HDfiles/shenanigans/Repos/")
(defvar +gh-profile-state-file
  (expand-file-name "~/.local/state/gh-profile/current"))
(defvar +gh-profile--proc nil)

(defun +gh-profile-detect (dir)
  "Same mapping as ~/.local/bin/gh-profile-detect. Returns \"personal\", \"bitflow\" or nil."
  (let ((d (file-name-as-directory (file-truename (expand-file-name dir)))))
    (cond ((or (string-prefix-p (concat +gh-profile-repos-base "Personal/") d)
               (string-prefix-p (concat +gh-profile-repos-base "S1BGr0up/") d))
           "personal")
          ((string-prefix-p (concat +gh-profile-repos-base "Bitflow/") d) "bitflow"))))

(defun +gh-profile-current ()
  (if (file-readable-p +gh-profile-state-file)
      (string-trim (with-temp-buffer
                     (insert-file-contents +gh-profile-state-file) (buffer-string)))
    "none"))

(defun +gh-profile-maybe-switch (&optional dir)
  "Run gh-use asynchronously if DIR maps to a profile different from the current one."
  (let* ((dir (or dir default-directory))
         (profile (and +gh-profile-enabled
                       (not (getenv "GH_PROFILE_DISABLED"))
                       (not (file-remote-p dir))
                       (+gh-profile-detect dir))))
    (when (and profile
               (locate-dominating-file dir ".git")          ; only inside a git repo
               (not (equal profile (+gh-profile-current)))
               (not (process-live-p +gh-profile--proc))
               (executable-find "gh-use"))
      (let ((default-directory dir))
        (setq +gh-profile--proc
              (make-process
               :name "gh-use" :buffer " *gh-use*" :noquery t
               :command (list "gh-use" profile)
               :sentinel (lambda (p _e)
                           (when (memq (process-status p) '(exit signal))
                             (message "[gh] %s %s" (car (last (process-command p)))  ; no closure: config.el is dynamic-binding
                                      (if (zerop (process-exit-status p))
                                          "activado"
                                        "FALLÓ (ver buffer *gh-use*)"))))))))))

(after! eshell
  (add-hook 'eshell-directory-change-hook #'+gh-profile-maybe-switch)
  (add-hook 'eshell-mode-hook #'+gh-profile-maybe-switch))

;; vterm usa /bin/fish, así que ya hereda el hook de fish: no hace falta nada.

(defun +gh-profile-status ()
  (interactive)
  (message "[gh] perfil: %s" (+gh-profile-current)))

;; Disable exit confirmation
(setq confirm-kill-emacs nil)

;; Start with eshell
(setq initial-buffer-choice 'eshell)

;; Suppress native compilation warnings
(setq native-comp-async-report-warnings-errors nil)

;; Prevent workspace auto-restore (stops old "client" buffer from appearing)
(after! persp-mode
  (setq persp-auto-resume-time -1))

;; New workspaces open straight into their own eshell
;; (SPC TAB n = automatic name, SPC TAB N = asks for a name)
(defun livey/workspace-new-eshell ()
  "Create a new workspace and open a fresh eshell in it."
  (interactive)
  (+workspace/new)
  (let ((default-directory (expand-file-name "~/")))
    (eshell t)))

(defun livey/workspace-new-named-eshell (name)
  "Create a new workspace called NAME and open a fresh eshell in it."
  (interactive "sWorkspace name: ")
  (+workspace/new name)
  (let ((default-directory (expand-file-name "~/")))
    (eshell t)))

(map! :leader
      :desc "New workspace (eshell)"       "TAB n" #'livey/workspace-new-eshell
      :desc "New named workspace (eshell)" "TAB N" #'livey/workspace-new-named-eshell)

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
;; Never treat the home directory as a project (it hangs indexing ~)
(after! projectile
  (add-to-list 'projectile-ignored-projects "~/"))
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

;; ===== LSP code editor setup (2026-10-16) =====

;; Rust: rust-analyzer as the LSP server
(after! lsp-mode
  (setq lsp-rust-server 'rust-analyzer))

;; Go: gofumpt + organize imports on save
(after! lsp-mode
  (setq lsp-go-use-gofumpt t))
(defun +lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'+lsp-go-install-save-hooks)

;; Corfu (replaces Company): automatic, responsive popup
(after! corfu
  (setq corfu-auto t
        corfu-auto-delay 0.15
        corfu-auto-prefix 2
        corfu-preview-current nil
        corfu-preselect 'prompt))

;; ===== Nix binaries on exec-path (2026-10-16) =====
;; Emacs (daemon) doesn't inherit ~/.nix-profile/bin from the shell, so
;; lsp-mode couldn't find `nil'. Add Nix profile bins idempotently.
(dolist (dir (list (expand-file-name "~/.nix-profile/bin")
                   "/nix/var/nix/profiles/default/bin"))
  (when (file-directory-p dir)
    (add-to-list 'exec-path dir)
    (let ((path (getenv "PATH")))
      (unless (member dir (split-string (or path "") path-separator t))
        (setenv "PATH" (if (and path (not (string-empty-p path)))
                           (concat dir path-separator path)
                         dir))))))

;; 4MB while LSP is active (Doom sets 1MB in +lsp-optimization-mode; this raises it)
(add-hook! '+lsp-optimization-mode-hook
  (defun +lv/lsp-bigger-ipc-h ()
    (when +lsp-optimization-mode
      (setq-default read-process-output-max (* 4 1024 1024)))))
(after! lsp-mode
  (setq lsp-idle-delay 0.3
        lsp-log-io nil
        lsp-inlay-hint-enable t
        lsp-headerline-breadcrumb-enable t
        lsp-headerline-breadcrumb-segments '(project file symbols)
        lsp-lens-enable t
        lsp-enable-file-watchers t
        lsp-file-watch-threshold 5000)
  (dolist (d '("[/\\\\]target\\'" "[/\\\\]node_modules\\'" "[/\\\\]vendor\\'"
               "[/\\\\]\\.direnv\\'" "[/\\\\]result\\'" "[/\\\\]dist\\'"
               "[/\\\\]zig-out\\'" "[/\\\\]\\.zig-cache\\'"
               "[/\\\\]src-tauri[/\\\\]target\\'"))
    (add-to-list 'lsp-file-watch-ignored-directories d)))
(after! lsp-rust
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-proc-macro-enable t
        lsp-rust-analyzer-display-parameter-hints t
        lsp-rust-analyzer-display-chaining-hints t
        lsp-rust-analyzer-display-closure-return-type-hints t))
(after! lsp-ui
  (setq lsp-ui-peek-always-show t))

(setq treesit-auto-install-grammar 'always)
;; Go: organize imports in go-ts-mode too
(add-hook 'go-ts-mode-hook #'+lsp-go-install-save-hooks)

(defun +lv/cargo-bin (&optional subdir)
  "Path to the project's target/debug/<crate> (or SUBDIR, e.g. \"src-tauri\")."
  (let* ((root (file-name-concat (dape-cwd) (or subdir "")))
         (toml (file-name-concat root "Cargo.toml"))
         (name (or (and (file-exists-p toml)
                        (with-temp-buffer
                          (insert-file-contents toml)
                          (and (re-search-forward "^name *= *\"\\([^\"]+\\)\"" nil t)
                               (match-string 1))))
                   (file-name-nondirectory (directory-file-name root)))))
    (file-name-concat root "target" "debug" name)))

(after! dape
  (add-to-list 'dape-configs
               `(rust-lldb
                 modes (rust-mode rust-ts-mode rustic-mode)
                 ensure dape-ensure-command
                 command "lldb-dap"
                 compile "cargo build"
                 :type "lldb-dap" :request "launch"
                 :cwd dape-cwd
                 :program ,(lambda () (+lv/cargo-bin))))
  (add-to-list 'dape-configs
               `(tauri-lldb
                 modes (rust-mode rust-ts-mode rustic-mode typescript-mode typescript-ts-mode web-mode vue-mode)
                 ensure dape-ensure-command
                 command "lldb-dap"
                 compile "cargo build --manifest-path src-tauri/Cargo.toml"
                 :type "lldb-dap" :request "launch"
                 :cwd ,(lambda () (file-name-concat (dape-cwd) "src-tauri"))
                 :program ,(lambda () (+lv/cargo-bin "src-tauri"))))
  (add-to-list 'dape-configs
               `(zig-lldb
                 modes (zig-mode zig-ts-mode)
                 ensure dape-ensure-command
                 command "lldb-dap"
                 compile "zig build"
                 :type "lldb-dap" :request "launch"
                 :cwd dape-cwd
                 :program ,(lambda () (car (file-expand-wildcards
                                             (file-name-concat (dape-cwd) "zig-out" "bin" "*")))))))

(after! apheleia
  ;; Python: ruff (imports + formatting) instead of black
  (dolist (m '(python-mode python-ts-mode))
    (setf (alist-get m apheleia-mode-alist) '(ruff-isort ruff)))
  ;; Go: gofumpt (as requested by lsp-go-use-gofumpt)
  (dolist (m '(go-mode go-ts-mode))
    (setf (alist-get m apheleia-mode-alist) 'gofumpt))
  ;; Nix: nixfmt (RFC style)
  (dolist (m '(nix-mode nix-ts-mode))
    (setf (alist-get m apheleia-mode-alist) 'nixfmt))
  ;; TOML: taplo
  (setf (alist-get 'taplo apheleia-formatters) '("taplo" "format" "-"))
  (dolist (m '(conf-toml-mode toml-ts-mode))
    (setf (alist-get m apheleia-mode-alist) 'taplo))
  ;; PHP/Laravel: project Pint (vendor/bin/pint) if present
  (setf (alist-get 'pint apheleia-formatters)
        '("vendor/bin/pint" "--quiet" inplace)))
(defun +lv/php-use-pint-h ()
  (when (and buffer-file-name (locate-dominating-file buffer-file-name "vendor/bin/pint"))
    (setq-local default-directory (locate-dominating-file buffer-file-name "vendor/bin/pint"))
    (setq-local apheleia-formatter 'pint)))
(add-hook! (php-mode php-ts-mode) #'+lv/php-use-pint-h)

(add-hook! (conf-toml-mode toml-ts-mode) #'lsp-deferred)     ; taplo
;; Only if the server exists (otherwise lsp-mode asks to install and blocks the daemon)
(add-hook! (markdown-mode gfm-mode markdown-ts-mode)
  (defun +lv/markdown-lsp-h () (when (executable-find "marksman") (lsp-deferred))))
(add-hook! 'sql-mode-hook
  (defun +lv/sql-lsp-h () (when (executable-find "sqls") (lsp-deferred))))

(dolist (dir (list (expand-file-name "~/go/bin")
                   (expand-file-name "~/.cargo/bin")
                   (expand-file-name "~/.local/bin")
                   (expand-file-name "~/.config/composer/vendor/bin")))
  (when (file-directory-p dir)
    (add-to-list 'exec-path dir)
    (let ((path (getenv "PATH")))
      (unless (member dir (split-string (or path "") path-separator t))
        (setenv "PATH" (if (and path (not (string-empty-p path)))
                           (concat dir path-separator path)
                         dir))))))

;; ===== IDE extras: peek, multiple cursors, treemacs, forge (2026-10-16) =====
(after! lsp-ui
  (setq lsp-ui-peek-always-show t      ; open the peek window even with one result
        lsp-ui-peek-list-width 50))

(after! treemacs
  (setq treemacs-width 32)
  (treemacs-follow-mode 1))

;; Forge reads the GitHub token through auth-source (~/.authinfo.gpg,
;; machine api.github.com, login USER^forge).  No token lives in this repo.
(after! forge
  (setq forge-owned-accounts '(("ind4skylivey"))))

;; ===== Linux system files (2026-10-16) =====
;; bash-language-server also covers zsh dotfiles (.zshrc, .zshenv).
(after! lsp-bash
  (setq lsp-bash-allowed-shells '(sh bash zsh)))

;; TOML gets LSP through taplo.
(add-hook 'conf-toml-mode-hook #'lsp-deferred)
(add-hook 'toml-ts-mode-hook #'lsp-deferred)

;; Files with no language server open quietly instead of warning.
(after! lsp-mode
  (setq lsp-warn-no-matched-clients nil))

(use-package! systemd :defer t)          ; .service, .timer, .socket, .network
(use-package! ssh-config-mode :defer t)  ; ~/.ssh/config, known_hosts
(use-package! nginx-mode :defer t)       ; nginx.conf, sites-*/
(use-package! git-modes :defer t)        ; .gitconfig, .gitignore, .gitattributes

(load! "keyhelp")
