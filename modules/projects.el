;;; projects.el --- Project creation, terminal and browser commands -*- lexical-binding: nil; -*-

(defun my/project-file (directory filename content)
  (let ((path (expand-file-name filename directory)))
    (unless (file-exists-p path)
      (make-directory (file-name-directory path) t)
      (with-temp-file path
        (insert content)))
    path))

(defun my/create-project ()
  (interactive)
  (let* ((language (completing-read
                    "Language: "
                    '("LaTeX" "Python" "Emacs Lisp" "Common Lisp")))
         (name (read-string "Project name: "))
         (directory (file-name-as-directory
                     (expand-file-name name (expand-file-name "~/Projects/"))))
         (file (pcase language
                 ("LaTeX" (my/project-file directory "main.tex" ""))
                 ("Python" (my/project-file directory "main.py" ""))
                 ("Emacs Lisp" (my/project-file directory "main.el" ""))
                 ("Common Lisp" (my/project-file directory "main.lisp" ""))
                 (_ (my/project-file directory "README.md" "")))))
    (projectile-add-known-project directory)
    (find-file file)))

(defun my/open-home-terminal ()
  (interactive)
  (let ((default-directory (expand-file-name "~/")))
    (vterm "*terminal: ~*")))

(defun my/open-graphical-browser ()
  (interactive)
  (start-process "zen-browser" nil "zen-browser"
                 (read-string "Address: " "https://")))
