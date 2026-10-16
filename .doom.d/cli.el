;;; cli.el -*- lexical-binding: t; -*-
;; Never persist secrets or agent-session vars into ~/.emacs.d/.local/env
;; (doom env / doom sync). Added 2026-10-16.
(defvar doom-env-deny)
(setq doom-env-deny
      (append '("TOKEN" "SECRET" "PASSWORD" "PASSWD" "_KEY$" "API_KEY" "CREDENTIAL"
                "MISTRAL" "^CURSOR_" "^SAND_" "^BITFLOW_")
              (bound-and-true-p doom-env-deny)))
