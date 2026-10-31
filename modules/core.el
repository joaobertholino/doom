;;; core.el --- Identity, appearance and editor defaults -*- lexical-binding: nil; -*-

(setq user-full-name "João Bertholino"
      user-mail-address "comercial.bertholino@gmail.com"
      doom-theme 'doom-dracula)

(custom-set-faces!
  '(default :background "#000000")
  '(solaire-default-face :background "#000000")
  '(magit-background :background "#000000")
  '(neo-banner-face :background "#000000")
  '(neo-root-dir-face :background "#000000")
  '(fringe :background "#000000"))

(setq display-line-numbers-type t
      fancy-splash-image "~/.config/doom/logo-splash/doom-emacs-logo.png"
      org-directory "~/Org-Notes/"
      org-agenda-files '("~/Org-Notes/tarefas.org" "~/Org-Notes/projetos.org")
      auto-save-visited-interval 0.5)

(auto-save-visited-mode +1)
