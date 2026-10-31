;;; help.el --- Personal keybinding catalogue -*- lexical-binding: nil; -*-

;; Catálogo de atalhos: SPC h B ou M-x my/open-doom-keybindings-catalog.
(defun my/open-doom-keybindings-catalog ()
  "Abre o catálogo pessoal de atalhos do Doom Emacs em PDF."
  (interactive)
  (let ((pdf (expand-file-name "catalogo/atalhos-doom-emacs.pdf" doom-user-dir)))
    (unless (file-readable-p pdf)
      (user-error "Catálogo não encontrado: %s" pdf))
    (find-file pdf)))

(map! :leader
      :desc "Abrir catálogo de atalhos (PDF)"
      "h B" #'my/open-doom-keybindings-catalog)
