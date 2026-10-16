;;; keyhelp.el -*- lexical-binding: t; -*-
;; Zellij/tmux-style key helper: one transient menu listing the most used
;; keys. Every entry runs the real command, so it doubles as a launcher.

(require 'transient)

(defvar +lv/emacs-guide-file
  "/media/il1v3y/HD2/HDfiles/DEVS1B/Workflow S1B/Work Asap/memoir/emacs/emacs-guide.org"
  "Personal Emacs guide opened by `+lv/open-emacs-guide'.")

(defun +lv/open-emacs-guide ()
  "Open the personal Emacs guide."
  (interactive)
  (find-file +lv/emacs-guide-file))

(transient-define-prefix +lv/keyhelp ()
  "Key helper: common keys grouped by topic."
  [["Copy/Paste"
    ("v" "visual (v)" evil-visual-char)
    ("y" "yank (y)" evil-yank)
    ("d" "cut (d)" evil-delete)
    ("p" "paste (p)" evil-paste-after)
    ("k" "kill ring (SPC i y)" consult-yank-pop)
    ("u" "undo (u)" evil-undo)
    ("U" "redo (C-r)" evil-redo)]
   ["Buffers"
    ("b" "switch (SPC b b)" consult-buffer)
    ("K" "kill (SPC b k)" kill-current-buffer)
    ("n" "next (] b)" next-buffer)
    ("N" "previous ([ b)" previous-buffer)]
   ["Files"
    ("f" "find file (SPC f f)" find-file)
    ("F" "project file (SPC SPC)" projectile-find-file)
    ("r" "recent (SPC f r)" consult-recent-file)
    ("-" "dired (SPC o -)" dired-jump)]
   ["Windows"
    ("s" "split (SPC w s)" evil-window-split)
    ("S" "vsplit (SPC w v)" evil-window-vsplit)
    ("h" "left (SPC w h)" evil-window-left)
    ("j" "down (SPC w j)" evil-window-down)
    ("l" "right (SPC w l)" evil-window-right)
    ("o" "up (SPC w k)" evil-window-up)
    ("q" "close (SPC w c)" evil-window-delete)]]
  [["LSP"
    ("g" "definition (g d)" lsp-find-definition)
    ("R" "references (g D)" lsp-find-references)
    ("e" "rename (SPC c r)" lsp-rename)
    ("a" "code action (SPC c a)" lsp-execute-code-action)
    ("=" "format (SPC c f)" lsp-format-buffer)
    ("i" "session info" lsp-describe-session)]
   ["Debug"
    ("B" "toggle breakpoint" dape-breakpoint-toggle)
    ("D" "start dape" dape)]
   ["Help"
    ("G" "Emacs guide (SPC h G)" +lv/open-emacs-guide)
    ("?" "describe key (SPC h k)" describe-key)
    ("x" "describe function (SPC h f)" describe-function)]])

(map! :leader
      :desc "Key helper" "?" #'+lv/keyhelp
      (:prefix "h"
       :desc "Open Emacs guide" "G" #'+lv/open-emacs-guide))
