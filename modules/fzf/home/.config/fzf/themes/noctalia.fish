set -l fzf_theme_opts "\
--color=bg+:#20103a
--color=bg:#140022
--color=spinner:#00d9ff
--color=hl:#ff4d6d
--color=fg:#f2e9ff
--color=header:#ff4d6d
--color=info:#c926ff
--color=pointer:#00d9ff
--color=marker:#e6dbfa
--color=fg+:#f2e9ff
--color=prompt:#c926ff
--color=hl+:#ff4d6d
--color=selected-bg:#2e0d50
--color=border:#8a2be2
--color=label:#f2e9ff"

if set -q FZF_DEFAULT_OPTS[1]; and test -n "$FZF_DEFAULT_OPTS"
    set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS
$fzf_theme_opts"
else
    set -Ux FZF_DEFAULT_OPTS "$fzf_theme_opts"
end
