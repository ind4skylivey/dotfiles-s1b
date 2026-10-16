;;
;; agent-shell module for Doom Emacs
;; Configuration for LLM agent integration via ACP protocol

;; Ensure packages are loaded
(require 'acp)
(require 'agent-shell)

;; Enable agent-shell UI mode by default
(add-hook 'agent-shell-mode-hook #'agent-shell-ui-mode)

;; Keybindings for agent-shell
(map! :map agent-shell-mode-map
      :leader
      :desc "Send prompt" "p" #'agent-shell-prompt
      :desc "Send input" "s" #'agent-shell-send-input
      :desc "Interrupt" "c" #'agent-shell-interrupt
      :desc "Clear buffer" "C" #'agent-shell-clear-buffer
      :desc "Kill buffer" "k" #'kill-this-buffer)

;; Global keybindings to start agent-shell
(map! :leader
      :desc "Start agent-shell" "a s" #'agent-shell
      :desc "Start Claude" "a c" #'agent-shell-anthropic
      :desc "Start Mistral" "a m" #'agent-shell-mistral
      :desc "Start Google" "a g" #'agent-shell-google
      :desc "Start OpenAI" "a o" #'agent-shell-openai)

;; Authentication configuration for various providers
;; Uncomment the one you want to use

;; ===== Cursor (You have this installed!) =====
;; (setq agent-shell-opencode-authentication
;;       (agent-shell-opencode-make-authentication :login t))

;; ===== Claude (Anthropic) =====
;; For API key:
;; (setq agent-shell-anthropic-authentication
;;       (agent-shell-anthropic-make-authentication
;;        :api-key (lambda () (read-passwd "Anthropic API Key: "))))
;; For login (requires claude-agent-acp):
;; (setq agent-shell-anthropic-authentication
;;       (agent-shell-anthropic-make-authentication :login t))

;; ===== Mistral Vibe =====
;; (setq agent-shell-mistral-authentication
;;       (agent-shell-mistral-make-authentication :login t))

;; ===== Google Gemini =====
;; (setq agent-shell-google-authentication
;;       (agent-shell-google-make-authentication :login t))

;; ===== OpenAI Codex =====
;; (setq agent-shell-openai-authentication
;;       (agent-shell-openai-make-authentication :login t))

;; Environment variables (example for Claude)
;; (setq agent-shell-anthropic-claude-environment
;;       (agent-shell-make-environment-variables
;;        :inherit-env t))

;; Enable clipboard image support if tools are available
(when (executable-find "xclip")
  (setq agent-shell-clipboard-image-handlers
        '((xclip . ("xclip" "-selection" "clipboard" "-t" "image/png" "-o")))))

(when (executable-find "wl-paste")
  (setq agent-shell-clipboard-image-handlers
        '((wl-paste . ("wl-paste" "--type" "image/png")))))
