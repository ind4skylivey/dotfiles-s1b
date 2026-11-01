;;; cheatsheet.el -*- lexical-binding: t; -*-
;; Floating key cheatsheet, tmux-style (SPC h j).  q closes, j/k scroll.
;; Every SPC key below was checked against the live leader map (2026-11-01).

(defvar +lv/cheatsheet-sections
  '(("START HERE"
     ("SPC" "wait 0.3s: menu") ("SPC ?" "key helper hub") ("SPC h j" "this cheatsheet")
     ("SPC b h" "dashboard (home)") ("SPC `" "back to last buffer") ("SPC b k" "close buffer")
     ("ESC · C-g" "cancel anything") ("SPC :" "M-x (any cmd)"))
    ("QUIT / SESSION"
     ("SPC q f" "close frame (daemon)") ("SPC q q" "quit Emacs") ("SPC q r" "restart+restore")
     ("SPC q R" "restart") ("SPC q s · l" "quicksave · load")
     ("SPC q S · L" "save · load session") ("SPC q d" "restart server"))
    ("EVIL MOVE"
     ("h j k l" "left down up right") ("w · b · e" "word fwd · back · end") ("0 · ^ · $" "line start · text · end")
     ("gg · G" "top · bottom") ("C-d · C-u" "half page down · up") ("% " "matching bracket")
     ("f x · t x" "jump to / before x") ("C-o · C-i" "jump back · fwd"))
    ("EVIL EDIT"
     ("i · a · o" "insert · append · newline") ("I · A · O" "line start · end · above")
     ("v · V · C-v" "visual char·line·block") ("y · d · c" "yank · cut · change")
     ("yy · dd · cc" "whole line") ("p · P" "paste after · before") ("u · C-r" "undo · redo")
     ("." "repeat last") ("ciw · ci\"" "change word · in quotes") ("gc" "comment") ("> · <" "indent · outdent"))
    ("SEARCH"
     ("/ · ?" "search fwd · back") ("n · N" "next · prev") ("*" "word under cursor")
     ("SPC s s" "search buffer") ("SPC /" "search project") ("SPC *" "symbol in project")
     ("SPC s i" "imenu (outline)") ("SPC '" "resume last search") ("SPC s u" "undo tree (vundo)")
     ("SPC s m" "jump bookmark") ("SPC s l" "open link (hints)"))
    ("FILES"
     ("SPC SPC" "file in project") ("SPC ." "find file") ("SPC f r" "recent files")
     ("SPC f s" "save") ("SPC f S" "save as") ("SPC f R" "rename/move file")
     ("SPC f D" "delete file") ("SPC f U" "sudo this file") ("SPC f y" "copy file path")
     ("SPC f p" "private config") ("SPC o -" "dired here"))
    ("BUFFERS"
     ("SPC ," "workspace buffers") ("SPC <" "all buffers") ("SPC b n · p" "next · prev")
     ("SPC b k" "kill buffer") ("SPC b O" "kill others") ("SPC b N" "new empty")
     ("SPC b x" "scratch") ("SPC b r" "revert (reload)") ("SPC b i" "ibuffer list")
     ("SPC b m" "set bookmark") ("SPC b u" "sudo save"))
    ("WINDOWS"
     ("SPC w v · s" "split vert · horiz") ("SPC w V · S" "split + follow") ("SPC w h j k l" "move focus")
     ("SPC w H J K L" "move window") ("SPC w d" "close window") ("SPC w C-o" "only this window")
     ("SPC w o" "enlarge") ("SPC w =" "balance") ("SPC w u · C-r" "undo · redo layout")
     ("SPC w w" "next window") ("SPC w x" "swap"))
    ("WORKSPACES"
     ("SPC TAB TAB" "show workspaces") ("SPC TAB 1…9" "go to workspace") ("SPC TAB [ · ]" "prev · next")
     ("SPC TAB n" "new + eshell") ("SPC TAB N" "new named + eshell") ("SPC TAB r" "rename")
     ("SPC TAB d" "kill workspace") ("SPC TAB s · l" "save · load"))
    ("PROJECTS"
     ("SPC p p" "switch project") ("SPC p f" "find file") ("SPC p r" "recent in project")
     ("SPC p b" "project buffers") ("SPC p k" "kill project bufs") ("SPC p c" "compile")
     ("SPC p T" "test") ("SPC p a" "add project") ("SPC p !" "shell cmd in root"))
    ("CODE / LSP"
     ("SPC c d · gd" "go to definition") ("SPC c D" "references") ("SPC c k · K" "documentation")
     ("SPC c a" "code action") ("SPC c r" "rename symbol") ("SPC c f" "format")
     ("SPC c o" "organize imports") ("SPC c x" "diagnostics list") ("SPC c j" "workspace symbols")
     ("SPC c e" "eval buffer/region") ("SPC c c" "compile"))
    ("DEBUG (dape)"
     ("SPC d d" "start debugger") ("SPC d b" "toggle breakpoint") ("SPC d c" "continue")
     ("SPC d n" "next") ("SPC d s · o" "step in · out") ("SPC d w" "watch")
     ("SPC d R" "REPL") ("SPC d q" "quit"))
    ("GIT"
     ("SPC g g" "magit status") ("SPC g b" "checkout branch") ("SPC g B" "blame")
     ("SPC g L" "log this file") ("SPC g [ · ]" "prev · next hunk") ("SPC g s" "stage hunk")
     ("SPC g r" "revert hunk") ("SPC g t" "time machine") ("SPC g F" "fetch") ("SPC g '" "forge"))
    ("OPEN / TERMINALS"
     ("SPC o t · T" "vterm popup · here") ("SPC o e · E" "eshell popup · here") ("SPC o y" "yazi")
     ("SPC o p" "treemacs") ("SPC o D" "docker") ("SPC o r" "REPL") ("SPC o A" "agenda")
     ("SPC o z · Z" "task start · stop") ("SPC o f" "new frame"))
    ("NOTES / ORG"
     ("SPC X · SPC n n" "capture") ("SPC n a" "agenda") ("SPC n t" "todo list")
     ("SPC n f" "find in notes") ("SPC n s" "search notes") ("SPC n l" "store link")
     ("SPC m e" "export (in org)") ("TAB" "fold heading"))
    ("TOGGLES"
     ("SPC t k" "context key bar") ("SPC t z · Z" "zen · fullscreen zen") ("SPC t L" "light/dark theme")
     ("SPC t l" "line numbers") ("SPC t w" "line wrap") ("SPC t b" "big font")
     ("SPC t f" "flycheck") ("SPC t s" "spell check") ("SPC t F" "frame fullscreen"))
    ("INSERT"
     ("SPC i s" "snippet") ("SPC i y" "kill ring paste") ("SPC i e" "emoji")
     ("SPC i u" "unicode char") ("SPC i f" "file path") ("SPC i r" "registers"))
    ("HELP"
     ("SPC h k" "what does key do") ("SPC h f · v" "describe fn · var") ("SPC h m" "current modes")
     ("SPC h w" "where is cmd") ("SPC h t" "load theme") ("SPC h G" "emacs guide")
     ("SPC h l" "last keys pressed") ("SPC h e" "messages log")))
  "Sections shown by `+lv/cheatsheet'.")

(defun +lv/cheatsheet--box (sec w kw)
  (let* ((title (car sec)) (rows (cdr sec))
         (b (lambda (s) (propertize s 'face 'shadow))))
    (append
     (list (concat (funcall b "╭─ ")
                   (propertize title 'face '(:inherit font-lock-function-name-face :weight bold))
                   " " (funcall b (make-string (max 1 (- w (length title) 3)) ?─)) (funcall b "╮")))
     (mapcar (lambda (r)
               (concat (funcall b "│") " "
                       (propertize (truncate-string-to-width (car r) kw nil ?\s) 'face '(:inherit font-lock-keyword-face :weight bold))
                       (truncate-string-to-width (cadr r) (- w kw 1) nil ?\s) (funcall b "│")))
             rows)
     (list (funcall b (concat "╰" (make-string w ?─) "╯"))))))

(defun +lv/cheatsheet ()
  "Show the floating key cheatsheet."
  (interactive)
  (let* ((w 38) (kw 16) (gap "  ")
         (cols (max 1 (min 3 (/ (- (frame-width) 2) (+ w 4)))))
         (secs (copy-sequence +lv/cheatsheet-sections))
         (buf (get-buffer-create "*cheatsheet*")))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert "\n  " (propertize "DOOM · S1B" 'face '(:inherit error :weight bold))
                "   leader " (propertize "SPC" 'face '(:inherit font-lock-constant-face :weight bold))
                (propertize "  ·  q close  ·  j/k scroll  ·  SPC ? menus  ·  SPC h k explain any key\n\n" 'face 'shadow))
        (while secs
          (let* ((row (cl-loop repeat cols while secs
                               collect (+lv/cheatsheet--box (pop secs) w kw)))
                 (n (apply #'max (mapcar #'length row))))
            (dotimes (i n)
              (insert "  " (mapconcat (lambda (box) (or (nth i box) (make-string (+ w 2) ?\s)))
                                      row gap)
                      "\n"))
            (insert "\n"))))
      (special-mode)
      (setq-local cursor-type nil mode-line-format nil truncate-lines t)
      (goto-char (point-min)))
    (pop-to-buffer buf)))

(set-popup-rule! "^\\*cheatsheet\\*$" :side 'bottom :size 0.9 :select t :quit t :ttl 0)

(map! :leader
      (:prefix "h" :desc "Key cheatsheet" "j" #'+lv/cheatsheet)
      (:prefix "b" :desc "Dashboard (home)" "h" #'+doom-dashboard/open))
