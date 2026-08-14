;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
(advice-add 'doom-dashboard-widget-banner :filter-args #'my-resize-doom-logo)

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
        TeX-view-program-selection '((output-pdf "Zathura"))
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

(use-package! zathura
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . zathura-mode)))

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

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :config
  (setq copilot-indent-offset-warning-disable t)
  :bind (("C-TAB" . copilot-accept-completion-by-word)
         ("C-<tab>" . copilot-accept-completion-by-word)
         :map copilot-mode-map
         ("<tab>" . copilot-accept-completion)
         ("TAB" . copilot-accept-completion)))
