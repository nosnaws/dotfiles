;;; org-config.el --- Minimal org-mode setup for writing and tech docs

(use-package org
  :straight nil
  :hook
  (org-mode . visual-line-mode)
  (org-mode . (lambda () (display-line-numbers-mode -1)))  ;; line numbers off in org
  :custom
  (org-directory "~/org")
  (org-hide-emphasis-markers t)    ;; hide *bold* markers, show formatted text
  (org-startup-indented t)
  (org-startup-folded 'content)
  (org-return-follows-link t)
  (org-ellipsis " ▾")
  (org-fontify-whole-heading-line t)
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t))

(use-package org-modern
  :after org
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-star '("◉" "○" "✸" "✿"))
  (org-modern-table t)
  (org-modern-block-fringe nil))

(provide 'org-config)
