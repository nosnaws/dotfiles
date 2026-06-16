;;; ui.el --- Themes, fonts, and visual settings

;;; ef-themes — system-aware light/dark switching
(use-package ef-themes
  :config
  (setq ef-themes-to-toggle '(ef-day ef-dream))

  (defun alec/apply-theme (appearance)
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('light (load-theme 'ef-day :no-confirm))
      ('dark  (load-theme 'ef-dream :no-confirm))))

  ;; React to system appearance changes (macOS)
  (add-hook 'ns-system-appearance-change-functions #'alec/apply-theme)

  ;; Apply theme once a frame exists — ns-system-appearance may not be
  ;; bound until after the first frame is created
  (if (daemonp)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (with-selected-frame frame
                    (alec/apply-theme (or ns-system-appearance 'dark)))))
    (add-hook 'after-init-hook
              (lambda ()
                (alec/apply-theme (if (boundp 'ns-system-appearance)
                                      ns-system-appearance
                                    'dark))))))

;;; nerd-icons — required by doom-modeline
;; Run M-x nerd-icons-install-fonts once after first install
(use-package nerd-icons)

;;; doom-modeline
(use-package doom-modeline
  :after nerd-icons
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 28)
  (doom-modeline-bar-width 3)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-vcs-max-length 20))

;;; Font: Hack
(defun alec/set-font ()
  (set-face-attribute 'default nil
                      :font "Hack"
                      :height 140))  ;; 14pt — adjust to taste

;; Handle both normal startup and daemon mode (no frame on daemon start)
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (alec/set-font))))
  (alec/set-font))

(provide 'ui)
