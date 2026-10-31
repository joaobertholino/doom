;;; org.el --- Org agenda, tasks and capture -*- lexical-binding: nil; -*-

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(p)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
        org-todo-keyword-faces
        '(("TODO"        . org-todo)
          ("IN-PROGRESS" . (+doom-themes-color 'blue))
          ("WAITING"     . (+doom-themes-color 'yellow))
          ("DONE"        . (+doom-themes-color 'green))
          ("CANCELLED"   . (+doom-themes-color 'red)))
        org-default-notes-file (expand-file-name "task.org" org-directory)
        org-capture-templates
        '(("t" "New Task" entry (file+headline "task.org" "Inbox")
           "* TODO %?\n  Create in: %U\n  %i" :prepend t)
          ("p" "Project ideia" entry (file+headline "project.org" "Ideias")
           "* TODO %?\n  %i" :prepend t)))

  (advice-add 'org-agenda-quit :before #'org-save-all-org-buffers)

  (map! :leader
        (:prefix-map ("o" . "open")
         :desc "Org Agenda" "a" #'org-agenda
         :desc "Org Capture" "c" #'org-capture)))
