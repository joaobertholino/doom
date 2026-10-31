;;; copilot.el --- Copilot completion -*- lexical-binding: nil; -*-

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :config
  (setq copilot-indent-offset-warning-disable t)
  :bind (("C-TAB" . copilot-accept-completion-by-word)
         ("C-<tab>" . copilot-accept-completion-by-word)
         :map copilot-mode-map
         ("<tab>" . copilot-accept-completion)
         ("TAB" . copilot-accept-completion)))
