# Error Fixes for Neovim Setup

## Errors Found

1. ❌ **PHPActor build failed** - Missing PHP `iconv` extension
2. ❌ **Rustaceanvim config error** - Fixed configuration syntax

## Fixes Applied

### ✅ 1. Rustaceanvim Configuration (FIXED)

**Problem:** Configuration used `opts` with `server.on_attach` which rustaceanvim doesn't support.

**Solution:** Changed to use `config` function with autocmd pattern.

**File:** `~/.config/nvim/lua/plugins/rust.lua` (already fixed)

### ⚠️ 2. PHP iconv Extension (NEEDS YOUR ACTION)

**Problem:** PHPActor requires PHP's `iconv` extension, which is disabled by default in Arch Linux.

**Quick Fix (run this command):**

```bash
fix-php-iconv
```

This script will enable the iconv extension in `/etc/php/php.ini`.

**Manual Fix (if script doesn't work):**

```bash
# 1. Edit PHP configuration
sudo nvim /etc/php/php.ini

# 2. Find this line (around line 900):
;extension=iconv

# 3. Remove the semicolon to uncomment:
extension=iconv

# 4. Save and exit (:wq)

# 5. Verify it worked:
php -m | grep iconv
# Should output: iconv
```

## After Fixing iconv

Once iconv is enabled, restart Neovim and sync plugins:

```bash
nvim
:Lazy clean   # Remove failed phpactor
:Lazy sync    # Reinstall all plugins
```

PHPActor should now install successfully!

## Verification

After running `:Lazy sync`, verify everything works:

```vim
:checkhealth mason    # Should show no errors
:checkhealth lsp      # Should show no errors
```

Open a PHP file and check:

```vim
:LspInfo              # Should show phpactor attached
```

## Alternative: Skip PHPActor (Not Recommended)

If you can't fix iconv and want to proceed without PHPActor:

1. Remove PHPActor from the config:
```bash
rm ~/.config/nvim/lua/plugins/php-laravel.lua
```

2. You'll lose refactoring features but can still use Neovim for PHP

**However, I recommend fixing iconv instead - PHPActor is essential for professional PHP refactoring!**

## Summary

- ✅ **Rustaceanvim:** Fixed and working
- ⏳ **PHPActor:** Waiting for you to enable iconv extension
- ✅ **Python plugins:** Should work fine
- ✅ **Other plugins:** Should work fine

**Next step:** Run `fix-php-iconv` then restart Neovim!
