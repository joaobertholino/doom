;;; windows.el --- Window and buffer helper commands -*- lexical-binding: nil; -*-

(defun my/switch-buffer-vertically ()
  (interactive)
  (let ((buffer (read-buffer "Buffer: " (other-buffer (current-buffer) t) t)))
    (split-window-right)
    (other-window 1)
    (switch-to-buffer buffer)))

(defun my/switch-buffer-horizontally ()
  (interactive)
  (let ((buffer (read-buffer "Buffer: " (other-buffer (current-buffer) t) t)))
    (split-window-below)
    (other-window 1)
    (switch-to-buffer buffer)))

(defun my/find-file-vertically ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (call-interactively #'find-file))

(defun my/find-file-horizontally ()
  (interactive)
  (split-window-below)
  (other-window 1)
  (call-interactively #'find-file))
