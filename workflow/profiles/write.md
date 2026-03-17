# ✍️ Profile: Deep Writing & Org-Mode

For documentation, notes, long-form writing, and complex project management via Doom Emacs.

---

## Intent

Create a focused, distraction-free environment for:
- Writing documentation and guides
- Managing projects with org-mode
- Git workflows via Magit
- Literate programming and notebooks
- Deep work sessions (hours-long focus)

---

## What This Profile Does

**Entrypoint:** `ws-write`

**Tool:** `doom emacs` (terminal mode, no GUI)

**Session Structure:**
```
Emacs starts with:
  • Org-agenda on the left
  • Main editor buffer (center)
  • Dired file browser on the right (optional)
  • Magit for git workflows
```

**Workflow:**
1. Run `ws-write`
2. Emacs opens in terminal (-nw flag)
3. Org-mode is ready for your `.org` files
4. Magit available for git operations (`Ctrl+g`)
5. Vterm opens for shell commands (`Ctrl+c Ctrl+o`)

**Session Lifespan:**
- Long (typically 1-4 hour deep work blocks)
- Can be paused and resumed
- Persistent buffer history within the session

---

## When to Use

✅ **Use write profile when:**
- Writing documentation (README, guides, tutorials)
- Managing org-mode files and tasks
- Complex git workflows (staging, rebasing, cherry-picks)
- Need org-agenda for project planning
- Literate programming in Org Babel
- Long-form writing that needs structure

❌ **Don't use when:**
- Quick code edits (use `ws-local` with nvim)
- SSH'ing to servers (use `ws-remote`)
- No org-mode workflow
- Only need a plain text editor

---

## Keybindings

### Emacs + Evil Mode (Vim keys)

**Navigation:**
- `hjkl` — Move cursor (Vim-style)
- `Ctrl+u` / `Ctrl+d` — Page up/down
- `gg` — Go to beginning of file
- `G` — Go to end of file
- `w` / `b` — Next/previous word
- `/` — Search (forward)
- `?` — Search (backward)

**Editing:**
- `i` — Insert mode
- `a` — Append after cursor
- `o` — Open new line below
- `O` — Open new line above
- `dd` — Delete line
- `yy` — Yank line
- `p` — Paste
- `u` — Undo
- `Ctrl+r` — Redo

### Org-Mode Specific
- `Tab` — Expand/collapse heading
- `Shift+Tab` — Expand/collapse all headings
- `M-j` / `M-k` — Move subtree up/down
- `M-l` / `M-h` — Promote/demote heading
- `Ctrl+c Ctrl+a` — Open org-agenda
- `Ctrl+c Ctrl+s` — Schedule task
- `Ctrl+c Ctrl+d` — Set deadline
- `Ctrl+c Ctrl+t` — Cycle TODO state (TODO → DONE → ...)

### Magit (Git)
- `Ctrl+g` — Open Magit status
- In Magit window:
  - `s` — Stage file
  - `u` — Unstage file
  - `c` — Commit
  - `p` — Push
  - `l` — Log
  - `r` — Rebase
  - `? + m` — Full Magit help

### Doom Emacs Specifics
- `SPC` — Doom leader key (when not in insert mode)
- `SPC :` — Run command
- `SPC f` — File operations
- `SPC s` — Search
- `SPC b` — Buffer operations
- `SPC p` — Project operations

### Terminal (Vterm)
- `Ctrl+c Ctrl+o` — Toggle vterm
- Once in vterm:
  - Normal shell commands
  - `Ctrl+c Ctrl+j` — Switch back to normal Emacs mode
  - `Ctrl+c Ctrl+k` — Kill vterm process

---

## Configuration

Your existing Doom Emacs setup applies:
- **Doom config:** `~/.doom.d/config.el` (unchanged)
- **Modules:** `~/.doom.d/init.el` (unchanged)
- **Packages:** `~/.doom.d/packages.el` (unchanged)

The `ws-write` script **only**:
1. Starts Emacs in terminal mode
2. Opens org-agenda for the day
3. Respects your `.doom.d` configuration

---

## Example Workflows

### Workflow 1: Writing documentation

```bash
$ ws-write
# Emacs opens with org-agenda
# Create a new buffer: Ctrl+g :e <filename>.org

## In Emacs:
* Project Documentation
** Getting Started
*** Installation
*** Configuration
** API Reference
** Troubleshooting

# Navigate and edit:
/ search for "Installation"
i (insert mode)
# Write content
Esc (back to normal mode)

# Save:
Ctrl+x Ctrl+s

# Export to HTML/PDF:
Ctrl+c Ctrl+e
# Select export format (h = HTML, p = PDF)
```

### Workflow 2: Project planning with org-agenda

```bash
$ ws-write
# Emacs opens

# View tasks:
Ctrl+c Ctrl+a
# See org-agenda view

# Add new task:
Ctrl+g :e ~/org/tasks.org
i (insert)
* TODO Implement feature X
SCHEDULED: <2025-01-15 Wed>
** Steps to take:
- [ ] Write tests
- [ ] Implement logic
- [ ] Code review

# Update completion:
Ctrl+c Ctrl+t  (cycle TODO state)
```

### Workflow 3: Complex git workflow

```bash
$ ws-write
# In Emacs, working on a file

# Open Magit for git operations:
Ctrl+g (opens Magit status)

# Stage changes:
Navigate to file with hjkl
s (stage)

# Create commit:
c (opens commit message buffer)
i (insert mode)
Fix: Update documentation for API endpoint
Esc (exit insert)
Ctrl+c Ctrl+c (confirm commit)

# Push to remote:
p (push)
Select branch
```

### Workflow 4: Literate programming with org-babel

```bash
$ ws-write
# Open a .org file:
Ctrl+g :e ~/literate-program.org

# Create a code block:
i (insert)
#+BEGIN_SRC python
def hello():
    print("Hello, world!")
#+END_SRC

# Execute the block:
Ctrl+c Ctrl+c (with cursor in block)
# Output appears below block

# Tangle to file:
Ctrl+c Ctrl+v Ctrl+t
# Extracts code blocks into source file
```

---

## Tips & Tricks

### Use a Daemon for Faster Launches
```bash
# Start the Emacs daemon once:
emacs --daemon

# Then use emacsclient for fast startup:
emacsclient -c -nw
# or set an alias:
alias e='emacsclient -c -nw'
```

### Org Capture for Quick Notes
```bash
# From anywhere, press: Ctrl+c c
# Quick capture template opens
# Add note, save with Ctrl+c Ctrl+c
# Note goes to your inbox for later processing
```

### Multiple Buffers and Windows
```bash
# Split window:
Ctrl+x 2 (horizontal split)
Ctrl+x 3 (vertical split)

# Switch between buffers:
Ctrl+x b
# Type buffer name or arrow through list

# Close window:
Ctrl+x 0
```

### Agenda Filtering
```bash
# In org-agenda:
Ctrl+c Ctrl+a
# View agenda
/ t (filter by tags)
/ l (filter by level)
/ d (filter by dates)
```

### Spell-check & Grammar
```bash
# Enable spell check:
M-x flyspell-mode

# Navigate errors:
Alt+= (go to next error)
Alt+- (go to previous error)

# Correct:
i (insert mode)
# Fix typo
Esc (back to normal)
```

---

## Integration with Your Tools

### MatteriaTrack time tracking
Open vterm and track your writing time:
```bash
# Ctrl+c Ctrl+o to open vterm
mtrack track -p "Documentation" -t "Write API guide"
# ... write ...
# Ctrl+c Ctrl+j to close vterm
# ... later ...
# Ctrl+c Ctrl+o again
mtrack finish
```

### Magit for version control
Git is first-class in Emacs via Magit:
```bash
Ctrl+g
# Full git interface
# Stage, commit, push, rebase, cherry-pick, blame, etc.
```

### Terminal integration (Vterm)
Run shell commands without leaving Emacs:
```bash
Ctrl+c Ctrl+o
# Now in terminal
npm test
pytest
git log --oneline
# Ctrl+c Ctrl+j back to Emacs
```

### Prism Terminal personas
If your org files reference terminal workflows:
```bash
# In vterm:
prism apply cyber-noir --shell fish
# Your terminal persona is active
```

---

## Customizing Your Doom Emacs Setup

Edit `~/.doom.d/config.el`:

```elisp
;; Customize appearance
(setq doom-theme 'doom-catppuccin)

;; Larger font for writing
(setq doom-font (font-spec :family "JetBrains Mono" :size 14))

;; Org-mode settings
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

;; Auto-save org files
(add-hook 'org-mode-hook 'auto-save-mode)

;; Disable line numbers in org-mode for focus
(add-hook 'org-mode-hook 'turn-off-display-line-numbers-mode)
```

---

## Troubleshooting

### Emacs starts slowly
```bash
# Check if daemon is running:
emacs --daemon

# Use emacsclient for fast launches:
emacsclient -c -nw
```

### Org-agenda not showing tasks
```bash
# Ensure org files are in org-directory:
# Check ~/.doom.d/config.el for org-directory setting

# Manually add org file:
Ctrl+c [ (in an org file)
# Adds file to agenda

# Rebuild agenda:
Ctrl+c Ctrl+a r (rebuild agenda)
```

### Magit not working
```bash
# Ensure git is installed:
which git

# Check Doom has magit loaded:
M-x magit-status
# Should open Magit window
```

### Vterm not opening
```bash
# Check if vterm is installed:
~/.config/emacs/bin/doom describe package vterm

# Rebuild Emacs:
~/.config/emacs/bin/doom sync
~/.config/emacs/bin/doom build
```

### Font rendering issues in terminal
```bash
# Ensure terminal supports 256 colors:
echo $TERM

# Set to xterm-256color:
export TERM=xterm-256color
```

---

## Comparison: Write vs Local vs Remote

| Aspect | `ws-write` (Emacs) | `ws-local` (Zellij) | `ws-remote` (Tmux) |
|--------|-------------------|---------------------|-------------------|
| **Best for** | Writing, org-mode | Coding, testing | Infrastructure |
| **Startup speed** | Slow (2-3s) | Instant | Instant |
| **Git integration** | Magit (best) | Command-line | Command-line |
| **Org-mode** | ✅ Perfect | ❌ Limited | ❌ Limited |
| **Terminal** | Vterm (embedded) | Native shell | Native shell |
| **Learning curve** | Steep | Shallow | Shallow |

---

## Next Steps

1. **Try it:** `ws-write`
2. **Explore org-mode:** `Ctrl+c Ctrl+a` for agenda
3. **Learn Magit:** `Ctrl+g` and read the help
4. **Customize:** Edit `~/.doom.d/config.el` for your preferences

See [README.md](../README.md) for the full orchestration system.

