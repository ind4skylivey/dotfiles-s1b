;;; s1b-neon.el --- S1B neon layer over doom-outrun-electric -*- lexical-binding: t; -*-
;;
;; Loaded from config.org (THEME > S1B neon layer) via (load! "s1b-neon").
;; Faces are registered with `custom-theme-set-faces!' for doom-outrun-electric
;; only, so doom-s1b-cyber-light is untouched.  Faces already overridden in
;; config.org (bg #341c5e, solaire #26154a, #ff1744 accents, mode-line,
;; hl-line, region, line numbers, minibuffer-prompt, error, warning,
;; org-level-1, show-paren, cursor) are deliberately NOT repeated here:
;; config.org wins for those.

(require 'cl-lib)

;;; Faces (dark theme only)

(defun livey/neon--spec (face fg &optional style)
  `(,face :foreground ,fg
          :weight ,(if (eq style 'bold) 'bold 'normal)
          :slant ,(if (eq style 'italic) 'italic 'normal)))

(defvar livey/neon-faces
  '((eshell-ls-directory "#00f0ff" bold) (eshell-ls-executable "#39ff14" bold)
    (eshell-ls-symlink "#ff79c6" italic) (eshell-ls-archive "#ff9f1c")
    (eshell-ls-readonly "#ff2e63") (eshell-ls-special "#f7f700" bold)
    (eshell-ls-backup "#7a6a9e") (eshell-ls-missing "#ff2e63" bold)
    (eshell-ls-product "#9d7bff") (eshell-ls-clutter "#7a6a9e")
    (eshell-prompt "#ff2e63" bold)
    (font-lock-keyword-face "#ff2e63" bold) (font-lock-builtin-face "#ff79c6")
    (font-lock-function-name-face "#d98cff" bold) (font-lock-variable-name-face "#00f0ff")
    (font-lock-string-face "#39ff14") (font-lock-constant-face "#ff9f1c" bold)
    (font-lock-type-face "#f7f700") (font-lock-comment-face "#8a7ab8" italic)
    (font-lock-doc-face "#a98bd9" italic)
    (org-level-2 "#00f0ff" bold) (org-level-3 "#d98cff" bold)
    (org-level-4 "#39ff14" bold) (org-level-5 "#ff9f1c" bold) (org-link "#00f0ff")
    (org-code "#39ff14") (org-verbatim "#ff79c6") (org-todo "#ff2e63" bold) (org-done "#39ff14" bold)
    (markdown-header-face-1 "#ff2e63" bold) (markdown-header-face-2 "#00f0ff" bold)
    (markdown-header-face-3 "#d98cff" bold) (markdown-header-face-4 "#39ff14" bold)
    (markdown-link-face "#00f0ff") (markdown-url-face "#ff79c6" italic)
    (markdown-inline-code-face "#39ff14") (markdown-code-face "#39ff14")
    (markdown-bold-face "#ff9f1c" bold) (markdown-italic-face "#ff79c6" italic)
    (link "#00f0ff") (warning "#ff9f1c" bold) (success "#39ff14" bold)
    (doom-modeline-buffer-file "#00f0ff" bold) (doom-modeline-buffer-path "#d98cff")
    (rainbow-delimiters-depth-1-face "#ff2e63" bold) (rainbow-delimiters-depth-2-face "#00f0ff" bold)
    (rainbow-delimiters-depth-3-face "#39ff14" bold) (rainbow-delimiters-depth-4-face "#d98cff" bold)
    (rainbow-delimiters-depth-5-face "#ff9f1c" bold) (rainbow-delimiters-depth-6-face "#f7f700" bold)
    (rainbow-delimiters-depth-7-face "#ff79c6" bold) (rainbow-delimiters-depth-8-face "#00f0ff" bold)
    (rainbow-delimiters-depth-9-face "#39ff14" bold))
  "(FACE FG [bold|italic]) neon palette for doom-outrun-electric.")

;; `custom-theme-set-faces!' is a macro, so splice the generated specs into it.
(eval `(custom-theme-set-faces! 'doom-outrun-electric
         ,@(mapcar (lambda (p) `',(apply #'livey/neon--spec p)) livey/neon-faces))
      t)

;; Markdown/org files in eshell `ls'
(defface livey/eshell-ls-markdown '((t :foreground "#ff79c6" :weight bold))
  "Markdown/org files in eshell ls.")
(defun livey/eshell-ls-md-face (orig file)
  (let ((name (funcall orig file)))
    (if (and (stringp name) (string-match-p "\\.\\(md\\|org\\)\\'" (car file)) (not (cadr file)))
        (propertize (substring-no-properties name) 'font-lock-face 'livey/eshell-ls-markdown)
      name)))
(with-eval-after-load 'em-ls
  (advice-add 'eshell-ls-decorated-name :around #'livey/eshell-ls-md-face))

;; Rainbow delimiters in code
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;; Eshell two-line prompt (+ last command duration and clock)

(defvar-local livey/eshell-cmd-start nil)
(defvar-local livey/eshell-last-duration nil)
(defun livey/eshell-cmd-start () (setq livey/eshell-cmd-start (float-time)))
(defun livey/eshell-cmd-end ()
  (when livey/eshell-cmd-start
    (setq livey/eshell-last-duration (- (float-time) livey/eshell-cmd-start)
          livey/eshell-cmd-start nil)))
(add-hook 'eshell-pre-command-hook #'livey/eshell-cmd-start)
(add-hook 'eshell-post-command-hook #'livey/eshell-cmd-end)

(defun livey/fmt-duration (s)
  (cond ((< s 60) (format "%.1fs" s))
        ((< s 3600) (format "%dm%02ds" (/ (truncate s) 60) (% (truncate s) 60)))
        (t (format "%dh%02dm" (/ (truncate s) 3600) (/ (% (truncate s) 3600) 60)))))

(defun livey/eshell-prompt ()
  (let ((b (and (fboundp 'magit-get-current-branch) (magit-get-current-branch)))
        (d livey/eshell-last-duration))
    (concat
     (propertize "┌─[" 'face '(:foreground "#d98cff"))
     (propertize (user-login-name) 'face '(:foreground "#ff2e63" :weight bold))
     (propertize "@" 'face '(:foreground "#d98cff"))
     (propertize (system-name) 'face '(:foreground "#00f0ff" :weight bold))
     (propertize "]─[" 'face '(:foreground "#d98cff"))
     (propertize (abbreviate-file-name (eshell/pwd)) 'face '(:foreground "#39ff14"))
     (propertize "]" 'face '(:foreground "#d98cff"))
     (if b (propertize (concat " ⎇ " b) 'face '(:foreground "#ff9f1c")) "")
     (if (and d (>= d 0.5))
         (propertize (concat " ⏱ " (livey/fmt-duration d))
                     'face `(:foreground ,(if (>= d 10) "#ff2e63" "#f7f700") :weight bold))
       "")
     (propertize (format-time-string " 🕒 %H:%M:%S") 'face '(:foreground "#8a7ab8"))
     "\n"
     (propertize "└─ ☠ " 'face '(:foreground "#ff2e63"))
     (propertize "λ" 'face `(:foreground ,(if (and (boundp 'eshell-last-command-status)
                                                    (not (zerop eshell-last-command-status)))
                                               "#ff2e63" "#39ff14")
                                  :weight bold))
     " ")))

;; Doom's eshell module sets its own prompt in (after! eshell), so set ours after it.
(after! eshell
  (setq eshell-prompt-function #'livey/eshell-prompt
        eshell-prompt-regexp "^└─ ☠ λ "))

;;; SEC lab (eshell aliases: cd / dired only, scans are launched by hand)

(defvar livey/sec-root "/media/il1v3y/HD2/SEC/")
(defun livey/sec (sub) (expand-file-name sub livey/sec-root))
(defun eshell/sec (&rest _) (eshell/cd livey/sec-root))
(defun eshell/vuls-dir (&rest _) (eshell/cd (livey/sec "vuls/scripts")))
(defun eshell/trivy-dir (&rest _) (eshell/cd (livey/sec "trivy/scripts")))
(defun eshell/wazuh-dir (&rest _) (eshell/cd (livey/sec "wazuh")))
(defun eshell/gvm-dir (&rest _) (eshell/cd (livey/sec "greenbone/scripts")))
(defun eshell/vuls-results (&rest _) (dired (livey/sec "vuls/results")) nil)
(defun eshell/trivy-reports (&rest _) (dired (livey/sec "trivy/reports")) nil)
(defun eshell/sec-help (&rest _)
  (concat "sec · vuls-dir · trivy-dir · wazuh-dir · gvm-dir · vuls-results · trivy-reports\n"
          "scripts: vuls/scripts/{scan-localhost,scan-ubuntu-lab,report}.sh · trivy/scripts/{scan-image,scan-fs-sec,scan-s1blab-images}.sh\n"))

;;; Dashboard: S1B GR0UP banner + SEC entries (needs :ui doom-dashboard)

(defun livey/s1b-banner ()
  (let ((lines '("███████╗ ██╗██████╗      ██████╗ ██████╗  ██████╗ ██╗   ██╗██████╗ "
                 "██╔════╝███║██╔══██╗    ██╔════╝ ██╔══██╗██╔═████╗██║   ██║██╔══██╗"
                 "███████╗╚██║██████╔╝    ██║  ███╗██████╔╝██║██╔██║██║   ██║██████╔╝"
                 "╚════██║ ██║██╔══██╗    ██║   ██║██╔══██╗████╔╝██║██║   ██║██╔═══╝ "
                 "███████║ ██║██████╔╝    ╚██████╔╝██║  ██║╚██████╔╝╚██████╔╝██║     "
                 "╚══════╝ ╚═╝╚═════╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝     "
                 ""
                 "        [ red team · purple team · blue team ] :: hack the planet"))
        (cols '("#ff2e63" "#ff2e63" "#d98cff" "#d98cff" "#00f0ff" "#00f0ff" "#000" "#39ff14")))
    (cl-loop for l in lines for c in cols
             do (insert (propertize (+doom-dashboard--center +doom-dashboard--width l)
                                    'face `(:foreground ,c :weight bold))
                        "\n"))
    (insert "\n")))

(defun livey/sec-open (sub)
  "Open SUB under `livey/sec-root' (dired for dirs, find-file otherwise)."
  (let ((path (livey/sec sub)))
    (if (file-directory-p path) (dired path) (find-file path))))
(defun livey/sec-open-root () (interactive) (livey/sec-open ""))
(defun livey/sec-open-vuls-results () (interactive) (livey/sec-open "vuls/results"))
(defun livey/sec-open-trivy-reports () (interactive) (livey/sec-open "trivy/reports"))
(defun livey/sec-open-wazuh () (interactive) (livey/sec-open "wazuh"))
(defun livey/sec-open-greenbone () (interactive) (livey/sec-open "greenbone"))
(defun livey/sec-open-roadmap () (interactive) (livey/sec-open "ROADMAP-aprendizaje.md"))

;; Doom's dashboard wants a command symbol as :action.
(defvar livey/sec-dashboard-items
  '(("☠ SEC lab"        . livey/sec-open-root)
    ("🛰 Vuls results"   . livey/sec-open-vuls-results)
    ("🔍 Trivy reports"  . livey/sec-open-trivy-reports)
    ("🛡 Wazuh"          . livey/sec-open-wazuh)
    ("🧪 Greenbone"      . livey/sec-open-greenbone)
    ("🗺 Roadmap SEC"    . livey/sec-open-roadmap)))

(when (modulep! :ui doom-dashboard)
  (setq +doom-dashboard-ascii-banner-fn #'livey/s1b-banner)
  ;; The module's config.el runs before this file, so the menu list exists.
  (dolist (it livey/sec-dashboard-items)
    (let ((label (car it)))
      (setq +doom-dashboard-menu-sections
            (cl-remove label +doom-dashboard-menu-sections :key #'car :test #'equal))
      (add-to-list '+doom-dashboard-menu-sections
                   `(,label :icon nil :face (:foreground "#ff2e63" :weight bold)
                            :action ,(cdr it))
                   t))))

;;; Modeline task timer (SPC o z / SPC o Z)

(defvar livey/task-name nil)
(defvar livey/task-start-time nil)
(defvar livey/task-timer nil)

(defun livey/task-mode-line ()
  (when livey/task-start-time
    (propertize (format " ⏱ %s %s " livey/task-name
                        (livey/fmt-duration (- (float-time) livey/task-start-time)))
                'face '(:foreground "#0d0221" :background "#ff2e63" :weight bold))))

(unless (member '(:eval (livey/task-mode-line)) global-mode-string)
  (setq global-mode-string (append global-mode-string '((:eval (livey/task-mode-line))))))

(defun livey/task-start (name)
  "Start the modeline stopwatch for task NAME."
  (interactive "sTarea: ")
  (setq livey/task-name (if (string-empty-p name) "tarea" name)
        livey/task-start-time (float-time))
  (when livey/task-timer (cancel-timer livey/task-timer))
  (setq livey/task-timer (run-at-time 0 1 #'force-mode-line-update t))
  (message "⏱ %s iniciada" livey/task-name))

(defun livey/task-stop ()
  "Stop the modeline stopwatch and show the total."
  (interactive)
  (if (not livey/task-start-time)
      (message "No hay tarea corriendo")
    (let ((d (- (float-time) livey/task-start-time)))
      (when livey/task-timer (cancel-timer livey/task-timer))
      (message "⏱ %s: %s" livey/task-name (livey/fmt-duration d))
      (setq livey/task-start-time nil livey/task-timer nil)
      (force-mode-line-update t))))

(map! :leader
      :desc "Start task timer" "o z" #'livey/task-start
      :desc "Stop task timer"  "o Z" #'livey/task-stop)

;;; s1b-neon.el ends here
