;;; ai.el --- AI integrations: gptel, claude-code-ide

;;; gptel — LLM client (GPT, Claude, Gemini, local models)
(use-package gptel
  :demand t
  :config
  (require 'gptel-anthropic)
  (gptel-make-anthropic "Claude"
    :stream t
    :key (lambda () (or (getenv "ANTHROPIC_API_KEY")
                        (error "ANTHROPIC_API_KEY not set"))))
  (setq gptel-backend (gptel-get-backend "Claude")
        gptel-model 'claude-sonnet-4-6))

;;; claude-code-ide — Claude Code IDE integration
(use-package claude-code-ide
  :straight (:host github :repo "manzaltu/claude-code-ide.el")
  :commands (claude-code-ide))

;;; AI keybindings under SPC a
(with-eval-after-load 'general
  (leader!
    "a g" '(gptel-menu        :which-key "GPT menu")
    "a s" '(gptel-send        :which-key "GPT send")
    "a c" '(claude-code-ide   :which-key "Claude Code IDE")))

(provide 'ai)
