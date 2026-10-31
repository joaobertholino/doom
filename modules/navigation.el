;;; navigation.el --- Project discovery and navigation keybindings -*- lexical-binding: nil; -*-

(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git" projectile-project-root-files-bottom-up)))

(after! vterm
  (dolist (key-binding '(("M-<up>"    . windmove-up)
                         ("M-<down>"  . windmove-down)
                         ("M-<left>"  . windmove-left)
                         ("M-<right>" . windmove-right)))
    (define-key vterm-mode-map (kbd (car key-binding)) (cdr key-binding))))

(map! "M-<left>"  #'windmove-left
      "M-<right>" #'windmove-right
      "M-<up>"    #'windmove-up
      "M-<down>"  #'windmove-down)

(map! :leader
      :prefix ("b" . "buffer")
      :desc "Abrir buffer verticalmente" "v" #'my/switch-buffer-vertically
      :desc "Abrir buffer horizontalmente" "h" #'my/switch-buffer-horizontally
      :prefix ("f" . "file")
      :desc "Abrir arquivo verticalmente" "v" #'my/find-file-vertically
      :desc "Abrir arquivo horizontalmente" "h" #'my/find-file-horizontally)
