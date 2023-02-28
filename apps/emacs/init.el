(defconst emacs-start-time (current-time-string))

(eval-when-compile
  (require 'use-package))

(defun emacs-path (path)
  (expand-file-name path user-emacs-directory))

(load (emacs-path "settings"))

;;; Packages

(use-package avy
  :bind ("C-'" . avy-goto-char-timer)
  :init
  (avy-setup-default))

(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)))

(use-package corfu
  :init
  (global-corfu-mode))

(use-package direnv
  :config
  (direnv-mode))

(use-package forge
  :after magit)

(use-package go-mode
  :config
  (defun project-find-go-module (dir)
    (when-let ((root (locate-dominating-file dir "go.mod")))
      (cons 'go-module root)))

  (with-eval-after-load 'project
    (add-to-list 'project-find-functions 'project-find-go-module))

  (cl-defmethod project-root ((project (head go-module)))
    (cdr project))

  (add-hook 'go-mode-hook 'eglot-ensure)
  (add-hook 'project-find-functions 'project-find-go-module))

(use-package magit)

(use-package magit-delta
  :hook (magit-mode . magit-delta-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package markdown-mode
  :init
  (setq markdown-command "multimarkdown"))

(use-package nix-mode)

(use-package orderless)

(use-package org
  :bind (("C-c a"  . org-agenda)
         ("C-c c"  . org-capture)
         ("C-c l"  . org-store-link)))

(use-package protobuf-mode)

(use-package rustic
  :config
  (setq rustic-lsp-client 'eglot)
  (setq rustic-format-trigger 'on-save))

(use-package vertico
  :init
  (vertico-mode))

(use-package which-key
  :init
  (which-key-mode))
