;;; version-control.el --- Magit and Git change indicators -*- lexical-binding: nil; -*-

(after! magit
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        magit-save-repository-buffers 'dontask
        epg-pinentry-mode 'loopback))

(after! vc-gutter
  (setq +vc-gutter-default-style 'thick
        vc-gutter:update-interval 1.0))
