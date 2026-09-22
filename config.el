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
      org-directory "~/org-mode/"
      org-agenda-files '("~/org-mode/tarefas.org" "~/org-mode/projetos.org")
      auto-save-visited-interval 0.1)

(auto-save-visited-mode +1)
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
  (xwidget-webkit-browse-url (read-string "Address: " "https://")))

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

(setq +dashboard-functions
      '(+dashboard-widget-banner +dashboard-widget-shortmenu)
      +dashboard-banner-vertical-padding '(1 . 1)
      +dashboard-menu-sections
      '(("Open file"
         :icon (nerd-icons-octicon "nf-oct-file" :face '+dashboard-menu-title)
         :action find-file)
        ("Open project"
         :icon (nerd-icons-octicon "nf-oct-briefcase" :face '+dashboard-menu-title)
         :action projectile-switch-project)
        ("Create new project"
         :icon (nerd-icons-octicon "nf-oct-play" :face '+dashboard-menu-title)
         :action my/create-project)
        ("Open home terminal"
         :icon (nerd-icons-octicon "nf-oct-terminal" :face '+dashboard-menu-title)
         :action my/open-home-terminal)
        ("Open browser"
         :icon (nerd-icons-octicon "nf-oct-globe" :face '+dashboard-menu-title)
         :action my/open-graphical-browser)
        ("Open private configuration"
         :icon (nerd-icons-octicon "nf-oct-tools" :face '+dashboard-menu-title)
         :when (file-directory-p doom-user-dir)
         :action doom/open-private-config)))

(after! latex
  (defun my/latex-force-cleanup ()
    (let* ((base-dir (shell-quote-argument
                      (expand-file-name
                       (or (projectile-project-root)
                           (file-name-directory (or (buffer-file-name) default-directory))))))
           (exts '("aux" "bbl" "blg" "idx" "ind" "lof" "lot" "out" "toc"
                   "acn" "acr" "alg" "glg" "glo" "gls" "fls" "log"
                   "fdb_latexmk" "snm" "synctex.gz" "nav" "vrb"))
           (find-cmd (format "find %s -type f \\( %s \\) -delete"
                             base-dir
                             (mapconcat (lambda (e) (format "-name \"*.%s\"" e)) exts " -o "))))
      (shell-command find-cmd)
      (message "Limpeza forçada em subdiretórios concluída.")))

  (add-hook 'TeX-after-compilation-finished-functions
            (lambda (&rest _)
              (run-with-timer 2 nil #'my/latex-force-cleanup)))

  (setq-default TeX-engine 'luatex)
  (setq TeX-command-default "LatexMk"
        TeX-save-query nil
        TeX-parse-self t
        TeX-auto-save t
        TeX-electric-sub-and-superscript t
        TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-source-correlate-mode t
        TeX-source-correlate-start-server t
        font-latex-fontify-script t
        font-latex-fontify-sectioning 'color
        LaTeX-indent-level 1
        LaTeX-item-indent 1
        TeX-brace-indent-level 2
        LaTeX-top-newline-count 2
        LaTeX-electric-left-right-brace t
        preview-auto-cache-preamble t
        preview-scale-function 1.3
        ispell-program-name "aspell"
        ispell-dictionary "pt_BR"
        TeX-fold-auto t
        fill-column 90)

  (add-to-list 'TeX-command-list
               '("LatexMk" "latexmk -pvc -lualatex -interaction=nonstopmode %t"
                 TeX-run-command nil t))

  (dolist (hook '(cdlatex-mode LaTeX-preview-setup flyspell-mode
                  wc-mode TeX-fold-mode auto-fill-mode))
    (add-hook 'LaTeX-mode-hook hook))

  (map! :map LaTeX-mode-map
        :leader
        "b"     #'TeX-command-master
        "v"     #'TeX-view
        "k"     #'TeX-kill-job
        "l"     #'TeX-recenter-output-buffer
        "e"     #'LaTeX-environment
        "s"     #'LaTeX-section
        "m"     #'TeX-insert-macro
        "p p"   #'preview-at-point
        "p b"   #'preview-buffer
        "p c"   #'preview-clearout-buffer
        "f f"   #'TeX-fold-dwim
        "f b"   #'TeX-fold-buffer
        "f c"   #'TeX-fold-clearout-buffer
        "r"     #'citar-insert-citation
        "S"     #'ispell-buffer))

(after! citar
  (setq citar-bibliography '("~/Documents/refs.bib")
        citar-library-paths '("~/Documents/papers/")
        citar-notes-paths '("~/Documents/notes/"))
  (with-eval-after-load 'embark
    (citar-embark-mode +1)))

(after! lsp-latex
  (setq lsp-latex-texlab-executable "texlab"
        lsp-latex-build-on-save nil
        lsp-latex-lint-on-save t))

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

(after! magit
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        magit-save-repository-buffers 'dontask
        epg-pinentry-mode 'loopback))

(after! vc-gutter
  (setq +vc-gutter-default-style 'thick
        vc-gutter:update-interval 1.0))

(after! markdown-mode
  (setq markdown-command "pandoc")
  (add-hook 'markdown-mode-hook #'pandoc-mode))

(after! pandoc-mode
  (setq pandoc-use-test-pdf t))

(setq auto-mode-alist
      (cl-remove-if (lambda (entry) (eq (cdr entry) 'zathura-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

(after! doom-modeline
  (setq doom-modeline-time t
        doom-modeline-time-icon nil
        doom-modeline-time-live-icon nil
        display-time-24hr-format t
        display-time-format "%A, %d de %B de %Y — %H:%M")
  (display-time-mode +1))

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

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :config
  (setq copilot-indent-offset-warning-disable t)
  :bind (("C-TAB" . copilot-accept-completion-by-word)
         ("C-<tab>" . copilot-accept-completion-by-word)
         :map copilot-mode-map
         ("<tab>" . copilot-accept-completion)
         ("TAB" . copilot-accept-completion)))
