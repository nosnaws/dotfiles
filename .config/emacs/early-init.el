;;; early-init.el --- Runs before init.el, before the UI is initialized

;; Disable package.el — we use straight.el instead
(setq package-enable-at-startup nil)

;; Remove UI chrome before it renders to avoid flicker
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;; Maximize GC threshold during startup for speed, reset after
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

;; Suppress native compilation warnings
(setq native-comp-async-report-warnings-errors 'silent)
