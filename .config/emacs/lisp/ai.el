;;; ai.el --- AI integrations: gptel, agent-shell

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

;;; agent-shell — Claude Code IDE integration via ACP
(use-package agent-shell
  :straight t
  :commands (agent-shell agent-shell-anthropic-start-claude-code agent-shell-toggle agent-shell-send-dwim)
  :config
  (setq agent-shell-preferred-agent-config (agent-shell-anthropic-make-claude-code-config))
  ;; Use existing `claude` CLI session for auth (no API key needed)
  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication :login t))
  ;; Evil: normal-state RET submits, insert-state RET inserts newline
  (with-eval-after-load 'evil
    (evil-define-key 'insert agent-shell-mode-map (kbd "RET") #'newline)
    (evil-define-key 'normal agent-shell-mode-map (kbd "RET") #'comint-send-input)
    (add-hook 'diff-mode-hook
              (lambda ()
                (when (string-match-p "\\*agent-shell-diff\\*" (buffer-name))
                  (evil-emacs-state))))))

;;; AI keybindings under SPC a
(with-eval-after-load 'general
  (leader!
    "a g" '(gptel-menu                              :which-key "GPT menu")
    "a s" '(gptel-send                              :which-key "GPT send")
    "a c" '(agent-shell-anthropic-start-claude-code :which-key "Claude Code")
    "a t" '(agent-shell-toggle                      :which-key "toggle Claude shell")
    "a d" '(agent-shell-send-dwim                   :which-key "send region/error")
    "a m" '(agent-shell-set-session-model           :which-key "set model")
    "a T" '(agent-shell-set-session-thought-level   :which-key "set thought level")
    "a M" '(agent-shell-set-session-mode            :which-key "set mode")))

(provide 'ai)
