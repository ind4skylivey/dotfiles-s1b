;;; doom-s1b-cyber-light-theme.el --- Cyberpunk light theme with pastel purple -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Light sibling of doom-outrun-electric: same accent roles (keywords magenta,
;; functions cyan, types/yellow, strings periwinkle, variables violet), every
;; accent >= 4.5:1 on both bg and bg-alt.
;; Light companion for doom-outrun-electric: pastel purple paper, ink-violet
;; text and neon accents darkened enough to stay readable on a light bg.
;;
;;; Code:

(require 'doom-themes)

(def-doom-theme doom-s1b-cyber-light
  "Cyberpunk light theme: pastel purple background, ink violet text, neon accents."
  :family 'doom-s1b-cyber
  :background-mode 'light

  ;; name        default   256       16
  ((bg         '("#e9dcf7" "#eeddff" "white"        ))
   (fg         '("#2a1b3d" "#2a1b3d" "black"        ))
   (bg-alt     '("#dccbf0" "#ddccee" "white"        ))
   (fg-alt     '("#4a3fa8" "#4a3fa8" "brightblack"  ))

   (base0      '("#f3eafc" "#f3eafc" "white"        ))
   (base1      '("#e2d3f4" "#e2d3f4" "brightblack"  ))
   (base2      '("#d4c1ec" "#d4c1ec" "brightblack"  ))
   (base3      '("#c3ade0" "#c3ade0" "brightblack"  ))
   (base4      '("#9d86bb" "#9d86bb" "brightblack"  ))
   (base5      '("#6a5a85" "#6a5a85" "brightblack"  ))
   (base6      '("#4a3a63" "#4a3a63" "brightblack"  ))
   (base7      '("#35264b" "#35264b" "brightblack"  ))
   (base8      '("#1a0f28" "black"   "black"        ))

   (grey       '("#55577a" "#55577a" "gray"         ))
   (red        '("#ae0029" "#ae0029" "red"          ))
   (orange     '("#983214" "#983214" "brightred"    ))
   (green      '("#326100" "#326100" "green"        ))
   (teal       '("#6a2fd0" "#6a2fd0" "brightgreen"  ))
   (yellow     '("#7a4f00" "#7a4f00" "yellow"       ))
   (blue       '("#0055b0" "#0055b0" "brightblue"   ))
   (dark-blue  '("#2a5a86" "#2a5a86" "blue"         ))
   (magenta    '("#a6007f" "#a6007f" "magenta"      ))
   (violet     '("#7d16c6" "#7d16c6" "brightmagenta"))
   (pink       '("#a8005f" "#a8005f" "brightmagenta"))
   (cyan       '("#00627a" "#00627a" "brightcyan"   ))
   (dark-cyan  '("#005f69" "#005f69" "cyan"         ))

   ;; face categories
   (highlight      blue)
   (vertical-bar   base3)
   (selection      base2)
   (builtin        blue)
   (comments       grey)
   (doc-comments   teal)
   (constants      pink)
   (functions      cyan)
   (keywords       magenta)
   (methods        cyan)
   (operators      magenta)
   (type           yellow)
   (strings        fg-alt)
   (variables      violet)
   (numbers        orange)
   (region         '("#c9afef" "#ccaaee" "brightblack"))
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   (modeline-fg          fg)
   (modeline-fg-alt      base5)
   (modeline-bg          '("#d3bdf0" "#ccbbee" "white"))
   (modeline-bg-alt      bg-alt)
   (modeline-bg-inactive bg-alt)
   (modeline-bg-inactive-alt bg-alt))

  ;;;; Base theme face overrides
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground magenta :weight 'bold)
   (cursor :background magenta)
   (hl-line :background base1 :extend t)
   (region :background region :extend t)
   (vertical-border :foreground base3)
   (mode-line :background modeline-bg :foreground modeline-fg
              :box `(:line-width 1 :color ,magenta))
   (mode-line-inactive :background modeline-bg-inactive :foreground modeline-fg-alt
                       :box `(:line-width 1 :color ,base3))
   (mode-line-emphasis :foreground violet :weight 'bold)
   (tab-bar :background bg-alt :foreground fg)
   (tab-bar-tab :background bg :foreground violet :weight 'bold)
   (tab-bar-tab-inactive :background bg-alt :foreground base5)
   (minibuffer-prompt :foreground violet :weight 'bold)
   (show-paren-match :background base2 :foreground magenta :weight 'bold)
   (isearch :background magenta :foreground base0 :weight 'bold)
   (lazy-highlight :background base3 :foreground fg)
   ;;;; doom-modeline
   (doom-modeline-bar :background magenta)
   (doom-modeline-buffer-file :foreground fg :weight 'bold)
   (doom-modeline-buffer-modified :foreground magenta :weight 'bold)
   (doom-modeline-project-dir :foreground teal :weight 'bold)
   ;;;; org
   (org-level-1 :foreground violet :weight 'bold)
   (org-level-2 :foreground magenta :weight 'bold)
   (org-level-3 :foreground teal :weight 'bold)
   (org-level-4 :foreground orange :weight 'bold)
   (org-level-5 :foreground pink)
   (org-level-6 :foreground dark-blue)
   (org-block :background base0 :extend t)
   (org-block-begin-line :background bg-alt :foreground base5 :extend t)
   (org-code :foreground orange)
   (org-verbatim :foreground teal)
   (org-document-title :foreground violet :weight 'bold)
   ;;;; magit
   (magit-section-heading :foreground violet :weight 'bold)
   (magit-branch-local :foreground teal)
   (magit-branch-remote :foreground green)
   (magit-hash :foreground base5)
   (magit-diff-hunk-heading :background base2 :foreground fg)
   (magit-diff-hunk-heading-highlight :background base3 :foreground fg :weight 'bold)
   (magit-diff-context-highlight :background base1 :foreground fg)
   (magit-diff-added :background (doom-blend green bg 0.15) :foreground green)
   (magit-diff-added-highlight :background (doom-blend green bg 0.25) :foreground green :weight 'bold)
   (magit-diff-removed :background (doom-blend red bg 0.12) :foreground red)
   (magit-diff-removed-highlight :background (doom-blend red bg 0.22) :foreground red :weight 'bold)
   ;;;; lsp / flycheck
   (lsp-face-highlight-textual :background base2 :weight 'bold)
   (lsp-face-highlight-read :background base2 :weight 'bold)
   (lsp-face-highlight-write :background base3 :weight 'bold)
   (lsp-headerline-breadcrumb-symbols-face :foreground violet)
   (lsp-ui-doc-background :background base0)
   (lsp-ui-peek-highlight :background base3 :foreground fg)
   (flycheck-error :underline `(:style wave :color ,red))
   (flycheck-warning :underline `(:style wave :color ,orange))
   (flycheck-info :underline `(:style wave :color ,teal))
   ;;;; keyhelp context bar
   (+lv/ctxbar-desc-face :foreground fg))

  ;;;; Base theme variable overrides
  ())

;;; doom-s1b-cyber-light-theme.el ends here
