;;; keyhelp.el -*- lexical-binding: t; -*-
;; Zellij/tmux-style key helper for Doom Emacs.
;;
;; `+lv/keyhelp' (SPC ?) is a hub: a few quick columns for everyday keys,
;; plus one letter per area that opens a dedicated sub-menu.  Because the
;; hub reads the next key, `SPC ? g' goes straight to the Git menu, etc.
;;
;; Every entry runs the real command, so the menus double as launchers.
;; The text in parentheses is the native Doom binding.  Only commands that
;; exist in this config are listed.  Evil tips that are not commands are
;; shown as info entries that print a short reminder in the echo area.

(require 'transient)

;;; Guide and tips

(defvar +lv/emacs-guide-file
  "/media/il1v3y/HD2/HDfiles/DEVS1B/Workflow S1B/Work Asap/memoir/emacs/emacs-guide.org"
  "Personal Emacs guide opened by `+lv/open-emacs-guide'.")

(defun +lv/open-emacs-guide ()
  "Open the personal Emacs guide."
  (interactive)
  (find-file +lv/emacs-guide-file))

;;; Search (SPC s)

(transient-define-prefix +lv/keyhelp-search ()
  "Search menu."
  [["In buffer"
    ("s" "search buffer (SPC s s)" +default/search-buffer)
    ("i" "imenu / symbols (SPC s i)" consult-imenu)
    ("o" "outline / headings" consult-outline)
    ("m" "marks (SPC s r)" consult-mark)
    ("M" "global marks" consult-global-mark)
    ("n" "clear highlight" evil-ex-nohighlight)]
   ["In files"
    ("p" "search project (SPC /)" +default/search-project)
    ("d" "search current dir (SPC s d)" +default/search-cwd)
    ("P" "search other project (SPC s P)" +default/search-other-project)
    ("g" "ripgrep" consult-ripgrep)
    ("f" "locate file (SPC s f)" consult-locate)]
   ["Lookup"
    ("w" "online (SPC s o)" +lookup/online)
    ("t" "dictionary (SPC s t)" +lookup/dictionary-definition)
    ("T" "synonyms (SPC s T)" +lookup/synonyms)
    ("N" "notes for symbol (SPC n *)" +default/search-notes-for-symbol-at-point)
    ("'" "repeat last search (SPC ')" vertico-repeat)]])

;;; Git / Magit (SPC g)

(transient-define-prefix +lv/keyhelp-git ()
  "Git and Magit menu."
  [["Magit"
    ("g" "status (SPC g g)" magit-status)
    ("/" "dispatch (SPC g /)" magit-dispatch)
    ("." "file dispatch (SPC g .)" magit-file-dispatch)
    ("c" "commit (SPC g c c)" magit-commit-create)
    ("F" "fetch (SPC g F)" magit-fetch)
    ("p" "pull" magit-pull)
    ("P" "push" magit-push)
    ("z" "stash" magit-stash)]
   ["Branches / repo"
    ("b" "checkout branch (SPC g b)" magit-branch-checkout)
    ("B" "new branch (SPC g c b)" magit-branch-and-checkout)
    ("C" "clone (SPC g C)" magit-clone)
    ("I" "init repo (SPC g c r)" magit-init)
    ("o" "browse at remote (SPC g o o)" +vc/browse-at-remote)]
   ["This file"
    ("l" "log current branch" magit-log-current)
    ("L" "log this file (SPC g L)" magit-log-buffer-file)
    ("a" "blame (SPC g B)" magit-blame-addition)
    ("d" "diff this file" magit-diff-buffer-file)
    ("S" "stage file" magit-stage-buffer-file)
    ("U" "unstage file" magit-unstage-buffer-file)
    ("t" "time machine (SPC g t)" git-timemachine-toggle)]
   ["Hunks (gutter)"
    ("]" "next hunk (SPC g ])" +vc-gutter/next-hunk)
    ("[" "previous hunk (SPC g [)" +vc-gutter/previous-hunk)
    ("h" "show hunk" diff-hl-show-hunk)
    ("s" "stage hunk (SPC g s)" +vc-gutter/stage-hunk)
    ("r" "revert hunk" +vc-gutter/revert-hunk)]])

;;; Projects (SPC p)

(transient-define-prefix +lv/keyhelp-projects ()
  "Projectile menu."
  [["Navigate"
    ("p" "switch project (SPC p p)" projectile-switch-project)
    ("f" "find file (SPC SPC)" projectile-find-file)
    ("r" "recent files (SPC p r)" projectile-recentf)
    ("b" "project buffer (SPC p b)" projectile-switch-to-buffer)
    ("." "browse project (SPC p .)" +default/browse-project)
    ("o" "other file" projectile-find-other-file)
    ("t" "impl <-> test" projectile-toggle-between-implementation-and-test)
    ("d" "project dired" projectile-dired)]
   ["Run"
    ("c" "compile (SPC p c)" projectile-compile-project)
    ("R" "run (SPC p R)" projectile-run-project)
    ("T" "test (SPC p T)" projectile-test-project)
    ("v" "vterm in project" projectile-run-vterm)]
   ["Manage"
    ("a" "add project (SPC p a)" projectile-add-known-project)
    ("x" "remove project (SPC p d)" projectile-remove-known-project)
    ("D" "discover projects (SPC p D)" +default/discover-projects)
    ("i" "invalidate cache (SPC p i)" projectile-invalidate-cache)
    ("s" "save buffers (SPC p s)" projectile-save-project-buffers)
    ("k" "kill buffers (SPC p k)" projectile-kill-buffers)]])

;;; Workspaces (SPC TAB)

(transient-define-prefix +lv/keyhelp-workspaces ()
  "Workspaces menu."
  [["Switch"
    ("TAB" "show workspaces (SPC TAB TAB)" +workspace/display)
    ("." "switch to (SPC TAB .)" +workspace/switch-to)
    ("[" "previous (SPC TAB [)" +workspace/switch-left)
    ("]" "next (SPC TAB ])" +workspace/switch-right)
    ("`" "last used (SPC TAB `)" +workspace/other)]
   ["Edit"
    ("n" "new (SPC TAB n)" +workspace/new)
    ("N" "new named (SPC TAB N)" +workspace/new-named)
    ("r" "rename (SPC TAB r)" +workspace/rename)
    ("d" "kill (SPC TAB d)" +workspace/kill)
    ("<" "move left" +workspace/swap-left)
    (">" "move right" +workspace/swap-right)]
   ["Persist"
    ("s" "save (SPC TAB s)" +workspace/save)
    ("l" "load (SPC TAB l)" +workspace/load)
    ("D" "delete saved (SPC TAB D)" +workspace/delete)
    ("x" "kill session (SPC TAB x)" +workspace/kill-session)]])

;;; Buffers (SPC b)

(transient-define-prefix +lv/keyhelp-buffers ()
  "Buffers menu."
  [["Switch"
    ("b" "workspace buffer (SPC ,)" +vertico/switch-workspace-buffer)
    ("B" "any buffer (SPC <)" consult-buffer)
    ("i" "ibuffer (SPC b i)" ibuffer)
    ("n" "next (] b)" next-buffer)
    ("p" "previous ([ b)" previous-buffer)
    ("x" "scratch (SPC b X)" doom/switch-to-scratch-buffer)
    ("N" "new empty (SPC b N)" evil-buffer-new)]
   ["Save / reload"
    ("s" "save (SPC b s)" save-buffer)
    ("S" "save all (SPC b S)" evil-write-all)
    ("r" "revert (SPC b r)" revert-buffer)
    ("R" "rename (SPC b R)" rename-buffer)
    ("c" "indirect clone (SPC b c)" clone-indirect-buffer)]
   ["Kill"
    ("k" "kill (SPC b k)" kill-current-buffer)
    ("O" "kill others (SPC b O)" doom/kill-other-buffers)
    ("Z" "kill buried (SPC b Z)" doom/kill-buried-buffers)
    ("z" "bury (SPC b z)" bury-buffer)
    ("X" "save and kill (Z X)" doom/save-and-kill-buffer)]
   ["Bookmarks"
    ("m" "set bookmark (SPC b m)" bookmark-set)
    ("j" "jump to bookmark (SPC RET)" bookmark-jump)]])

;;; Files (SPC f)

(transient-define-prefix +lv/keyhelp-files ()
  "Files menu."
  [["Open"
    ("f" "find file (SPC .)" find-file)
    ("F" "find under here (SPC f F)" +default/find-file-under-here)
    ("r" "recent (SPC f r)" consult-recent-file)
    ("o" "other window (C-x 4 C-f)" find-file-other-window)
    ("u" "sudo find (SPC f u)" doom/sudo-find-file)
    ("U" "sudo this file (SPC f U)" doom/sudo-this-file)]
   ["Manage"
    ("R" "move / rename (SPC f R)" doom/move-this-file)
    ("c" "copy (SPC f y)" doom/copy-this-file)
    ("D" "delete (SPC f D)" doom/delete-this-file)
    ("m" "make directory" make-directory)
    ("y" "yank path" +default/yank-buffer-path)
    ("Y" "yank project path (SPC f Y)" +default/yank-buffer-path-relative-to-project)]
   ["Browse"
    ("-" "dired here (SPC o -)" dired-jump)
    ("d" "dired (SPC f d)" +default/dired)
    ("t" "treemacs (SPC o p)" +treemacs/toggle)
    ("T" "treemacs this file (SPC o P)" treemacs-find-file)
    ("p" "private config file (SPC f p)" doom/find-file-in-private-config)
    ("P" "private config dir (SPC f P)" doom/open-private-config)]])

;;; Windows (SPC w)

(transient-define-prefix +lv/keyhelp-windows ()
  "Windows menu.  Movement keys stay open so you can repeat them."
  [["Split / close"
    ("s" "split (SPC w s)" evil-window-split)
    ("v" "vsplit (SPC w v)" evil-window-vsplit)
    ("c" "close (SPC w c)" evil-window-delete)
    ("o" "only this (SPC w O)" delete-other-windows)
    ("m" "maximize (SPC w m m)" doom/window-maximize-buffer)
    ("e" "enlarge (SPC w o)" doom/window-enlargen)]
   ["Move focus"
    ("h" "left (SPC w h)" evil-window-left :transient t)
    ("j" "down (SPC w j)" evil-window-down :transient t)
    ("k" "up (SPC w k)" evil-window-up :transient t)
    ("l" "right (SPC w l)" evil-window-right :transient t)
    ("p" "last window (SPC w p)" evil-window-mru)]
   ["Move window"
    ("H" "far left (SPC w H)" evil-window-move-far-left)
    ("J" "bottom (SPC w J)" evil-window-move-very-bottom)
    ("K" "top (SPC w K)" evil-window-move-very-top)
    ("L" "far right (SPC w L)" evil-window-move-far-right)
    ("x" "exchange (SPC w x)" evil-window-exchange)]
   ["Size / history"
    ("+" "taller (SPC w +)" evil-window-increase-height :transient t)
    ("-" "shorter (SPC w -)" evil-window-decrease-height :transient t)
    (">" "wider (SPC w >)" evil-window-increase-width :transient t)
    ("<" "narrower (SPC w <)" evil-window-decrease-width :transient t)
    ("=" "balance (SPC w =)" balance-windows)
    ("u" "undo layout (SPC w u)" winner-undo)
    ("U" "redo layout (SPC w C-r)" winner-redo)]])

;;; Code / LSP (SPC c)

(transient-define-prefix +lv/keyhelp-code ()
  "Code and LSP menu."
  [["Navigate"
    ("d" "definition (g d)" +lookup/definition)
    ("D" "references (g D)" +lookup/references)
    ("k" "documentation (K)" +lookup/documentation)
    ("i" "implementations (SPC c i)" +lookup/implementations)
    ("t" "type definition (SPC c t)" +lookup/type-definition)
    ("c" "declaration (LSP)" lsp-find-declaration)
    ("j" "workspace symbols (SPC c j)" consult-lsp-symbols)
    ("J" "file symbols" consult-lsp-file-symbols)]
   ["Edit"
    ("r" "rename (SPC c r)" lsp-rename)
    ("a" "code action (SPC c a)" lsp-execute-code-action)
    ("f" "format (SPC c f)" +format/region-or-buffer)
    ("F" "LSP format buffer" lsp-format-buffer)
    ("o" "organize imports (SPC c o)" lsp-organize-imports)
    ("h" "describe at point" lsp-describe-thing-at-point)]
   ["Errors"
    ("x" "errors list (SPC c x)" +default/diagnostics)
    ("X" "LSP diagnostics" consult-lsp-diagnostics)
    ("e" "flycheck list" flycheck-list-errors)]
   ["Build / eval"
    ("C" "compile (SPC c c)" compile)
    ("R" "recompile (SPC c C)" recompile)
    ("E" "eval buffer/region (SPC c e)" +eval/buffer-or-region)]
   ["Server"
    ("s" "start LSP" lsp)
    ("S" "session info" lsp-describe-session)
    ("w" "restart workspace" lsp-workspace-restart)
    ("W" "shutdown workspace" lsp-workspace-shutdown)
    ("b" "breadcrumb toggle" lsp-headerline-breadcrumb-mode)
    ("l" "LSP command map (SPC c l)" +default/lsp-command-map)]])

;;; Debug / dape (SPC d)

(transient-define-prefix +lv/keyhelp-debug ()
  "Dape debugger menu.  Step keys stay open for repeated stepping."
  [["Session"
    ("d" "start (SPC d d)" dape)
    ("r" "restart (SPC d r)" dape-restart)
    ("q" "quit (SPC d q)" dape-quit)
    ("D" "disconnect (SPC d D)" dape-disconnect-quit)
    ("K" "kill" dape-kill)
    ("i" "info panel (SPC d i)" dape-info)
    ("R" "REPL (SPC d R)" dape-repl)]
   ["Breakpoints"
    ("b" "toggle (SPC d b)" dape-breakpoint-toggle)
    ("e" "conditional (SPC d e)" dape-breakpoint-expression)
    ("l" "log point (SPC d l)" dape-breakpoint-log)
    ("B" "remove all (SPC d B)" dape-breakpoint-remove-all)]
   ["Step"
    ("c" "continue (SPC d c)" dape-continue :transient t)
    ("n" "next (SPC d n)" dape-next :transient t)
    ("s" "step in (SPC d s)" dape-step-in :transient t)
    ("o" "step out (SPC d o)" dape-step-out :transient t)
    ("u" "run until point" dape-until :transient t)
    ("p" "pause (SPC d p)" dape-pause)]
   ["Inspect"
    ("w" "watch (SPC d w)" dape-watch-dwim)
    ("x" "evaluate (SPC d x)" dape-evaluate-expression)
    ("S" "select stack (SPC d S)" dape-select-stack)
    ("<" "stack up (SPC d <)" dape-stack-select-up :transient t)
    (">" "stack down (SPC d >)" dape-stack-select-down :transient t)]])

;;; Notes: Org / Roam / Journal (SPC n)

(transient-define-prefix +lv/keyhelp-notes ()
  "Org, Org-roam and journal menu."
  [["Org"
    ("a" "agenda (SPC o A)" org-agenda)
    ("c" "capture (SPC X)" org-capture)
    ("t" "todo list (SPC n t)" org-todo-list)
    ("m" "tags view (SPC n m)" org-tags-view)
    ("v" "search view (SPC n v)" org-search-view)
    ("l" "store link (SPC n l)" org-store-link)]
   ["Notes"
    ("f" "find in notes (SPC n f)" +default/find-in-notes)
    ("F" "browse notes (SPC n F)" +default/browse-notes)
    ("s" "search notes (SPC n s)" +default/org-notes-search)]
   ["Clock"
    ("i" "clock in" org-clock-in)
    ("o" "clock out" org-clock-out)
    ("g" "go to clock (SPC n o)" org-clock-goto)]
   ["Roam"
    ("r" "find node (SPC n r f)" org-roam-node-find)
    ("I" "insert node (SPC n r i)" org-roam-node-insert)
    ("b" "backlinks buffer (SPC n r r)" org-roam-buffer-toggle)
    ("n" "capture node (SPC n r n)" org-roam-capture)
    ("R" "find ref (SPC n r F)" org-roam-ref-find)
    ("G" "graph (SPC n r g)" org-roam-graph)
    ("S" "sync db (SPC n r s)" org-roam-db-sync)]
   ["Dailies / journal"
    ("d" "today (SPC n r d t)" org-roam-dailies-goto-today)
    ("D" "capture today (SPC n r d T)" org-roam-dailies-capture-today)
    ("y" "pick a date (SPC n r d d)" org-roam-dailies-goto-date)
    ("j" "journal entry (SPC n j j)" org-journal-new-entry)
    ("J" "current journal" org-journal-open-current-journal-file)
    ("/" "search journal" org-journal-search)]])

;;; Open / terminals (SPC o)

(transient-define-prefix +lv/keyhelp-open ()
  "Open menu: terminals, shells, REPLs, file browsers."
  [["Terminals"
    ("t" "vterm popup (SPC o t)" +vterm/toggle)
    ("T" "vterm here (SPC o T)" +vterm/here)
    ("v" "new vterm" vterm)
    ("e" "eshell popup (SPC o e)" +eshell/toggle)
    ("E" "eshell here (SPC o E)" +eshell/here)
    ("s" "shell popup" +shell/toggle)
    ("m" "term popup" +term/toggle)]
   ["REPL / apps"
    ("r" "REPL (SPC o r)" +eval/open-repl-other-window)
    ("R" "REPL here (SPC o R)" +eval/open-repl-same-window)
    ("a" "org agenda (SPC o A)" org-agenda)
    ("f" "RSS (elfeed)" =rss)]
   ["Browse"
    ("-" "dired here (SPC o -)" dired-jump)
    ("d" "dired (SPC f d)" +default/dired)
    ("p" "treemacs (SPC o p)" +treemacs/toggle)
    ("P" "treemacs this file (SPC o P)" treemacs-find-file)
    ("n" "neotree" +neotree/open)]
   ["Which terminal?"
    ("?" "terminals tip" (lambda () (interactive) (message "vterm: heavy/interactive jobs. eshell: short commands. SPC p c: builds/tests. kitty: long-running servers/logs. Restarting emacs.service kills vterm/eshell jobs")))]])

;;; Toggles (SPC t)

(transient-define-prefix +lv/keyhelp-toggles ()
  "Toggles menu."
  [["Display"
    ("l" "line numbers (SPC t l)" doom/toggle-line-numbers)
    ("w" "soft wrap (SPC t w)" visual-line-mode)
    ("t" "truncate lines" toggle-truncate-lines)
    ("c" "fill column" display-fill-column-indicator-mode)
    ("h" "highlight line" hl-line-mode)
    ("W" "whitespace" whitespace-mode)
    ("T" "theme (SPC h t)" consult-theme)]
   ["Focus"
    ("b" "big font (SPC t b)" doom-big-font-mode)
    ("z" "zen (SPC t z)" +zen/toggle)
    ("Z" "zen fullscreen (SPC t Z)" +zen/toggle-fullscreen)
    ("F" "frame fullscreen (SPC t F)" toggle-frame-fullscreen)]
   ["Editing"
    ("f" "flycheck (SPC t f)" flycheck-mode)
    ("s" "spell check" flyspell-mode)
    ("r" "read only (SPC t r)" read-only-mode)
    ("g" "evil goggles (SPC t g)" evil-goggles-mode)]
   ["Folding"
    ("a" "toggle fold (z a)" +fold/toggle)
    ("o" "open all (z r)" +fold/open-all)
    ("m" "close all (z m)" +fold/close-all)]])

;;; Insert (SPC i)

(transient-define-prefix +lv/keyhelp-insert ()
  "Insert menu."
  [["Insert"
    ("y" "from kill ring (SPC i y)" +default/yank-pop)
    ("s" "snippet (SPC i s)" yas-insert-snippet)
    ("S" "new snippet" +snippets/new)
    ("u" "unicode char (SPC i u)" insert-char)
    ("e" "emoji" emoji-insert)
    ("E" "search emoji" emoji-search)
    ("f" "file path (SPC i f)" +default/insert-file-path)
    ("r" "register contents (SPC i r)" evil-show-registers)
    ("g" "insert register (C-x r g)" insert-register)]])

;;; Evil essentials

(transient-define-prefix +lv/keyhelp-evil ()
  "Evil essentials: commands plus quick reminders for non-command keys."
  [["Text objects (info)"
    ("w" "iw / aw  word" (lambda () (interactive) (message "ciw change word, daw delete word+space, yiw yank word")))
    ("q" "i\" / a\"  quotes" (lambda () (interactive) (message "ci\" change inside quotes, da' delete quoted with quotes")))
    ("b" "i( / a(  brackets" (lambda () (interactive) (message "ci( / ci{ / ci[ change inside brackets; dab delete block")))
    ("t" "it / at  tags" (lambda () (interactive) (message "cit change inside XML/HTML tag, dat delete whole tag")))
    ("p" "ip / ap  paragraph" (lambda () (interactive) (message "vip select paragraph, dap delete paragraph")))
    ("a" "ia / aa  argument" (lambda () (interactive) (message "cia change function argument, daa delete argument")))]
   ["Macros / registers / marks"
    ("Q" "record macro (q<reg>)" evil-record-macro)
    ("@" "play macro (@<reg>)" evil-execute-macro)
    ("r" "show registers (SPC i r)" evil-show-registers)
    ("\"" "registers how-to" (lambda () (interactive) (message "\"ayy yank into a, \"ap paste from a, \"+y system clipboard")))
    ("m" "set mark (m<x>)" evil-set-marker)
    ("`" "go to mark (`<x>)" evil-goto-mark)
    ("M" "list marks (SPC s r)" evil-show-marks)]
   ["Surround / edit"
    ("S" "surround region (S in visual)" evil-surround-region)
    ("c" "change surround (cs)" evil-surround-change)
    ("d" "delete surround (ds)" evil-surround-delete)
    ("y" "surround how-to" (lambda () (interactive) (message "ysiw) wrap word in (), cs\"' swap quotes, ds( remove parens")))
    ("/" "comment lines (SPC -)" evilnc-comment-or-uncomment-lines)
    ("+" "increment number (g +)" evil-numbers/inc-at-pt)
    ("x" "exchange (g x)" evil-exchange)]
   ["Motion / ex"
    ("s" "snipe (s)" evil-snipe-s)
    ("j" "avy 2 chars (g s s)" evil-avy-goto-char-2)
    ("J" "avy timer (g s /)" avy-goto-char-timer)
    ("o" "jump back (C-o)" evil-jump-backward :transient t)
    ("i" "jump forward (C-i)" evil-jump-forward :transient t)
    (":" "ex command (:)" evil-ex)
    ("%" "substitute how-to" (lambda () (interactive) (message ":%%s/old/new/g whole file, :s/x/y/ line, add c to confirm; in visual :'<,'>s/x/y/g")))]])

;;; Help / Doom (SPC h)

(transient-define-prefix +lv/keyhelp-help ()
  "Help and Doom menu."
  [["Describe"
    ("k" "key (SPC h k)" helpful-key)
    ("f" "function (SPC h f)" helpful-callable)
    ("v" "variable (SPC h v)" helpful-variable)
    ("m" "mode (SPC h m)" describe-mode)
    ("F" "face (SPC h F)" describe-face)
    ("c" "char at point" describe-char)
    ("b" "bindings (SPC h b b)" embark-bindings)
    ("a" "apropos command" apropos-command)]
   ["Doom"
    ("r" "reload config (SPC h r r)" doom/reload)
    ("d" "Doom manual (SPC h d h)" doom/help)
    ("M" "modules (SPC h d m)" doom/help-modules)
    ("p" "packages (SPC h p)" doom/help-packages)
    ("s" "search docs (SPC h d s)" doom/help-search-headings)
    ("S" "search docs full (SPC h d S)" doom/help-search)
    ("q" "FAQ (SPC h d f)" doom/help-faq)
    ("u" "autodefs (SPC h u)" doom/help-autodefs)
    ("V" "version (SPC h d v)" doom/version)
    ("I" "doctor / info how-to" (lambda () (interactive) (message "In a terminal: doom doctor, doom info, doom sync, doom upgrade")))]
   ["Tools"
    ("G" "Emacs guide (SPC h G)" +lv/open-emacs-guide)
    ("e" "messages (SPC h e)" view-echo-area-messages)
    ("i" "info manuals (SPC h i)" info)
    ("E" "elisp sandbox (SPC h E)" doom/sandbox)
    ("T" "profiler (SPC h T)" doom/toggle-profiler)
    ("t" "top-level keys (SPC h b t)" which-key-show-top-level)]
   ["Embark / consult"
    ("." "embark act (SPC a)" embark-act)
    ("RET" "embark dwim" embark-dwim)
    ("x" "embark export (in minibuffer)" embark-export)
    ("'" "repeat last search (SPC ')" vertico-repeat)
    ("h" "minibuffer history" consult-history)
    ("?" "tricks" (lambda () (interactive) (message "In any minibuffer: C-; embark act, C-c C-e export to editable buffer, M-RET take input as-is")))]])

;;; Quit / session (SPC q)

(transient-define-prefix +lv/keyhelp-session ()
  "Quit and session menu."
  [["Session"
    ("s" "quicksave session (SPC q s)" doom/quicksave-session)
    ("l" "quickload session (SPC q l)" doom/quickload-session)
    ("F" "kill all buffers (SPC q F)" doom/kill-all-buffers)]
   ["Quit / restart"
    ("q" "close frame (SPC q q)" save-buffers-kill-terminal)
    ("K" "kill Emacs (SPC q K)" save-buffers-kill-emacs)
    ("r" "restart and restore (SPC q r)" doom/restart-and-restore)
    ("R" "restart (SPC q R)" doom/restart)
    ("d" "restart server (SPC q d)" +default/restart-server)]])

;;; IDE extras (peek, multiple cursors, treemacs, forge)

(transient-define-prefix +lv/keyhelp-ide ()
  "Menu for lsp-ui peek, evil-mc, evil-multiedit, treemacs and forge."
  [["Peek (lsp-ui)"
    ("d" "peek definitions (g d)" lsp-ui-peek-find-definitions)
    ("r" "peek references (g D)" lsp-ui-peek-find-references)
    ("i" "peek implementations" lsp-ui-peek-find-implementation)
    ("s" "peek workspace symbol" lsp-ui-peek-find-workspace-symbol)
    ("k" "doc glance" lsp-ui-doc-glance)]
   ["Multiple cursors (evil-mc, g z)"
    ("m" "cursors on all matches (g z m)" evil-mc-make-all-cursors)
    ("n" "cursor + next match (g z d)" evil-mc-make-and-goto-next-match :transient t)
    ("N" "cursor + prev match (g z D)" evil-mc-make-and-goto-prev-match :transient t)
    ("j" "skip, next match (g z s)" evil-mc-skip-and-goto-next-match :transient t)
    ("z" "cursor here (g z z)" +multiple-cursors/evil-mc-toggle-cursor-here)
    ("u" "undo last cursor (g z u)" +multiple-cursors/evil-mc-undo-cursor :transient t)
    ("q" "remove all cursors (g z q)" evil-mc-undo-all-cursors)
    ("t" "pause/resume cursors (g z t)" +multiple-cursors/evil-mc-toggle-cursors)]
   ["Multiedit"
    ("a" "match all (R in visual)" evil-multiedit-match-all)
    ("e" "match + next (M-d in visual)" evil-multiedit-match-and-next :transient t)
    ("E" "match + prev (M-D in visual)" evil-multiedit-match-and-prev :transient t)
    ("x" "toggle / restrict region" evil-multiedit-toggle-or-restrict-region)
    ("X" "abort" evil-multiedit-abort)]
   ["Treemacs / Forge"
    ("T" "toggle treemacs (SPC o p)" +treemacs/toggle)
    ("f" "treemacs: this file (SPC o P)" treemacs-find-file)
    ("w" "select treemacs window" treemacs-select-window)
    ("p" "forge: list PRs" forge-list-pullreqs)
    ("I" "forge: list issues" forge-list-issues)
    ("c" "forge: create PR" forge-create-pullreq)
    ("C" "forge: create issue" forge-create-issue)
    ("F" "forge: pull topics" forge-pull)]])

;;; Contextual key bar (zellij-style)
;;
;; One line in the tab bar showing the most useful keys for the major mode
;; of the selected window.  The text is cached and only recomputed from
;; window/buffer change hooks, so redisplay just reads a variable.

(defvar +lv/ctxbar-hints
  '(((magit-status-mode magit-mode)
     . "s stage  u unstage  c c commit  P p push  F p pull  b b branch  l l log  TAB fold  ? help  q quit")
    ((dired-mode)
     . "RET open  - up  C copy  R rename  D delete  + mkdir  m mark  u unmark  i edit-names  ( details  q quit")
    ((rustic-mode rust-mode rust-ts-mode)
     . "gd def  gD refs  K doc  SPC c a action  SPC c r rename  SPC c f format  SPC p c build  SPC d d debug  SPC ? I peek/cursors")
    ((go-mode go-ts-mode)
     . "gd def  gD refs  K doc  SPC c a action  SPC c r rename  SPC c f format  SPC p T test  SPC d d debug")
    ((typescript-mode typescript-ts-mode tsx-ts-mode js-mode js-ts-mode web-mode vue-mode)
     . "gd def  gD refs  K doc  SPC c a action  SPC c r rename  SPC c f format  SPC c x errors  SPC p R run")
    ((org-mode)
     . "TAB fold  M-RET item  t todo  SPC m s subtree  SPC m l link  SPC m d date  SPC m e export  SPC n r f roam")
    ((vterm-mode)
     . "C-c C-t copy-mode  SPC o t popup  SPC o T here  C-c C-c interrupt  servers: kitty")
    ((eshell-mode)
     . "C-c C-c interrupt  M-r history  SPC o e popup  heavy-output: vterm")
    ((prog-mode)
     . "gd def  K doc  SPC c a action  SPC c r rename  SPC s i symbols  g z m cursors  SPC ? I extras"))
  "Alist of (MODES . HINT) used by `+lv/ctxbar-mode', first match wins.")

(defvar +lv/ctxbar--text "")

(defun +lv/ctxbar--hint (buffer)
  (with-current-buffer buffer
    (or (cl-loop for (modes . hint) in +lv/ctxbar-hints
                 when (cl-some #'derived-mode-p modes) return hint)
        "SPC ? key-helper  SPC . find-file  SPC , buffers  SPC t k hide-bar")))

(defun +lv/ctxbar--propertize (hint)
  "Highlight the key part of each double-space separated HINT chunk."
  (mapconcat
   (lambda (chunk)
     (if (string-match "\\`\\(.*?\\) \\([^ ]+\\)\\'" chunk)
         (concat (propertize (match-string 1 chunk) 'face 'font-lock-keyword-face)
                 " " (propertize (match-string 2 chunk) 'face
                                 '(:foreground "#e0def4")))
       chunk))
   (split-string hint "  " t) "  "))

(defun +lv/ctxbar-update (&rest _)
  "Recompute the bar text for the selected window, only when it changes."
  (let ((buf (window-buffer (selected-window))))
    (unless (or (minibufferp buf)
                (string-prefix-p " " (buffer-name buf)))
      (let ((text (concat " " (+lv/ctxbar--propertize (+lv/ctxbar--hint buf)))))
        (unless (equal text +lv/ctxbar--text)
          (setq +lv/ctxbar--text text)
          (force-mode-line-update t))))))

(defun +lv/ctxbar--format ()
  `((lv-ctxbar menu-item ,+lv/ctxbar--text ignore)))

(defvar +lv/ctxbar--saved nil)

;; Zen mode (writeroom) hides the tab bar and doesn't bring it back.
(defun +lv/ctxbar--reshow (&rest _)
  "Make the tab bar visible again on every frame when the bar is on."
  (when (and (bound-and-true-p +lv/ctxbar-mode)
             (not (bound-and-true-p writeroom-mode)))
    (dolist (f (frame-list))
      (set-frame-parameter f 'tab-bar-lines 1))))

(add-hook 'writeroom-mode-hook #'+lv/ctxbar--reshow)

(define-minor-mode +lv/ctxbar-mode
  "Show context-aware key hints in the tab bar (zellij-style)."
  :global t
  (if +lv/ctxbar-mode
      (progn
        (setq +lv/ctxbar--saved (list tab-bar-format (bound-and-true-p tab-bar-mode)))
        (setq tab-bar-format '(+lv/ctxbar--format))
        (add-hook 'window-buffer-change-functions #'+lv/ctxbar-update)
        (add-hook 'window-selection-change-functions #'+lv/ctxbar-update)
        (add-hook 'after-change-major-mode-hook #'+lv/ctxbar-update)
        (+lv/ctxbar-update)
        (setq tab-bar-show t)
        (tab-bar-mode 1)
        (+lv/ctxbar--reshow))
    (remove-hook 'window-buffer-change-functions #'+lv/ctxbar-update)
    (remove-hook 'window-selection-change-functions #'+lv/ctxbar-update)
    (remove-hook 'after-change-major-mode-hook #'+lv/ctxbar-update)
    (when +lv/ctxbar--saved
      (setq tab-bar-format (car +lv/ctxbar--saved))
      (unless (cadr +lv/ctxbar--saved) (tab-bar-mode -1)))))

(defun +lv/ctxbar-toggle ()
  "Toggle the contextual key bar."
  (interactive)
  (+lv/ctxbar-mode 'toggle)
  (message "Context key bar %s" (if +lv/ctxbar-mode "on" "off")))

(add-hook 'doom-first-buffer-hook #'+lv/ctxbar-mode)

;;; Hub (SPC ?)

(transient-define-prefix +lv/keyhelp ()
  "Key helper hub: quick keys plus one sub-menu per area."
  [["Menus"
    ("s" "Search (SPC s) ..." +lv/keyhelp-search)
    ("g" "Git (SPC g) ..." +lv/keyhelp-git)
    ("p" "Projects (SPC p) ..." +lv/keyhelp-projects)
    ("TAB" "Workspaces (SPC TAB) ..." +lv/keyhelp-workspaces)
    ("b" "Buffers (SPC b) ..." +lv/keyhelp-buffers)
    ("f" "Files (SPC f) ..." +lv/keyhelp-files)
    ("w" "Windows (SPC w) ..." +lv/keyhelp-windows)
    ("c" "Code / LSP (SPC c) ..." +lv/keyhelp-code)]
   ["  "
    ("d" "Debug (SPC d) ..." +lv/keyhelp-debug)
    ("n" "Notes / Org (SPC n) ..." +lv/keyhelp-notes)
    ("o" "Open / terminals (SPC o) ..." +lv/keyhelp-open)
    ("t" "Toggles (SPC t) ..." +lv/keyhelp-toggles)
    ("i" "Insert (SPC i) ..." +lv/keyhelp-insert)
    ("e" "Evil essentials ..." +lv/keyhelp-evil)
    ("h" "Help / Doom (SPC h) ..." +lv/keyhelp-help)
    ("Q" "Quit / session (SPC q) ..." +lv/keyhelp-session)
    ("I" "IDE extras: peek, cursors, treemacs, forge ..." +lv/keyhelp-ide)
    ("?" "context key bar on/off (SPC t k)" +lv/ctxbar-toggle)]
   ["Copy/Paste"
    ("v" "visual (v)" evil-visual-char)
    ("y" "yank (y)" evil-yank)
    ("x" "cut (d)" evil-delete)
    ("P" "paste (p)" evil-paste-after)
    ("k" "kill ring (SPC i y)" consult-yank-pop)
    ("u" "undo (u)" evil-undo)
    ("U" "redo (C-r)" evil-redo)]
   ["Quick"
    ("B" "switch buffer (SPC <)" consult-buffer)
    ("K" "kill buffer (SPC b k)" kill-current-buffer)
    ("F" "find file (SPC .)" find-file)
    ("SPC" "project file (SPC SPC)" projectile-find-file)
    ("r" "recent file (SPC f r)" consult-recent-file)
    ("-" "dired (SPC o -)" dired-jump)
    ("G" "Emacs guide (SPC h G)" +lv/open-emacs-guide)]]
  [("q" "quit" transient-quit-one)])

(map! :leader
      :desc "Key helper" "?" #'+lv/keyhelp
      (:prefix "h"
       :desc "Open Emacs guide" "G" #'+lv/open-emacs-guide)
      (:prefix "t"
       :desc "Context key bar" "k" #'+lv/ctxbar-toggle))
