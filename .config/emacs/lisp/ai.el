;;; ai.el --- AI integrations: gptel, claude-code-ide

;;; gptel — LLM client (GPT, Claude, Gemini, local models)
(use-package gptel
  :demand t
  :custom
  (gptel-default-mode 'org-mode)        ;; dedicated gptel buffers use org-mode
  (gptel-org-branching-context t)       ;; org outline tree defines context branches
  :config
  (require 'gptel-anthropic)
  (gptel-make-anthropic "Claude"
    :stream t
    :key (lambda () (or (getenv "ANTHROPIC_API_KEY")
                        (error "ANTHROPIC_API_KEY not set"))))
  (setq gptel-backend (gptel-get-backend "Claude")
        gptel-model 'claude-sonnet-4-6)
  ;; Branching context uses the heading hierarchy as context, so prompt/response
  ;; delimiters must NOT be headings — otherwise every turn nests a new branch.
  (setf (alist-get 'org-mode gptel-prompt-prefix-alist) "@user\n")
  (setf (alist-get 'org-mode gptel-response-prefix-alist) "@assistant\n"))

;;; eat — pure-elisp terminal, used as claude-code-ide's terminal backend
;; (no native compilation needed, unlike vterm)
(use-package eat)

;;; claude-code-ide — Claude Code IDE integration
(use-package claude-code-ide
  :straight (:host github :repo "manzaltu/claude-code-ide.el")
  :commands (claude-code-ide)
  :custom
  (claude-code-ide-terminal-backend 'eat))

;;; AI keybindings under SPC a
(with-eval-after-load 'general
  (leader!
    "a g" '(gptel-menu        :which-key "GPT menu")
    "a s" '(gptel-send        :which-key "GPT send")
    "a c" '(claude-code-ide   :which-key "Claude Code IDE")))

(provide 'ai)
