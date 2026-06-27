;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "João Bertholino"
      user-mail-address "comercial.bertholino@gmail.com")

(setq doom-theme 'doom-one-light)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

;;; LaTeX Config
(after! latex

  (defun my/latex-force-cleanup ()
    "Limpeza bruta via shell para garantir que nenhum arquivo auxiliar reste."
    (let* ((base-dir (projectile-project-root))
           ;; Lista de extensões que queremos exterminar
           (exts '("aux" "bbl" "blg" "idx" "ind" "lof" "lot" "out" "toc"
                   "acn" "acr" "alg" "glg" "glo" "gls" "fls" "log"
                   "fdb_latexmk" "snm" "synctex.gz" "nav" "vrb"))
           ;; Constrói o comando find para rodar no terminal
           (find-cmd (format "find %s -type f \\( %s \\) -delete"
                             base-dir
                             (mapconcat (lambda (e) (format "-name \"*.%s\"" e)) exts " -o "))))

      ;; Executa o comando no background
      (shell-command find-cmd)
      (message "Limpeza forçada via shell concluída.")))

  ;; Executa 2 segundos após o término da compilação para garantir que o
  ;; LaTeX liberou os arquivos (o atraso evita erros de "file busy")
  (add-hook 'TeX-after-compilation-finished-functions
            (lambda (&rest _)
              (run-with-timer 2 nil #'my/latex-force-cleanup)))

  ;; Auto-save
  (setq auto-save-visited-interval 0.5)
  (auto-save-visited-mode +1)

  (setq-default TeX-engine 'luatex)
  (setq TeX-command-default "LatexMk"
        TeX-save-query nil
        TeX-parse-self t
        TeX-auto-save t
        TeX-electric-sub-and-superscript t)

  (add-to-list 'TeX-command-list
               '("LatexMk" "latexmk -pvc -lualatex -interaction=nonstopmode %t"
                 TeX-run-command nil t))

  (setq TeX-view-program-selection '((output-pdf "Zathura")))
  (setq TeX-source-correlate-mode t
        TeX-source-correlate-start-server t)

  (setq font-latex-fontify-script t
        font-latex-fontify-sectioning 'color)

  (setq LaTeX-indent-level 2
        LaTeX-item-indent 2
        TeX-brace-indent-level 2
        LaTeX-top-newline-count 2
        LaTeX-electric-left-right-brace t)

  (add-hook 'LaTeX-mode-hook #'cdlatex-mode)
  (add-hook 'LaTeX-mode-hook #'LaTeX-preview-setup)
  (add-hook 'LaTeX-mode-hook #'flyspell-mode)
  (add-hook 'LaTeX-mode-hook #'wc-mode)
  (add-hook 'LaTeX-mode-hook #'TeX-fold-mode)
  (add-hook 'LaTeX-mode-hook #'auto-fill-mode)

  (setq preview-auto-cache-preamble t
        preview-scale-function 1.3
        ispell-program-name "aspell"
        ispell-dictionary "pt_BR"
        TeX-fold-auto t
        fill-column 90))

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

(map! :after latex
      :map LaTeX-mode-map
      :leader
      "b" #'TeX-command-master
      "v" #'TeX-view
      "k" #'TeX-kill-job
      "l" #'TeX-recenter-output-buffer
      "e" #'LaTeX-environment
      "s" #'LaTeX-section
      "m" #'TeX-insert-macro
      "p p" #'preview-at-point
      "p b" #'preview-buffer
      "p c" #'preview-clearout-buffer
      "f f" #'TeX-fold-dwim
      "f b" #'TeX-fold-buffer
      "f c" #'TeX-fold-clearout-buffer
      "r" #'citar-insert-citation
      "S" #'ispell-buffer)
