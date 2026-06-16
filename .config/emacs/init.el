;;; init.el --- Main entry point

;;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Emacs 30 bundles transient 0.7.2.2 which lacks the :environment slot
;; required by gptel. Force straight's newer version onto load-path first.
(straight-use-package 'transient)

;;; Load PATH from login shell — required on macOS GUI Emacs
(use-package exec-path-from-shell
  :config
  (when (or (daemonp) (memq window-system '(mac ns x)))
    (dolist (var '("ANTHROPIC_API_KEY"))
      (add-to-list 'exec-path-from-shell-variables var))
    (exec-path-from-shell-initialize)))

;;; Sensible global defaults
(setq-default
 fill-column 80
 tab-width 2
 indent-tabs-mode nil
 sentence-end-double-space nil
 truncate-lines t)

(setq
 inhibit-startup-message t
 inhibit-startup-echo-area-message t
 initial-scratch-message nil
 ring-bell-function 'ignore
 ;; Keep auto-save and backups out of the working tree
 create-lockfiles nil
 make-backup-files nil
 auto-save-default nil)

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1)  ;; reload files changed on disk
(save-place-mode 1)           ;; remember cursor position
(recentf-mode 1)              ;; track recently opened files
(electric-pair-mode 1)        ;; auto-close brackets
(show-paren-mode 1)

;; Relative line numbers (like vim)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;;; Load modules
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'core)
(require 'ui)
(require 'completion)
(require 'projects)
(require 'lsp-config)
(require 'langs)
(require 'org-config)
(require 'ai)
