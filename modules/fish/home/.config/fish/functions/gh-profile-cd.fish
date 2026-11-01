function gh-profile-cd --on-variable PWD
    # Kill switch
    if set -q GH_PROFILE_DISABLED
        return
    end
    
    # Only run if in a git repo
    if not git rev-parse --git-dir > /dev/null 2>&1
        return
    end
    
    # Detect profile
    set -l profile (gh-profile-detect)
    
    # Skip if no profile
    if test "$profile" = "none"
        return
    end
    
    # Read current profile
    set -l state_file "$HOME/.local/state/gh-profile/current"
    set -l current "none"
    if test -f "$state_file"
        set current (cat "$state_file")
    end
    
    # Switch only if profile changed
    if test "$profile" != "$current"
        gh-use "$profile"
    end
end
