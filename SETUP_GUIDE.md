# Complete Guide: Setting Up Arch Linux Dotfiles on GitHub

This guide documents the complete process of creating, organizing, and pushing your Arch Linux dotfiles to GitHub, including troubleshooting shell configuration issues.

## Table of Contents


1. [Planning the Dotfiles Repository](#planning-the-dotfiles-repository)
2. [Creating the Repository Structure](#creating-the-repository-structure)
3. [Git Configuration and Initial Commit](#git-configuration-and-initial-commit)
4. [Setting Up SSH Authentication](#setting-up-ssh-authentication)
5. [Pushing to GitHub](#pushing-to-github)
6. [Future Updates](#future-updates)
7. [Troubleshooting](#troubleshooting)

---

## Planning the Dotfiles Repository

### Repository Structure Decision

```
~/dotfiles/
├── .config/
│   ├── fish/              # Fish shell configuration
│   ├── zsh/               # Zsh with Zinit and Powerlevel10k
│   ├── nvim/              # Neovim configuration
│   ├── kitty/             # Kitty terminal emulator
│   ├── alacritty/         # Alacritty terminal emulator
│   ├── tmux/              # Tmux multiplexer
│   ├── rofi/              # Application launcher
│   ├── fastfetch/         # System info tool
│   ├── btop/              # Resource monitor
│   ├── dunst/             # Notification daemon
│   ├── picom/             # Compositor
│   ├── cava/              # Audio visualizer
│   ├── micro/             # Text editor
│   ├── yazi/              # File manager
│   ├── zellij/            # Terminal workspace
│   ├── dwm/               # Dynamic window manager
│   └── starship.toml      # Starship prompt config
├── .doom.d/               # Doom Emacs configuration
├── starship.toml          # Alternative starship location
├── lockscreen.sh          # Screen lock script
├── .gitignore             # Git ignore rules
└── README.md              # Documentation
```

### Repository Details

**Name:** `dotfiles` or `arch-dotfiles`

**Description:** "My Arch Linux dotfiles featuring Fish, Zsh, Neovim, DWM, Kitty, Alacritty, and more."

---

## Creating the Repository Structure

### Step 1: Create Base Directory

```bash
mkdir -p ~/dotfiles/.config
```

### Step 2: Copy Configuration Files

```bash
cd ~

# Copy .config directories
cp -r .config/fish .config/zsh .config/nvim .config/kitty .config/alacritty \
      .config/tmux .config/rofi .config/fastfetch .config/btop .config/dunst \
      .config/picom .config/cava .config/micro .config/yazi .config/zellij \
      .config/dwm dotfiles/.config/

# Copy starship config from .config
cp .config/starship.toml dotfiles/.config/

# Copy home directory files
cp -r .doom.d dotfiles/
cp starship.toml lockscreen.sh dotfiles/
```

### Step 3: Create .gitignore

Create `~/dotfiles/.gitignore`:

```gitignore
# Sensitive data
*.log
*.secret
*.token
auth.json
**/github_token*
**/api_key*
*.pem
*.key

# Cache and temporary files
**/.cache/
**/cache/
**/__pycache__/
*.pyc
*.swp
*.swo
*~
.DS_Store

# Zsh cache files
**/.zcompdump*
**/.zsh_history
**/.histfile

# Fish cache
**/.config/fish/fish_variables
**/.config/fish/fishd.*

# Tmux plugins (will be installed by tpm)
**/.config/tmux/plugins/

# Neovim/Vim cache and plugins
**/.config/nvim/plugin/
**/.config/nvim/.netrwhist
**/.config/nvim/undodir/

# Doom Emacs generated files
.doom.d/.local/

# Node modules (if any config uses npm)
**/node_modules/

# Compiled binaries
*.o
*.so
*.out
dwm
st
slstatus
**/dwm/dwm
**/dwm/*.o

# Obsidian vault data (too large)
**/.config/obsidian/

# Game launchers and large apps
**/.config/heroic/
**/.config/legcord/

# IDE specific
**/.idea/
**/.vscode/

# Backup files
*.bak
*.backup
*~
```

**Why these exclusions?**
- **Sensitive data:** Prevents accidental exposure of tokens and keys
- **Cache files:** These are regenerated and waste space
- **Compiled binaries:** Source code only, not build artifacts
- **Large apps:** Game launchers can be gigabytes in size
- **Plugin directories:** Should be managed by plugin managers

### Step 4: Create README.md

See the existing `README.md` in your dotfiles repository for the complete content.

**Key sections to include:**
1. System information
2. List of included configurations
3. Installation instructions
4. Prerequisites and dependencies
5. Post-installation steps
6. Customization notes
7. Update instructions

---

## Git Configuration and Initial Commit

### Step 1: Configure Git Identity

```bash
# Set your username (globally)
git config --global user.name "il1v3y"

# Set your email (use GitHub noreply email for privacy)
git config --global user.email "il1v3y@users.noreply.github.com"
```

**Note:** Using `@users.noreply.github.com` keeps your real email private.

### Step 2: Initialize Repository

```bash
cd ~/dotfiles

# Initialize git repository
git init
```

### Step 3: Stage All Files

```bash
# Add all files (respects .gitignore)
git add .
```

### Step 4: Check What Will Be Committed

```bash
# Review staged files
git status

# Check for any sensitive data
git diff --cached | grep -i "token\|password\|key\|secret"
```

**Important:** Always review what you're about to commit!

### Step 5: Create Initial Commit

```bash
git commit -m "Initial commit: Arch Linux dotfiles

- Shell configs: Fish, Zsh with Zinit and Powerlevel10k
- Terminal emulators: Kitty, Alacritty
- Window manager: DWM with custom patches
- Editors: Neovim, Doom Emacs config
- Tools: Tmux, Rofi, Picom, Dunst, Btop, Yazi, Zellij
- Prompt: Starship configuration
- Scripts: Custom lockscreen script"
```

**Result:**
```
[master (root-commit) dfa2af4] Initial commit: Arch Linux dotfiles
 1615 files changed, 180286 insertions(+)
```

---

## Setting Up SSH Authentication

### Why SSH Over HTTPS?

**SSH Benefits:**
- No need to enter username/password for each push
- More secure with key-based authentication
- Industry standard for git operations
- Works with all git hosts (GitHub, GitLab, etc.)

### Step 1: Generate SSH Key

```bash
# Generate ED25519 key (modern, secure, and fast)
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519 -N ""
```

**Parameters explained:**
- `-t ed25519`: Use ED25519 algorithm (better than RSA)
- `-C "email"`: Comment to identify the key
- `-f ~/.ssh/id_ed25519`: Output file location
- `-N ""`: No passphrase (for convenience; use one for extra security)

**Output:**
```
Generating public/private ed25519 key pair.
Your identification has been saved in /home/il1v3y/.ssh/id_ed25519
Your public key has been saved in /home/il1v3y/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:RU9/mTXDo92SnSYDu5Yjg7MIgfHgBsot5ZOwCVrSELQ ind4skylivey@github.com
```

### Step 2: View Your Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

**Output example:**
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG452vf4LG8+Y+wmwaNIAG7f2tu6n8jR61aU4tyjwdN6 ind4skylivey@github.com
```

**Important:** 
- Only share the `.pub` (public) key
- NEVER share the private key (file without `.pub`)

### Step 3: Add SSH Key to GitHub

1. **Copy your public key:**
   ```bash
   cat ~/.ssh/id_ed25519.pub
   # Copy the entire output
   ```

2. **Go to GitHub SSH settings:**
   - Visit: https://github.com/settings/keys
   - Click: "New SSH key" (green button)

3. **Add the key:**
   - **Title:** "Arch Linux - Main PC" (descriptive name)
   - **Key type:** Authentication Key
   - **Key:** Paste your public key
   - Click: "Add SSH key"

### Step 4: Add GitHub to Known Hosts

```bash
# Add GitHub's SSH fingerprint to known hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts
```

**Why?** Prevents "Host key verification failed" errors.

### Step 5: Test SSH Connection

```bash
ssh -T git@github.com
```

**Expected output:**
```
Hi ind4skylivey! You've successfully authenticated, but GitHub does not provide shell access.
```

**Note:** Exit code 1 is normal - GitHub doesn't provide shell access, only git operations.

---

## Pushing to GitHub

### Step 1: Create Repository on GitHub

1. Go to: https://github.com/new
2. Fill in:
   - **Repository name:** `dotfiles`
   - **Description:** "My Arch Linux dotfiles featuring Fish, Zsh, Neovim, DWM, Kitty, Alacritty, and more"
   - **Visibility:** Public or Private
   - **Important:** Do NOT initialize with README, .gitignore, or license (we already have them)
3. Click: "Create repository"

### Step 2: Rename Branch to 'main'

```bash
cd ~/dotfiles

# Rename master to main (GitHub's default)
git branch -M main
```

**Why?** GitHub uses `main` as the default branch name.

### Step 3: Add Remote Repository

```bash
# Add remote with SSH URL
git remote add origin git@github.com:ind4skylivey/dotfiles.git

# Verify remote
git remote -v
```

**Output:**
```
origin  git@github.com:ind4skylivey/dotfiles.git (fetch)
origin  git@github.com:ind4skylivey/dotfiles.git (push)
```

### Step 4: Push to GitHub

```bash
# Push and set upstream
git push -u origin main
```

**Output:**
```
To github.com:ind4skylivey/dotfiles.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
```

### Step 5: Verify on GitHub

Visit your repository: https://github.com/ind4skylivey/dotfiles

You should see:
- All your configuration files
- README.md displayed on the homepage
- 1615 files committed
- Initial commit message

---

## Future Updates

### Making Changes

```bash
cd ~/dotfiles

# Make your changes (edit files, add new configs, etc.)

# Check what changed
git status
git diff

# Stage changes
git add .

# Or stage specific files
git add .config/nvim/init.lua
git add .config/fish/config.fish

# Commit with descriptive message
git commit -m "Update Neovim config: Add new plugins for LSP"

# Push to GitHub
git push
```

### Syncing Changes from GitHub

```bash
cd ~/dotfiles

# Pull latest changes
git pull origin main
```

### Creating Branches for Experiments

```bash
# Create and switch to a new branch
git checkout -b experimental-theme

# Make changes, commit them
git add .
git commit -m "Experiment: Testing nord theme"

# Push branch to GitHub
git push -u origin experimental-theme

# Switch back to main
git checkout main

# Merge if successful
git merge experimental-theme
git push
```

---

## Troubleshooting

### Problem: "Permission denied (publickey)"

**Cause:** SSH key not properly configured.

**Solutions:**

1. **Check if key is loaded:**
   ```bash
   ssh-add -l
   ```

2. **Add key manually:**
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. **Verify key is on GitHub:**
   - Go to: https://github.com/settings/keys
   - Ensure your public key is listed

4. **Test connection:**
   ```bash
   ssh -T git@github.com
   ```

### Problem: "Host key verification failed"

**Solution:**
```bash
# Add GitHub to known hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

# Or remove existing and re-add
ssh-keygen -R github.com
ssh-keyscan github.com >> ~/.ssh/known_hosts
```

### Problem: Git asks for username/password

**Cause:** Using HTTPS URL instead of SSH.

**Solution:**
```bash
# Check current remote
git remote -v

# If it shows https://, change to SSH
git remote set-url origin git@github.com:USERNAME/REPO.git
```

### Problem: "fatal: not a git repository"

**Cause:** Not in the dotfiles directory.

**Solution:**
```bash
cd ~/dotfiles
# Then run your git commands
```

### Problem: Accidentally committed sensitive data

**Immediate actions:**

1. **Remove from latest commit:**
   ```bash
   # Remove file from commit
   git rm --cached path/to/sensitive/file
   
   # Amend commit
   git commit --amend
   
   # Force push (only if not shared yet!)
   git push --force
   ```

2. **Add to .gitignore:**
   ```bash
   echo "sensitive-file.txt" >> .gitignore
   git add .gitignore
   git commit -m "Update .gitignore"
   ```

3. **For serious leaks (tokens, passwords):**
   - Immediately revoke/rotate the compromised credentials
   - Use tools like `git-filter-repo` or `BFG Repo-Cleaner` to remove from history
   - Consider making the repository private or deleting and recreating

---

## Best Practices

### 1. Regular Commits

```bash
# Commit frequently with clear messages
git commit -m "feat: Add new Neovim keybinding for LSP"
git commit -m "fix: Correct tmux color scheme"
git commit -m "docs: Update README installation steps"
```

### 2. Meaningful Commit Messages

**Good examples:**
- ✅ "Add nord theme to kitty terminal"
- ✅ "Fix: Zsh PATH configuration for IntelliJ"
- ✅ "Update: Neovim LSP config for Rust"

**Bad examples:**
- ❌ "update"
- ❌ "fix stuff"
- ❌ "asdf"

### 3. Review Before Committing

```bash
# Always review what you're committing
git status
git diff

# Check for sensitive data
git diff --cached | grep -iE "token|password|key|secret|api"
```

### 4. Keep Repository Clean

```bash
# Remove untracked files
git clean -fd

# Remove files that should be ignored
git rm --cached file-that-should-be-ignored
```

### 5. Backup Before Major Changes

```bash
# Create a backup branch
git checkout -b backup-$(date +%Y%m%d)
git push -u origin backup-$(date +%Y%m%d)
git checkout main
```

---

## Additional Resources

### Git Commands Reference

```bash
# Status and Info
git status              # Check repository status
git log                 # View commit history
git log --oneline       # Compact commit history
git diff                # Show unstaged changes
git diff --cached       # Show staged changes

# Branching
git branch              # List branches
git branch -a           # List all branches (including remote)
git checkout -b name    # Create and switch to new branch
git branch -d name      # Delete branch

# Remote Operations
git remote -v           # Show remote URLs
git fetch               # Download remote changes
git pull                # Fetch and merge
git push                # Upload local changes

# Undoing Changes
git checkout -- file    # Discard changes in file
git reset HEAD file     # Unstage file
git revert commit-hash  # Create new commit that undoes changes
git reset --hard HEAD   # DANGER: Discard all local changes
```

### SSH Key Management

```bash
# List loaded SSH keys
ssh-add -l

# Load SSH key
ssh-add ~/.ssh/id_ed25519

# Remove all keys from agent
ssh-add -D

# Test GitHub connection
ssh -T git@github.com

# Verbose SSH connection test
ssh -vT git@github.com
```

### Useful Git Aliases

Add to `~/.gitconfig`:

```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --graph --oneline --all
    amend = commit --amend --no-edit
```

---

## Summary

You've successfully:

✅ Fixed shell configuration issues for cross-shell compatibility  
✅ Created a well-organized dotfiles repository  
✅ Set up proper .gitignore to exclude sensitive and unnecessary files  
✅ Configured Git with your identity  
✅ Generated and configured SSH keys for secure authentication  
✅ Pushed your dotfiles to GitHub  
✅ Learned the complete workflow for maintaining dotfiles  

Your dotfiles are now version-controlled, backed up, and ready to be deployed on any machine!

**Repository:** https://github.com/ind4skylivey/dotfiles

---

## Next Steps

Consider:
1. Adding screenshots of your setup to the README
2. Creating installation scripts for automated deployment
3. Using GNU Stow for symlink management
4. Setting up GitHub Actions for automated testing
5. Documenting your keybindings and shortcuts
6. Creating modular configs for different machines

Happy hacking! 🚀
